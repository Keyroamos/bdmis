# Africa's Talking SMS Setup Guide

## Current Configuration Issue

You're getting "The supplied authentication is invalid" error. This means the credentials in your `settings.py` don't match your Africa's Talking account.

## How to Fix

### Step 1: Verify Your Credentials in Africa's Talking Dashboard

1. Log in to your Africa's Talking account: https://account.africastalking.com/
2. Go to **Settings** → **API** (or **API Keys**)
3. Check your **Username** - it should match exactly what's in your dashboard
4. Check your **API Key** - copy it exactly from the dashboard

### Step 2: Update Settings.py

In `school/settings.py`, update these values:

```python
AFRICASTALKING_USERNAME = 'YOUR_EXACT_USERNAME_HERE'  # Must match dashboard exactly
AFRICASTALKING_API_KEY = 'YOUR_API_KEY_HERE'  # Copy exactly from dashboard
SMS_SENDER_ID = 'sandbox'  # For sandbox testing, or your approved sender ID for production
```

**Important Notes:**
- Username is case-sensitive - must match exactly
- API key should start with `atsk_`
- Username is usually not a display name - check your dashboard for the exact username
- If you just generated a new API key, wait 5-10 minutes for it to activate

### Step 3: Test Your Credentials

Run this test script to verify:

```bash
python test_africastalking.py
```

### Step 4: Common Issues

1. **Username Mismatch**: 
   - Your username might be something like `sandbox` or your email username
   - Check your dashboard for the exact username (not display name)

2. **API Key Environment**:
   - Sandbox API keys only work in sandbox mode
   - Production API keys only work in production mode
   - Make sure you're using the right key for the right environment

3. **API Key Not Activated**:
   - New API keys can take 5-10 minutes to activate
   - Wait a bit and try again

4. **Sender ID**:
   - In sandbox, use `'sandbox'` as sender ID
   - In production, you need an approved sender ID from Africa's Talking

### Step 5: Where to Find Your Credentials

1. **Username**: 
   - Dashboard → Settings → Your username should be visible
   - Or check the top-right corner of your dashboard

2. **API Key**:
   - Dashboard → Settings → API Keys
   - Click "Generate" or "View" to see your API key
   - Make sure you copy the full key (starts with `atsk_`)

3. **Sender ID**:
   - For sandbox: Use `'sandbox'`
   - For production: Dashboard → Settings → Sender IDs → Use your approved sender ID

## Test After Fixing

After updating your credentials:

1. Restart your Django server
2. Try sending a test SMS
3. Check the logs for any errors

If it still doesn't work, the test script will show you the exact error message.

