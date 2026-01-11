# 1. Setup project with npm
npm init -y
npm install bootstrap @popperjs/core sass --save
npm install webpack webpack-cli sass-loader css-loader style-loader --save-dev

# 2. Create build script
npm pkg set scripts.dev="webpack --mode development --watch"
npm pkg set scripts.build="webpack --mode production"
npm pkg set scripts.serve="python -m http.server 8000"

# 3. Development workflow
npm run dev        # Start development build with watch
npm run serve      # Serve files for testing
npm run build      # Production build

# 4. Testing responsive design
# Use browser dev tools to test all breakpoints:
# - xs: <576px
# - sm: ≥576px
# - md: ≥768px
# - lg: ≥992px
# - xl: ≥1200px
# - xxl: ≥1400px