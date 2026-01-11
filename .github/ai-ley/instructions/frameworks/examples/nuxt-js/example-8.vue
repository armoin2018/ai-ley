<!-- layouts/default.vue -->
<template>
  <div class="min-h-screen bg-gray-50">
    <Header />
    <main class="container mx-auto px-4 py-8">
      <slot />
    </main>
    <Footer />
  </div>
</template>

<script setup lang="ts">
// Global layout logic
const { $colorMode } = useNuxtApp()
</script>