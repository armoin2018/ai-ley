# Install Ionic CLI globally
npm install -g @ionic/cli

# Create new Ionic app with Angular (default)
ionic start myApp tabs --type=angular
ionic start myApp blank --type=angular

# Create with React
ionic start myApp tabs --type=react
ionic start myApp blank --type=react

# Create with Vue
ionic start myApp tabs --type=vue
ionic start myApp blank --type=vue

# Navigate and serve
cd myApp
ionic serve