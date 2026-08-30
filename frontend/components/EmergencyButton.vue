<script setup lang="ts">
// "Fixed red emergency button, reachable in one tap from any screen"
// Lives in app.vue so it renders above every page, including on a
// locked/low-scroll view. Deliberately simple: no confirmation modal,
// no extra taps — the whole point is zero friction during a crisis.
// Hidden only on /emergency itself, where it would be redundant.
const route = useRoute()
const router = useRouter()

const visible = computed(() => route.path !== '/emergency')

function trigger() {
  router.push('/emergency')
}
</script>

<template>
  <button
    v-if="visible"
    aria-label="Get help now"
    class="group fixed bottom-24 right-5 z-50 flex h-16 w-16 items-center justify-center rounded-full bg-alert text-white shadow-soft transition-transform active:scale-95 focus-ring"
    @click="trigger"
  >
    <span
      class="absolute inset-0 rounded-full bg-alert motion-safe:animate-pulse-ring"
      aria-hidden="true"
    />
    <span class="relative text-2xl" aria-hidden="true">🤲</span>
  </button>
</template>
