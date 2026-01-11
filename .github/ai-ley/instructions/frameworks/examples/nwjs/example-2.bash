# Install nw-builder for packaging
npm install --save-dev nw-builder

# Create build script
cat > build.js << 'EOF'
const nwbuild = require('nw-builder');

const nw = new nwbuild({
    files: './src/**/**',
    platforms: ['win32', 'win64', 'osx64', 'linux32', 'linux64'],
    version: '0.75.0',
    flavor: 'normal',
    macIcns: './assets/icon.icns',
    winIco: './assets/icon.ico'
});

nw.on('log', console.log);

nw.build().then(function () {
   console.log('all done!');
}).catch(function (error) {
    console.error(error);
});
EOF

# Run build
node build.js