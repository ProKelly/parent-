<script setup lang="ts">
// The single decorative flourish in the app: two oversized echoes of the
// shield mark, drifting almost imperceptibly. Used once per screen, low
// opacity, purely atmospheric — never behind text that needs full contrast.
withDefaults(defineProps<{ tone?: 'on-paper' | 'on-ink' }>(), { tone: 'on-paper' })
</script>

<template>
  <div class="pointer-events-none absolute inset-0 overflow-hidden" aria-hidden="true">
    <svg
      class="absolute -right-16 -top-20 h-72 w-72 opacity-[0.07] motion-safe:animate-drift"
      :class="tone === 'on-ink' ? 'text-mint' : 'text-ink'"
      viewBox="0 0 100 100"
      fill="currentColor"
    >
      <path d="M50 8 C27 8 14 22 14 42 C14 68 30 86 50 96 C70 86 86 68 86 42 C86 22 73 8 50 8 Z" />
    </svg>
    <svg
      class="absolute -left-20 bottom-[-4rem] h-56 w-56 opacity-[0.05] motion-safe:animate-drift-slow"
      :class="tone === 'on-ink' ? 'text-mint' : 'text-ink'"
      viewBox="0 0 100 100"
      fill="currentColor"
    >
      <path d="M50 8 C27 8 14 22 14 42 C14 68 30 86 50 96 C70 86 86 68 86 42 C86 22 73 8 50 8 Z" />
    </svg>
  </div>
</template>
