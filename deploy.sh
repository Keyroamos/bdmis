#!/bin/bash
# Deployment Script for Production Server
# This script prepares files for deployment to cPanel

echo "========================================="
echo "BDMIS Production Deployment Preparation"
echo "========================================="
echo ""

# Step 1: Build Frontend
echo "Step 1: Building frontend..."
cd frontend
npm run build
if [ $? -ne 0 ]; then
    echo "ERROR: Frontend build failed!"
    exit 1
fi
echo "✓ Frontend build completed"
echo ""

# Step 2: Collect Static Files
echo "Step 2: Collecting static files..."
cd ..
python manage.py collectstatic --noinput
if [ $? -ne 0 ]; then
    echo "ERROR: collectstatic failed!"
    exit 1
fi
echo "✓ Static files collected"
echo ""

# Step 3: Create deployment checklist
echo "Step 3: Creating deployment checklist..."
cat > DEPLOYMENT_CHECKLIST.txt << 'EOF'
DEPLOYMENT CHECKLIST
====================

Files to Upload to Production Server:
--------------------------------------

1. CRITICAL FILES (Must upload):
   ✓ school/urls.py (Contains manifest fix)
   ✓ staticfiles/manifest.webmanifest
   ✓ staticfiles/manifest.json
   ✓ staticfiles/index.html
   ✓ staticfiles/assets/* (All files in assets folder)
   ✓ staticfiles/registerSW.js

2. Upload Locations on cPanel:
   - school/urls.py → ~/public_html/nedbdmis/school/urls.py
   - staticfiles/* → ~/public_html/nedbdmis/staticfiles/*

3. After Upload:
   ✓ Restart Python application in cPanel
   ✓ Clear browser cache
   ✓ Test manifest URL: https://auth-system.bdmis.co.ke/static/manifest.webmanifest

4. Verification Steps:
   ✓ Check manifest returns 200 (not 500)
   ✓ Check Content-Type is application/manifest+json
   ✓ Check main app loads without errors
   ✓ Check browser console for any errors

5. Rollback Plan (if needed):
   - Keep backup of old urls.py
   - Can restore from Git history

EOF

echo "✓ Deployment checklist created"
echo ""

echo "========================================="
echo "Build Complete!"
echo "========================================="
echo ""
echo "Next Steps:"
echo "1. Review DEPLOYMENT_CHECKLIST.txt"
echo "2. Upload files to production server"
echo "3. Restart application in cPanel"
echo "4. Verify manifest loads correctly"
echo ""
