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

const progressPct = computed(() => {
  if (!cards.value.length) return 0
  return Math.round((completedIds.value.size / cards.value.length) * 100)
})

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
  <div class="relative overflow-hidden">
    <BrandMotif />
    <AppHeader />

    <div class="relative mx-auto flex max-w-md flex-col gap-5 px-5 pb-6 pt-6">
      <header class="flex items-center justify-between">
        <div>
          <p class="text-xs font-semibold uppercase tracking-widest text-mint-deep">Pocket Mentor</p>
          <h1 class="font-display text-2xl font-bold text-ink">Every stage, explained</h1>
        </div>
        <select v-model="lang" class="rounded-xl2 border border-ink/15 bg-white px-3 py-2 text-sm focus-ring">
          <option value="en">English</option>
          <option value="fr">Français</option>
          <option value="pidgin">Pidgin</option>
        </select>
      </header>

      <div v-if="cards.length" class="flex items-center gap-3">
        <div class="h-2 flex-1 overflow-hidden rounded-full bg-ink/10">
          <div class="h-full rounded-full bg-dawn transition-all duration-500" :style="{ width: progressPct + '%' }" />
        </div>
        <span class="text-xs font-semibold text-ash">{{ completedIds.size }}/{{ cards.length }}</span>
      </div>

      <SkeletonCard v-if="loading" :lines="3" />

      <div v-else-if="!cards.length" class="rounded-xl2 bg-white p-6 text-center text-ash shadow-card">
        No tips downloaded yet. Connect to Wi-Fi once to save them for offline use.
      </div>

      <template v-else>
        <Transition name="card-swap" mode="out-in">
          <MentorCard
            :key="cards[index].id"
            :card="cards[index]"
            :lang="lang"
            :completed="completedIds.has(cards[index].id)"
            @complete="markDone"
          />
        </Transition>

        <div class="flex items-center justify-between px-1">
          <button class="font-medium text-ash transition-opacity disabled:opacity-30 focus-ring" :disabled="index === 0" @click="prev">
            ← Previous
          </button>
          <p class="text-xs text-ash">{{ index + 1 }} / {{ cards.length }}</p>
          <button class="font-semibold text-ink transition-opacity disabled:opacity-30 focus-ring" :disabled="index === cards.length - 1" @click="next">
            Next →
          </button>
        </div>
      </template>
    </div>
  </div>
</template>
