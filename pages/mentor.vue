<script setup lang="ts">
interface Card {
  id: string
  age_month_min: number
  age_month_max: number
  title: Record<string, string>
  body: Record<string, string>
  audio_url?: Record<string, string>
  category: string
}

const config = useRuntimeConfig()
const { cacheCards, getCachedCards, queueProgress, flushQueue } = useOfflineSync()

const lang = ref<'en' | 'fr' | 'pidgin'>('en')
const cards = ref<Card[]>([])
const completedIds = ref<Set<string>>(new Set())
const index = ref(0)
const loading = ref(true)

async function loadCards() {
  // Try cache first — Pocket Mentor must open instantly with no
  // network, per "100% functional offline".
  const cached = getCachedCards<Card>()
  if (cached.length) {
    cards.value = cached
    loading.value = false
  }
  try {
    const res = await fetch(`${config.public.apiBase}/api/mentor/cards`)
    if (res.ok) {
      const fresh = await res.json()
      cards.value = fresh
      cacheCards(fresh)
    }
  } catch {
    // Offline with no cache yet: show empty state further below.
  } finally {
    loading.value = false
  }
}

function markDone(cardId: string) {
  completedIds.value.add(cardId)
  // In a full build this would use the signed-in child's real id;
  // 'demo-child' keeps this runnable standalone for the pitch demo.
  queueProgress('demo-child', cardId)
}

function next() {
  if (index.value < cards.value.length - 1) index.value++
}
function prev() {
  if (index.value > 0) index.value--
}

onMounted(async () => {
  await loadCards()
  const token = await useAuthToken()
  await flushQueue(token)
  window.addEventListener('online', () => flushQueue(token))
})
</script>

<template>
  <div class="mx-auto flex max-w-md flex-col gap-5 px-5 pb-6 pt-8">
    <header class="flex items-center justify-between">
      <div>
        <p class="text-xs font-semibold uppercase tracking-widest text-mint">Pocket Mentor</p>
        <h1 class="font-display text-2xl font-extrabold text-ink">Every stage, explained</h1>
      </div>
      <select v-model="lang" class="rounded-xl2 border border-ink/15 bg-white px-3 py-2 text-sm focus-ring">
        <option value="en">English</option>
        <option value="fr">Français</option>
        <option value="pidgin">Pidgin</option>
      </select>
    </header>

    <div v-if="loading" class="py-16 text-center text-ash">Loading tips…</div>

    <div v-else-if="!cards.length" class="rounded-xl2 bg-white p-6 text-center text-ash shadow-sm">
      No tips downloaded yet. Connect to Wi-Fi once to save them for offline use.
    </div>

    <template v-else>
      <MentorCard
        :card="cards[index]"
        :lang="lang"
        :completed="completedIds.has(cards[index].id)"
        @complete="markDone"
      />

      <div class="flex items-center justify-between px-1">
        <button class="text-ash disabled:opacity-30 focus-ring" :disabled="index === 0" @click="prev">← Previous</button>
        <p class="text-xs text-ash">{{ index + 1 }} / {{ cards.length }}</p>
        <button class="text-ink font-semibold disabled:opacity-30 focus-ring" :disabled="index === cards.length - 1" @click="next">
          Next →
        </button>
      </div>
    </template>
  </div>
