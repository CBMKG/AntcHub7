require('dotenv').config();
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const axios = require('axios');

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const validKeys = new Map();
const keyExpiry = new Map();

const DEFAULT_KEYS = {
    'DEVELOPER-LIFETIME-2025': { tier: 'DEVELOPER', isLifetime: true },
    'PREMIUM-30DAYS': { tier: 'PREMIUM', isLifetime: false, validFor: 30 * 24 * 60 * 60 },
    'BASIC-11H': { tier: 'BASIC', isLifetime: false, validFor: 11 * 60 * 60 }
};

Object.entries(DEFAULT_KEYS).forEach(([key, data]) => {
    validKeys.set(key, data);
    if (!data.isLifetime) {
        keyExpiry.set(key, Date.now() + data.validFor * 1000);
    }
});

const DISCORD_WEBHOOKS = {
    keyTracking: process.env.KEY_TRACKING_WEBHOOK,
    developerActivity: process.env.DEVELOPER_ACTIVITY_WEBHOOK,
    allActivity: process.env.ALL_ACTIVITY_WEBHOOK
};

if (!DISCORD_WEBHOOKS.keyTracking || !DISCORD_WEBHOOKS.developerActivity || !DISCORD_WEBHOOKS.allActivity) {
    console.warn('⚠️  WARNING: Discord webhook URLs not configured in .env file!');
    console.warn('⚠️  Please copy .env.example to .env and configure your webhook URLs');
    console.warn('⚠️  Webhook forwarding will not work until configured!');
}

async function sendToDiscord(webhookUrl, data) {
    if (!webhookUrl) {
        const error = new Error('Discord webhook URL not configured');
        error.code = 'WEBHOOK_NOT_CONFIGURED';
        throw error;
    }
    
    await axios.post(webhookUrl, data, {
        headers: { 'Content-Type': 'application/json' }
    });
    console.log('✅ Discord webhook sent successfully');
}

app.post('/webhook/verify', async (req, res) => {
    try {
        const { key, userId, hwid } = req.body;
        
        console.log('📝 Key verification request:', { key, userId, hwid });

        if (!key) {
            return res.json({
                valid: false,
                message: 'Key tidak ditemukan'
            });
        }

        const keyData = validKeys.get(key);
        
        if (!keyData) {
            console.log('❌ Invalid key:', key);
            return res.json({
                valid: false,
                message: 'Key tidak valid atau tidak ditemukan'
            });
        }

        if (!keyData.isLifetime) {
            const expiryTime = keyExpiry.get(key);
            if (expiryTime && Date.now() > expiryTime) {
                console.log('⏰ Key expired:', key);
                return res.json({
                    valid: false,
                    message: 'Key sudah kadaluarsa'
                });
            }
        }

        console.log('✅ Key valid:', key, 'Tier:', keyData.tier);
        
        res.json({
            valid: true,
            tier: keyData.tier,
            isLifetime: keyData.isLifetime,
            validFor: keyData.validFor,
            expiresAt: keyData.isLifetime ? null : keyExpiry.get(key) / 1000
        });

    } catch (error) {
        console.error('❌ Error in key verification:', error);
        res.status(500).json({
            valid: false,
            message: 'Server error: ' + error.message
        });
    }
});

app.post('/webhook/discord/key-tracking', async (req, res) => {
    try {
        const data = req.body;
        console.log('📤 Forwarding to Discord Key Tracking webhook');
        
        await sendToDiscord(DISCORD_WEBHOOKS.keyTracking, data);
        
        res.json({ success: true });
    } catch (error) {
        console.error('❌ Error forwarding to Discord:', error);
        
        if (error.code === 'WEBHOOK_NOT_CONFIGURED') {
            res.status(400).json({ 
                success: false, 
                error: error.message,
                code: 'WEBHOOK_NOT_CONFIGURED'
            });
        } else {
            res.status(500).json({ 
                success: false, 
                error: 'Failed to send Discord webhook: ' + error.message,
                code: 'DISCORD_ERROR'
            });
        }
    }
});

