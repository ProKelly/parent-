<script setup lang="ts">
interface Resource {
  id: string
  name: string
  type: string
  description?: string
  phone?: string
  region: string
  verified: boolean
  distance_km?: number
}

const config = useRuntimeConfig()
const resources = ref<Resource[]>([])
const loading = ref(true)
const errorMsg = ref('')

// Default to the Bamenda pilot region if geolocation is unavailable —
// this keeps the Safe Hub usable on locked-down or older devices.
const DEFAULT_LAT = 5.9631
const DEFAULT_LNG = 10.159

async function loadResources(lat: number, lng: number) {
  loading.value = true
  try {
    const res = await fetch(`${config.public.apiBase}/api/safehub/resources?lat=${lat}&lng=${lng}&radius_km=30`)
    if (!res.ok) throw new Error('request failed')
    resources.value = await res.json()
  } catch {
    errorMsg.value = "Couldn't load the directory. Try again once you have signal."
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  if (typeof navigator !== 'undefined' && navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      (pos) => loadResources(pos.coords.latitude, pos.coords.longitude),
      () => loadResources(DEFAULT_LAT, DEFAULT_LNG),
      { timeout: 4000 },
    )
  } else {
    loadResources(DEFAULT_LAT, DEFAULT_LNG)
  }
})
</script>

<template>
  <div class="mx-auto flex max-w-md flex-col gap-5 px-5 pb-6 pt-8">
    <header>
      <p class="text-xs font-semibold uppercase tracking-widest text-mint">Community Safe Hub</p>
      <h1 class="font-display text-2xl font-extrabold text-ink">Help near you</h1>
      <p class="text-ash">Health centers, safe spaces, and peer educators — sorted by distance.</p>
    </header>

    <div v-if="loading" class="py-16 text-center text-ash">Finding places near you…</div>
    <div v-else-if="errorMsg" class="rounded-xl2 bg-white p-6 text-center text-ash shadow-sm">{{ errorMsg }}</div>
    <div v-else-if="!resources.length" class="rounded-xl2 bg-white p-6 text-center text-ash shadow-sm">
      Nothing verified nearby yet. A peer educator is being trained in your region.
    </div>
    <SafeHubList v-else :resources="resources" />
  </div>
