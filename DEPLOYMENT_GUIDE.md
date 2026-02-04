# 🚀 DEPLOYMENT PACKAGE - Production Fixes
# =========================================

## Overview
This deployment includes fixes for:
1. ✅ Manifest 500 error
2. ✅ Child process crashes (Signal 15)
3. ✅ Memory optimization
4. ✅ Database connection stability
5. ✅ Performance improvements

---

## 📦 Files to Upload to Production

### Critical Files (MUST UPLOAD):

1. **school/urls.py**
   - Location: `~/public_html/nedbdmis/school/urls.py`
   - Purpose: Fixes manifest 500 error
   - Changes: Added dedicated manifest routes

2. **passenger_wsgi.py**
   - Location: `~/public_html/nedbdmis/passenger_wsgi.py`
   - Purpose: Memory optimization
   - Changes: Added garbage collection, reduced memory footprint

3. **school/settings.py**
   - Location: `~/public_html/nedbdmis/school/settings.py`
   - Purpose: Database and cache optimization
   - Changes: Optimized CONN_MAX_AGE, cache size, timeouts

4. **.htaccess**
   - Location: `~/public_html/nedbdmis/.htaccess`
   - Purpose: Passenger configuration
   - Changes: Process limits, memory limits, request timeouts

5. **staticfiles/** (entire directory)
   - Location: `~/public_html/nedbdmis/staticfiles/`
   - Purpose: Updated frontend build with manifest files
   - Changes: New build with manifest.webmanifest and manifest.json

---

## 🔧 Deployment Steps

### Step 1: Backup Current Files
```bash
# SSH into your server
ssh bdmiscok@auth-system.bdmis.co.ke

# Create backup directory
mkdir -p ~/backups/$(date +%Y%m%d_%H%M%S)
cd ~/public_html/nedbdmis

# Backup critical files
cp school/urls.py ~/backups/$(date +%Y%m%d_%H%M%S)/
cp passenger_wsgi.py ~/backups/$(date +%Y%m%d_%H%M%S)/
cp school/settings.py ~/backups/$(date +%Y%m%d_%H%M%S)/
cp .htaccess ~/backups/$(date +%Y%m%d_%H%M%S)/ 2>/dev/null || true
```

### Step 2: Upload Files

**Option A: Using cPanel File Manager**
1. Log in to cPanel
2. Go to File Manager
3. Navigate to `public_html/nedbdmis`
4. Upload each file to its respective location
5. Overwrite when prompted

**Option B: Using Git (Recommended)**
```bash
# On your local machine
git add .
git commit -m "Fix: Manifest 500 error + production stability improvements"
git push origin main

# On server (via SSH)
cd ~/public_html/nedbdmis
git pull origin main
```

**Option C: Using FTP/SFTP**
1. Connect using FileZilla or similar
2. Upload files to their respective locations

### Step 3: Clear Cache
```bash
# SSH into server
cd ~/public_html/nedbdmis

# Clear Django cache
rm -rf django_cache/*

# Clear Python bytecode
find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
find . -name "*.pyc" -delete
```

### Step 4: Restart Application
```bash
# Method 1: Touch restart file
touch tmp/restart.txt

# Method 2: Via cPanel
# Go to "Setup Python App" → Click "Restart" button
```

### Step 5: Verify Deployment
```bash
# Check manifest file
curl -I https://auth-system.bdmis.co.ke/static/manifest.webmanifest

# Should return:
# HTTP/1.1 200 OK
# Content-Type: application/manifest+json

# Check application status
curl https://auth-system.bdmis.co.ke/api/login/

# Monitor logs
tail -f ~/logs/passenger.log
tail -f ~/logs/error_log
```

---

## ✅ Verification Checklist

After deployment, verify:

- [ ] Manifest loads without 500 error
  - Visit: `https://auth-system.bdmis.co.ke/static/manifest.webmanifest`
  - Should return JSON content with 200 status

- [ ] Application loads correctly
  - Visit: `https://auth-system.bdmis.co.ke`
  - Should load without errors

- [ ] No child process crashes in logs
  - Check: `tail -f ~/logs/passenger.log`
  - Should not see "Child process killed" messages

- [ ] Browser console has no errors
  - Open DevTools (F12)
  - Check Console tab
  - Should be clean

- [ ] Static files load correctly
  - CSS, JS, images should all load
  - Check Network tab in DevTools

---

## 📊 Expected Improvements

### Before:
- ❌ Manifest 500 errors
- ❌ Frequent child process crashes
- ❌ High memory usage (>512MB)
- ❌ Slow response times
- ❌ Database locking issues

### After:
- ✅ Manifest loads correctly (200 OK)
- ✅ Stable worker processes
- ✅ Lower memory usage (<400MB)
- ✅ Faster response times
- ✅ No database locks

---

## 🔍 Monitoring (First 24 Hours)

Monitor these metrics:

```bash
# Check memory usage
ps aux | grep python | awk '{sum+=$6} END {print "Memory: " sum/1024 " MB"}'

# Check process count
ps aux | grep passenger | wc -l

# Check error rate
grep -c "Child process killed" ~/logs/passenger.log

# Check response times
tail -f ~/logs/access_log | grep "GET /"
```

---

## 🆘 Troubleshooting

### If manifest still returns 500:
1. Check file exists: `ls -la ~/public_html/nedbdmis/staticfiles/manifest.webmanifest`
2. Check permissions: `chmod 644 ~/public_html/nedbdmis/staticfiles/manifest.webmanifest`
3. Restart application: `touch ~/public_html/nedbdmis/tmp/restart.txt`

### If child processes still crash:
1. Check memory limits in cPanel
2. Reduce `PassengerMaxPoolSize` to 1 in `.htaccess`
3. Contact hosting support to increase limits

### If application won't start:
1. Check error logs: `tail -50 ~/logs/error_log`
2. Check Passenger logs: `tail -50 ~/logs/passenger.log`
3. Verify Python path: `which python3.9`
4. Test WSGI file: `python3.9 passenger_wsgi.py`

---

## 📞 Support

If issues persist after deployment:

1. **Check logs first**:
   - `~/logs/passenger.log`
   - `~/logs/error_log`
   - `~/public_html/nedbdmis/django_cache/`

2. **Contact hosting support** if:
   - Memory limits are too low
   - Process limits are too restrictive
   - Need to increase timeouts

3. **Consider upgrading** if:
   - Shared hosting limits are too restrictive
   - Need more control over resources
   - Application continues to crash

---

## 📝 Rollback Plan

If deployment causes issues:

```bash
# Restore from backup
cd ~/public_html/nedbdmis
BACKUP_DIR=~/backups/YYYYMMDD_HHMMSS  # Replace with actual backup directory

cp $BACKUP_DIR/urls.py school/
cp $BACKUP_DIR/passenger_wsgi.py .
cp $BACKUP_DIR/settings.py school/
cp $BACKUP_DIR/.htaccess .

# Restart application
touch tmp/restart.txt
```

---

## 🎯 Success Criteria

Deployment is successful when:
- ✅ No 500 errors in browser console
- ✅ Manifest loads with 200 status
- ✅ No child process crashes for 24 hours
- ✅ Application responds within 2 seconds
- ✅ Memory usage stays below 400MB

---

**Deployment Date**: _________________
**Deployed By**: _________________
**Verified By**: _________________
**Status**: [ ] Success  [ ] Partial  [ ] Failed
**Notes**: _________________________________________________
