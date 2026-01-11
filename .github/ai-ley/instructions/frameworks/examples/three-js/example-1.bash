# Via npm (recommended for modern projects)
npm install three
npm install -D @types/three

# Via CDN (quick prototyping)
# <script src="https://cdn.jsdelivr.net/npm/three@0.160.0/build/three.min.js"></script>

# Create project with Vite (modern build tool)
npm create vite@latest my-threejs-app -- --template vanilla-ts
cd my-threejs-app
npm install
npm install three
npm install -D @types/three

# Additional useful packages
npm install @tweenjs/tween.js  # Animations
npm install cannon-es         # Physics engine
npm install lil-gui           # Debug GUI
npm install stats.js          # Performance monitoring