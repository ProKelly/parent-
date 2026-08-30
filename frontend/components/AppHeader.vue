<script setup lang="ts">
withDefaults(defineProps<{ tone?: 'on-paper' | 'on-ink' }>(), { tone: 'on-paper' })
</script>

<template>
  <header
    class="mx-auto flex w-full max-w-md items-center justify-between px-5 pt-6"
    :class="tone === 'on-ink' ? 'text-white' : 'text-ink'"
  >
    <Logo :size="30" />
    <NuxtLink
      to="/login"
      class="rounded-full border px-3 py-1.5 text-xs font-semibold transition-colors focus-ring"
      :class="tone === 'on-ink' ? 'border-white/30 hover:bg-white/10' : 'border-ink/15 hover:bg-ink/5'"
    >
      Account
    </NuxtLink>
  </header>
</template>
