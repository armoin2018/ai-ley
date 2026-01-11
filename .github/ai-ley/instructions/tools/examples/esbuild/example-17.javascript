// Streaming builds for large projects
const fs = require('fs')
const esbuild = require('esbuild')

async function streamingBuild() {
  const result = await esbuild.build({
    entryPoints: ['src/index.js'],
    bundle: true,
    write: false, // Don't write to disk
    format: 'esm'
  })

  // Stream output
  const stream = fs.createWriteStream('dist/bundle.js')
  stream.write(result.outputFiles[0].contents)
  stream.end()
}