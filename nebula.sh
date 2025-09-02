#!/bin/bash
# =======================================
# Nebula Theme Installer for Pterodactyl
# Made 9/2/2025 by mominaluchifg-ship-it
# Covers: Admin + User Panels + Login
# =======================================

PANEL_DIR="/var/www/pterodactyl"
THEME_URL="https://raw.githubusercontent.com/mominaluchifg-ship-it/nebula-theme/main"

echo "🌌 Installing Nebula Theme for Pterodactyl..."

# Go to panel
cd $PANEL_DIR || { echo "❌ Panel not found!"; exit 1; }

# Download CSS files
curl -o public/nebula.css $THEME_URL/nebula.css
curl -o public/nebula-login.css $THEME_URL/nebula-login.css
curl -o public/nebula-admin.css $THEME_URL/nebula-admin.css

# Inject into main layout
if ! grep -q "nebula.css" resources/views/layouts/app.blade.php; then
    sed -i '/<\/head>/i <link rel="stylesheet" href="/nebula.css">' resources/views/layouts/app.blade.php
    sed -i '/<\/head>/i <link rel="stylesheet" href="/nebula-admin.css">' resources/views/layouts/app.blade.php
fi

# Inject into login page
if ! grep -q "nebula-login.css" resources/views/layouts/auth.blade.php; then
    sed -i '/<\/head>/i <link rel="stylesheet" href="/nebula-login.css">' resources/views/layouts/auth.blade.php
fi

# Clear cache
php artisan view:clear
php artisan cache:clear

echo "✅ Nebula Theme Installed! Refresh your browser 🌌"
