<script setup lang="ts">
withDefaults(defineProps<{
  variant?: 'full' | 'mark'
  size?: number
}>(), {
  variant: 'full',
  size: 36,
})
</script>

<template>
  <div class="inline-flex items-center gap-2.5 select-none">
    <svg
      :width="size"
      :height="size"
      viewBox="0 0 100 100"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      aria-hidden="true"
    >
      <!-- The shield: protection -->
      <path
        d="M50 8 C27 8 14 22 14 42 C14 68 30 86 50 96 C70 86 86 68 86 42 C86 22 73 8 50 8 Z"
        fill="#2ED9A3"
      />
      <!-- The sprout: growth, also reads as the "+" in the name -->
      <path
        d="M50 70 L50 44"
        stroke="#0B3D3F"
        stroke-width="6"
        stroke-linecap="round"
      />
      <path
        d="M50 54 C39 51 35 41 41 31 C49 37 51 47 50 54 Z"
        fill="#0B3D3F"
      />
      <path
        d="M50 54 C61 51 65 41 59 31 C51 37 49 47 50 54 Z"
        fill="#0B3D3F"
      />
    </svg>
    <span
      v-if="variant === 'full'"
      class="font-display font-extrabold leading-none tracking-tight"
      :style="{ fontSize: size * 0.5 + 'px' }"
    >
      YouthParent<span class="text-mint">+</span>
    </span>
  </div>
</template>
