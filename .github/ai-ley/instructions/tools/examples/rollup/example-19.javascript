// rollup.config.js for monorepo
import path from 'path'
import { promises as fs } from 'fs'

async function getPackages() {
  const packagesDir = path.resolve('packages')
  const packages = await fs.readdir(packagesDir)

  return packages.map(pkg => ({
    name: pkg,
    input: path.resolve(packagesDir, pkg, 'src/index.ts'),
    outputDir: path.resolve(packagesDir, pkg, 'dist')
  }))
}

export default async () => {
  const packages = await getPackages()

  return packages.map(pkg => ({
    input: pkg.input,
    output: [
      {
        file: path.join(pkg.outputDir, 'index.cjs.js'),
        format: 'cjs',
        exports: 'named'
      },
      {
        file: path.join(pkg.outputDir, 'index.esm.js'),
        format: 'es'
      }
    ],
    external: ['react', 'react-dom'],
    plugins: [
      resolve(),
      commonjs(),
      typescript({
        tsconfig: path.resolve('packages', pkg.name, 'tsconfig.json')
      })
    ]
  }))
}