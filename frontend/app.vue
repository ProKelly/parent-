<template>
  <div class="min-h-screen bg-paper pb-24">
    <!-- No `mode: 'out-in'` here on purpose: it defers inserting the new
         page until after the old one finishes leaving, and if a sibling
         (EmergencyButton/BottomNav below) restructures the DOM on that
         same tick — which happens exactly when navigating to/from
         /emergency, since those hide there — the deferred insertion
         throws (insertBefore on a stale anchor) and silently aborts,
         leaving the screen blank until a manual refresh. Dropping the
         mode makes enter/leave run concurrently instead, which sidesteps
         that DOM-ordering race entirely. -->
    <NuxtPage :transition="{ name: 'page' }" />
    <EmergencyButton />
    <BottomNav />
  </div>
</template>
