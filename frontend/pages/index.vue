<script setup lang="ts">
const tiles = [
  {
    to: '/emergency',
    icon: '🤲',
    title: 'I need calm, now',
    blurb: 'Guided breathing, right away',
    tone: 'bg-alert text-white',
  },
  {
    to: '/mentor',
    icon: '🧸',
    title: 'Pocket Mentor',
    blurb: 'Your child, month by month',
    tone: 'bg-ink text-white',
  },
  {
    to: '/safehub',
    icon: '📍',
    title: 'Safe Hub',
    blurb: 'Find help near you',
    tone: 'bg-mint text-ink',
  },
]
</script>

<template>
  <div class="mx-auto flex max-w-md flex-col gap-6 px-5 pb-6 pt-10">
    <header class="flex flex-col gap-1">
      <p class="text-xs font-semibold uppercase tracking-widest text-mint">YouthParent+</p>
      <h1 class="font-display text-3xl font-extrabold leading-tight text-ink">
        You're doing better than you think.
      </h1>
      <p class="text-ash">Three simple things, whenever you need them.</p>
    </header>

    <div class="flex flex-col gap-4">
      <NuxtLink
        v-for="tile in tiles"
        :key="tile.to"
        :to="tile.to"
        class="flex items-center gap-4 rounded-xl2 p-5 shadow-sm transition-transform active:scale-[0.98] focus-ring"
        :class="tile.tone"
      >
        <span class="text-4xl" aria-hidden="true">{{ tile.icon }}</span>
        <div>
          <p class="font-display text-lg font-bold">{{ tile.title }}</p>
          <p class="text-sm opacity-90">{{ tile.blurb }}</p>
        </div>
      </NuxtLink>
    </div>

    <p class="pt-4 text-center text-xs text-ash">
      Everything here works even without internet. You are not alone.
    </p>
  </div>
  </template>
