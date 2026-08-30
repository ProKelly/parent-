<script setup lang="ts">
// "Fixed red emergency button, reachable in one tap from any screen"
// Lives in app.vue so it renders above every page, including on a
// locked/low-scroll view. Deliberately simple: no confirmation modal,
// no extra taps — the whole point is zero friction during a crisis.
const router = useRouter()

function trigger() {
  router.push('/emergency')
}
</script>

<template>
  <button
    aria-label="Get help now"
    class="fixed bottom-6 right-5 z-50 flex h-16 w-16 items-center justify-center rounded-full bg-alert text-white shadow-lg shadow-alert/40 transition-transform active:scale-95 focus-ring"
    @click="trigger"
  >
    <span class="text-2xl" aria-hidden="true">🤲</span>
  </button>
</template>
