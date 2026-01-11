# Create new Cordova project
cordova create myApp com.example.myapp "My App"
cd myApp

# Add platforms
cordova platform add android
cordova platform add ios
cordova platform add browser  # For browser testing

# List installed platforms
cordova platform list

# Check platform requirements
cordova requirements android
cordova requirements ios