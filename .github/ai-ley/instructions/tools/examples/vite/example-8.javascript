// Vite provides HMR API for custom integrations
if (import.meta.hot) {
  import.meta.hot.accept('./dependency.js', (newModule) => {
    // Handle hot update
  })

  import.meta.hot.dispose((data) => {
    // Cleanup before hot update
  })

  import.meta.hot.invalidate() // Force full reload
}

// Framework-specific HMR (React)
if (import.meta.hot) {
  import.meta.hot.accept('../App', () => {
    // React Fast Refresh handles this automatically
  })
}