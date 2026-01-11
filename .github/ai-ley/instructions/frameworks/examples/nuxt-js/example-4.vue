<!-- components/Card.vue -->
<template>
  <div class="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition-shadow">
    <div class="flex items-center mb-4">
      <span class="text-2xl mr-3">{{ icon }}</span>
      <h2 class="text-xl font-semibold">{{ title }}</h2>
    </div>
    <p class="text-gray-600">{{ description }}</p>
    <slot />
  </div>
</template>

<script setup lang="ts">
interface Props {
  title: string
  description: string
  icon?: string
}

withDefaults(defineProps<Props>(), {
  icon: '=Ä'
})
</script>