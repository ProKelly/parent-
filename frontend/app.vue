<template>
  <div class="min-h-screen bg-paper pb-24">
    <NuxtPage :transition="{ name: 'page', mode: 'out-in' }" />
    <EmergencyButton />
    <BottomNav />
  </div>
</template>
