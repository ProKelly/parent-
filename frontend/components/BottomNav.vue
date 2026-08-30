<script setup lang="ts">
const route = useRoute()
const visible = computed(() => route.path !== '/emergency')

const items = [
  { to: '/', label: 'Home', icon: '🏠' },
  { to: '/mentor', label: 'Mentor', icon: '🧸' },
  { to: '/safehub', label: 'Safe Hub', icon: '📍' },
]
</script>

<template>
  <nav
    v-if="visible"
    class="fixed inset-x-0 bottom-0 z-40 flex justify-around border-t border-ink/10 bg-paper/95 pb-[env(safe-area-inset-bottom)] pt-2 backdrop-blur"
  >
    <NuxtLink
      v-for="item in items"
      :key="item.to"
      :to="item.to"
      class="flex flex-col items-center gap-0.5 rounded-xl2 px-6 py-1.5 text-xs font-semibold text-ash transition-colors focus-ring"
      active-class="!text-ink bg-mint/15"
    >
      <span class="text-xl" aria-hidden="true">{{ item.icon }}</span>
      {{ item.label }}
    </NuxtLink>
  </nav>
</template>
