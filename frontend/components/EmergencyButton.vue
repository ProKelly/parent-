<script setup lang="ts">
// "Fixed red emergency button, reachable in one tap from any screen"
// Lives in app.vue so it renders above every page, including on a
// locked/low-scroll view. Deliberately simple: no confirmation modal,
// no extra taps — the whole point is zero friction during a crisis.
// Hidden only on /emergency itself, where it would be redundant.
// Uses v-show (not v-if) so the button stays in the DOM and only its
// CSS display toggles — v-if would add/remove the node on the exact
// same tick as the page transition when navigating to/from
// /emergency, which is what caused the blank-screen bug.
const route = useRoute()
const router = useRouter()

const visible = computed(() => route.path !== '/emergency')

function trigger() {
  router.push('/emergency')
}
</script>

<template>
  <button
    v-show="visible"
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
