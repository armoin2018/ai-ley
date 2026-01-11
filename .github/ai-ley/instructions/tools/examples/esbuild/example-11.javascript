// Custom plugin example
const customPlugin = {
  name: 'custom-plugin',
  setup(build) {
    // Intercept file resolution
    build.onResolve({ filter: /^virtual:/ }, args => {
      return {
        path: args.path,
        namespace: 'virtual'
      }
    })

    // Load virtual modules
    build.onLoad({ filter: /.*/, namespace: 'virtual' }, args => {
      return {
        contents: 'export default "Virtual module content"',
        loader: 'js'
      }
    })

    // Transform files
    build.onLoad({ filter: /\.special$/ }, async args => {
      const source = await require('fs').promises.readFile(args.path, 'utf8')
      return {
        contents: `export default ${JSON.stringify(source)}`,
        loader: 'js'
      }
    })
  }
}

// Use plugin in build
esbuild.build({
  entryPoints: ['src/index.js'],
  bundle: true,
  outfile: 'dist/bundle.js',
  plugins: [customPlugin]
})