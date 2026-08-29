<script setup lang="ts">
defineProps<{
  resources: Array<{
    id: string
    name: string
    type: string
    description?: string
    phone?: string
    region: string
    verified: boolean
    distance_km?: number
  }>
}>()

const typeMeta: Record<string, { label: string; icon: string }> = {
  health_center: { label: 'Health center', icon: '🏥' },
  safe_space: { label: 'Safe space', icon: '🛖' },
  support_network: { label: 'Support network', icon: '🤝' },
  peer_educator_point: { label: 'Peer educator', icon: '🧑🏾‍🏫' },
}
</script>

<template>
  <ul class="flex flex-col gap-3">
    <li
      v-for="r in resources"
      :key="r.id"
      class="rounded-xl2 bg-white p-4 shadow-sm ring-1 ring-ink/5"
    >
      <div class="flex items-start justify-between gap-3">
        <div class="flex gap-3">
          <span class="text-2xl" aria-hidden="true">{{ typeMeta[r.type]?.icon ?? '📍' }}</span>
          <div>
            <p class="font-semibold text-ink">{{ r.name }}</p>
            <p class="text-xs text-ash">{{ typeMeta[r.type]?.label ?? r.type }} · {{ r.region }}</p>
            <p v-if="r.description" class="mt-1 text-sm text-ash">{{ r.description }}</p>
            <a v-if="r.phone" :href="`tel:${r.phone}`" class="mt-1 inline-block text-sm font-medium text-ink underline">
              {{ r.phone }}
            </a>
          </div>
        </div>
        <div class="flex flex-col items-end gap-1">
          <span v-if="r.verified" class="rounded-full bg-mint/15 px-2 py-0.5 text-[10px] font-semibold text-ink">Verified</span>
          <span v-if="r.distance_km !== undefined" class="text-xs text-ash">{{ r.distance_km.toFixed(1) }} km</span>
        </div>
      </div>
    </li>
  </ul>
