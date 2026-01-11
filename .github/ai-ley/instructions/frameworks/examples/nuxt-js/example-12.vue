<template>
  <div>
    <h1>{{ title }}</h1>
    <ClientOnly>
      <DynamicComponent />
      <template #fallback>
        <div>Loading...</div>
      </template>
    </ClientOnly>
  </div>
</template>