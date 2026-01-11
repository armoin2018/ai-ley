// Watch mode
async function startWatcher() {
  const ctx = await esbuild.context({
    entryPoints: ['src/index.js'],
    bundle: true,
    outdir: 'dist',
    sourcemap: true
  })

  await ctx.watch()
  console.log('Watching...')
}

// Development server
async function startServer() {
  const ctx = await esbuild.context({
    entryPoints: ['src/index.js'],
    bundle: true,
    outdir: 'dist',
    sourcemap: true
  })

  const { host, port } = await ctx.serve({
    servedir: 'dist',
    port: 8000,
    host: 'localhost'
  })

  console.log(`Server running at http://${host}:${port}`)
}

// Combined watch and serve
async function develop() {
  const ctx = await esbuild.context({
    entryPoints: ['src/index.js'],
    bundle: true,
    outdir: 'dist',
    sourcemap: true,
    banner: {
      js: '(() => new EventSource("/esbuild").addEventListener("change", () => location.reload()))();'
    }
  })

  await ctx.watch()
  await ctx.serve({
    servedir: 'dist',
    port: 8000
  })
}