# Manifest 500 Error Fix - Deployment Guide

## Problem
The manifest.webmanifest file was returning a 500 error because Django's catch-all route was trying to serve it as HTML instead of as a JSON file with the correct MIME type.

## Solution Applied
Added dedicated URL routes in `school/urls.py` to serve manifest files with the correct `application/manifest+json` MIME type **before** the catch-all route.

## Changes Made

### File: `school/urls.py`

1. **Added a `serve_manifest()` function** that:
   - Searches for manifest files in multiple locations (staticfiles, frontend/dist, STATIC_ROOT)
   - Serves them with the correct `application/manifest+json` content type
   - Handles both `.webmanifest` and `.json` extensions
   - Adds proper caching headers

2. **Added URL routes** for:
   - `/static/manifest.webmanifest`
   - `/static/manifest.json`
   - `/manifest.webmanifest` (root level)
   - `/manifest.json` (root level)

These routes are placed **before** the catch-all SPA route to ensure they're matched first.

## Deployment Steps for Production (cPanel)

### Option 1: Using File Manager (Recommended for single file)
1. Log in to your cPanel
2. Navigate to File Manager
3. Go to `public_html/nedbdmis/school/`
4. Find `urls.py`
5. Click "Edit" and replace the entire content with the updated version
6. Save the file
7. Restart your application:
   - Go to "Setup Python App" in cPanel
   - Click "Restart" button for your application

### Option 2: Using Git (Recommended for version control)
```bash
# On your local machine
git add school/urls.py
git commit -m "Fix manifest.webmanifest 500 error - add dedicated routes with correct MIME type"
git push origin main

# Then on your server (via SSH or cPanel Terminal)
cd ~/public_html/nedbdmis
git pull origin main

# Restart the application
touch tmp/restart.txt
# OR use the cPanel "Setup Python App" interface to restart
```

### Option 3: Using FTP/SFTP
1. Connect to your server using FileZilla or similar FTP client
2. Navigate to `public_html/nedbdmis/school/`
3. Upload the updated `urls.py` file
4. Restart your application via cPanel

## Verification

After deployment, test the manifest file by visiting:
- https://auth-system.bdmis.co.ke/static/manifest.webmanifest
- https://auth-system.bdmis.co.ke/manifest.webmanifest

Both should:
- Return HTTP 200 status (not 500)
- Have `Content-Type: application/manifest+json` header
- Display the JSON content

You can verify using browser DevTools:
1. Open your site
2. Press F12 to open DevTools
3. Go to Network tab
4. Refresh the page
5. Look for `manifest.webmanifest` in the network requests
6. Check that it shows status 200 and correct content type

## Additional Notes

- The fix handles both `.webmanifest` and `.json` extensions for maximum compatibility
- Caching is set to 1 hour (3600 seconds) for better performance
- The function searches multiple locations to ensure it finds the manifest file regardless of your static files setup
- This fix works with both development (DEBUG=True) and production (DEBUG=False) environments

## Rollback Plan

If you need to rollback, you can restore the previous version of `urls.py` from your Git history or backup.
