<script setup lang="ts">
const items = [
  { to: '/', label: 'Home', icon: '🏠' },
  { to: '/mentor', label: 'Mentor', icon: '🧸' },
  { to: '/safehub', label: 'Safe Hub', icon: '📍' },
]
</script>

<template>
  <nav class="fixed bottom-0 left-0 right-0 z-40 flex justify-around border-t border-ink/10 bg-paper/95 py-2 backdrop-blur">
    <NuxtLink
      v-for="item in items"
      :key="item.to"
      :to="item.to"
      class="flex flex-col items-center gap-1 rounded-xl2 px-5 py-1.5 text-xs font-medium text-ash transition-colors focus-ring"
      active-class="!text-ink"
    >
      <span class="text-2xl" aria-hidden="true">{{ item.icon }}</span>
      {{ item.label }}
    </NuxtLink>
  </nav>
