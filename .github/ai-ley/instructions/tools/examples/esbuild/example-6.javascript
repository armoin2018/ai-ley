// React build configuration
const reactConfig = {
  entryPoints: ['src/index.tsx'],
  bundle: true,
  outfile: 'dist/bundle.js',
  platform: 'browser',
  target: ['es2020'],
  format: 'esm',
  jsx: 'automatic', // React 17+ automatic JSX transform
  jsxFactory: 'React.createElement', // For older React versions
  jsxFragment: 'React.Fragment',
  jsxDev: process.env.NODE_ENV === 'development',
  loader: {
    '.js': 'jsx',
    '.ts': 'tsx'
  },
  define: {
    'process.env.NODE_ENV': JSON.stringify(process.env.NODE_ENV)
  },
  external: ['react', 'react-dom']
}