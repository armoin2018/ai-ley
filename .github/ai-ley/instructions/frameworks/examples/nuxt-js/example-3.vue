<!-- pages/index.vue -->
<template>
  <div class="container mx-auto px-4 py-8">
    <h1 class="text-4xl font-bold text-center mb-8">
      Welcome to Nuxt 3
    </h1>
    <div class="grid md:grid-cols-2 gap-8">
      <Card
        title="Server-Side Rendering"
        description="Built-in SSR for better SEO and performance"
        icon="="
      />
      <Card
        title="Auto-imports"
        description="Automatic imports for components and composables"
        icon="¡"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
// Auto-imported composables
const { data: posts } = await $fetch('/api/posts')

// SEO meta tags
useSeoMeta({
  title: 'Home | My Nuxt App',
  description: 'Welcome to my amazing Nuxt application',
  ogImage: '/og-image.jpg'
})

// Page-level middleware
definePageMeta({
  middleware: 'auth'
})
</script>