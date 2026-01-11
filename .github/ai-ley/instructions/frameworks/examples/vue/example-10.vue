<template>
  <!-- Use v-show for frequently toggled elements -->
  <div v-show="isVisible">Frequently toggled content</div>

  <!-- Use v-if for conditionally rendered elements -->
  <div v-if="user.isAdmin">Admin only content</div>

  <!-- Use key for list reordering -->
  <div v-for="item in items" :key="item.id">
    {{ item.name }}
  </div>

  <!-- Lazy load components -->
  <Suspense>
    <AsyncComponent />
    <template #fallback>
      <div>Loading...</div>
    </template>
  </Suspense>
</template>

<script setup lang="ts">
import { defineAsyncComponent } from 'vue';

const AsyncComponent = defineAsyncComponent(() => import('@/components/HeavyComponent.vue'));
</script>