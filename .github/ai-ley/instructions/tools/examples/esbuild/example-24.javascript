const config = {
  entryPoints: ['src/index.js'],
  bundle: true,
  outfile: 'dist/bundle.js',
  resolveExtensions: ['.tsx', '.ts', '.jsx', '.js', '.json'],
  mainFields: ['browser', 'module', 'main'],
  conditions: ['browser', 'import', 'require', 'default'],
  external: ['react', 'react-dom'], // Don't bundle these
  alias: {
    '@': path.resolve('./src'),
    'components': path.resolve('./src/components')
  }
}