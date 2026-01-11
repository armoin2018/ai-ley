# 1. Setup development environment
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

# 2. Development build with watch
npx tailwindcss -i ./src/styles/tailwind.css -o ./dist/output.css --watch

# 3. Production build with minification
npx tailwindcss -i ./src/styles/tailwind.css -o ./dist/output.css --minify

# 4. Build integration with popular tools
npm run dev          # Vite/webpack dev server
npm run build        # Production build
npm run preview      # Preview build

# 5. Analyze bundle size
npm install -D @tailwindcss/typography
npx tailwindcss -i input.css -o output.css --content './src/**/*.html' --verbose