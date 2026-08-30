<script setup lang="ts">
withDefaults(defineProps<{ lines?: number }>(), { lines: 3 })
</script>

<template>
  <div class="flex w-full flex-col gap-4 rounded-xl2 bg-white p-6 shadow-card ring-1 ring-ink/5" aria-hidden="true">
    <div class="h-5 w-24 animate-pulse rounded-full bg-ash/15" />
    <div class="h-6 w-3/4 animate-pulse rounded bg-ash/15" />
    <div class="flex flex-col gap-2">
      <div v-for="i in lines" :key="i" class="h-3 animate-pulse rounded bg-ash/10" :style="{ width: i === lines ? '60%' : '100%' }" />
    </div>
  </div>
</template>
