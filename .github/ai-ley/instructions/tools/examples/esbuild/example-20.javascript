// Monorepo build script
const path = require('path')
const esbuild = require('esbuild')

const packages = [
  'packages/ui',
  'packages/utils',
  'packages/core'
]

async function buildAllPackages() {
  const builds = packages.map(pkg => {
    const pkgJson = require(path.join(pkg, 'package.json'))

    return esbuild.build({
      entryPoints: [path.join(pkg, 'src/index.ts')],
      bundle: true,
      outfile: path.join(pkg, 'dist/index.js'),
      platform: 'browser',
      target: ['es2020'],
      format: 'esm',
      external: Object.keys(pkgJson.peerDependencies || {}),
      sourcemap: true
    })
  })

  await Promise.all(builds)
  console.log('All packages built successfully!')
}