app.post('/webhook/discord/developer-activity', async (req, res) => {
    try {
        const data = req.body;
        console.log('📤 Forwarding to Discord Developer Activity webhook');
        
        await sendToDiscord(DISCORD_WEBHOOKS.developerActivity, data);
        
        res.json({ success: true });
    } catch (error) {
        console.error('❌ Error forwarding to Discord:', error);
        
        if (error.code === 'WEBHOOK_NOT_CONFIGURED') {
            res.status(400).json({ 
                success: false, 
                error: error.message,
                code: 'WEBHOOK_NOT_CONFIGURED'
            });
        } else {
            res.status(500).json({ 
                success: false, 
                error: 'Failed to send Discord webhook: ' + error.message,
                code: 'DISCORD_ERROR'
            });
        }
    }
});

app.post('/webhook/discord/all-activity', async (req, res) => {
    try {
        const data = req.body;
        console.log('📤 Forwarding to Discord All Activity webhook');
        
        await sendToDiscord(DISCORD_WEBHOOKS.allActivity, data);
        
        res.json({ success: true });
    } catch (error) {
        console.error('❌ Error forwarding to Discord:', error);
        
        if (error.code === 'WEBHOOK_NOT_CONFIGURED') {
            res.status(400).json({ 
                success: false, 
                error: error.message,
                code: 'WEBHOOK_NOT_CONFIGURED'
            });
        } else {
            res.status(500).json({ 
                success: false, 
                error: 'Failed to send Discord webhook: ' + error.message,
                code: 'DISCORD_ERROR'
            });
        }
    }
});

app.post('/webhook/generate-key', (req, res) => {
    try {
        const { tier = 'BASIC', duration = 11 } = req.body;
        const keyId = Math.random().toString(36).substring(2, 15).toUpperCase();
        const newKey = `${tier}-${keyId}`;
        
        const isLifetime = tier === 'DEVELOPER' || tier === 'LIFETIME';
        const validFor = isLifetime ? null : duration * 60 * 60;
        
        const keyData = {
            tier: tier,
            isLifetime: isLifetime,
            validFor: validFor
        };
        
        validKeys.set(newKey, keyData);
        
        if (!isLifetime) {
            keyExpiry.set(newKey, Date.now() + validFor * 1000);
        }
        
        console.log('🔑 New key generated:', newKey, 'Tier:', tier);
        
        res.json({
            success: true,
            key: newKey,
            tier: tier,
            isLifetime: isLifetime,
            validFor: validFor
        });
    } catch (error) {
        console.error('❌ Error generating key:', error);
        res.status(500).json({ success: false, error: error.message });
    }
});

app.get('/webhook/keys', (req, res) => {
    const keys = [];
    validKeys.forEach((data, key) => {
        const expiryTime = keyExpiry.get(key);
        keys.push({
            key: key,
            tier: data.tier,
            isLifetime: data.isLifetime,
            expiresAt: expiryTime ? new Date(expiryTime).toISOString() : 'Never',
            isExpired: expiryTime ? Date.now() > expiryTime : false
        });
    });
    res.json({ keys });
});

app.get('/', (req, res) => {
    res.json({
        status: 'online',
        service: 'ANTC Hub Webhook Server',
        endpoints: {
            verify: '/webhook/verify',
            keyTracking: '/webhook/discord/key-tracking',
            developerActivity: '/webhook/discord/developer-activity',
            allActivity: '/webhook/discord/all-activity',
            generateKey: '/webhook/generate-key',
            listKeys: '/webhook/keys'
        }
    });
});

app.listen(PORT, '0.0.0.0', () => {
    console.log('🚀 ANTC Hub Webhook Server berjalan di port', PORT);
    console.log('📍 Server URL: http://0.0.0.0:' + PORT);
    console.log('✅ Siap menerima webhook dari Roblox script!');
    console.log('\n📋 Default Keys:');
    validKeys.forEach((data, key) => {
        console.log(`   - ${key} (${data.tier}${data.isLifetime ? ' - Lifetime' : ''})`);
    });
});
