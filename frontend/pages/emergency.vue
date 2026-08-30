<script setup lang="ts">
const config = useRuntimeConfig()
const step = ref<'trigger' | 'breathing' | 'check-in' | 'handoff'>('trigger')
const eventId = ref<string | null>(null)
const startedAt = ref<number>(0)
const breathPhase = ref<'in' | 'out'>('in')
const lang = ref<'en' | 'fr' | 'pidgin'>('en')
let breathTimer: ReturnType<typeof setInterval> | null = null
let audioEl: HTMLAudioElement | null = null

const stepOrder = ['trigger', 'breathing', 'check-in'] as const
const stepIndex = computed(() => {
  const i = stepOrder.indexOf(step.value as typeof stepOrder[number])
  return i === -1 ? stepOrder.length - 1 : i
})

async function start() {
  step.value = 'breathing'
  startedAt.value = Date.now()
  breathTimer = setInterval(() => {
    breathPhase.value = breathPhase.value === 'in' ? 'out' : 'in'
  }, 4000)

  try {
    const token = await useAuthToken()
    const res = await fetch(`${config.public.apiBase}/api/emergency/trigger`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        ...(token ? { Authorization: `Bearer ${token}` } : {}),
      },
      body: JSON.stringify({ lang: lang.value }),
    })
    if (res.ok) {
      const data = await res.json()
      eventId.value = data.event_id
      // Cached by the service worker after first play (see nuxt.config.ts
      // runtimeCaching for *.mp3), so it works offline from the second
      // crisis onward even with no connectivity right now.
      audioEl = new Audio(data.audio_url)
      audioEl.play().catch(() => {
        // Autoplay blocked or offline with nothing cached yet — the
        // breathing animation still runs on its own, so this is never
        // a hard failure for the person in crisis.
      })
    }
  } catch {
    // Fully offline: still runs the local breathing exercise, just
    // won't log an event until connectivity returns. Never blocks
    // the person from getting calm right now.
  }
}

function finishBreathing() {
  if (breathTimer) clearInterval(breathTimer)
  if (audioEl) { audioEl.pause(); audioEl = null }
  step.value = 'check-in'
}

async function resolve(outcome: 'self_resolved' | 'requested_handoff') {
  const duration = Math.round((Date.now() - startedAt.value) / 1000)
  if (outcome === 'requested_handoff') {
    step.value = 'handoff'
  }
  if (!eventId.value) return
  try {
    await fetch(`${config.public.apiBase}/api/emergency/resolve`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ event_id: eventId.value, outcome, duration_seconds: duration }),
    })
  } catch {
    // queued for later in a fuller implementation; not blocking here
  }
  if (outcome === 'self_resolved') {
    navigateTo('/')
  }
}

onUnmounted(() => {
  if (breathTimer) clearInterval(breathTimer)
  if (audioEl) audioEl.pause()
})
</script>

<template>
  <div class="relative flex min-h-screen flex-col items-center justify-center gap-8 overflow-hidden bg-ink px-6 text-center text-white">
    <BrandMotif tone="on-ink" />

    <!-- Step dots: a quiet map of "how much further", not a countdown to rush anyone -->
    <div v-if="step !== 'handoff'" class="absolute top-8 flex gap-2" aria-hidden="true">
      <span
        v-for="(s, i) in stepOrder"
        :key="s"
        class="h-1.5 w-6 rounded-full transition-colors"
        :class="i <= stepIndex ? 'bg-mint' : 'bg-white/20'"
      />
    </div>

    <template v-if="step === 'trigger'">
      <Logo :size="34" />
      <h1 class="relative font-display text-3xl font-extrabold leading-snug motion-safe:animate-rise-in">
        This feeling will pass. Let's breathe together.
      </h1>
      <select
        v-model="lang"
        class="relative rounded-xl2 border border-white/30 bg-transparent px-4 py-2 text-white focus-ring"
      >
        <option value="en" class="text-ink">English</option>
        <option value="fr" class="text-ink">Français</option>
        <option value="pidgin" class="text-ink">Pidgin</option>
      </select>
      <button
        class="relative w-full max-w-xs rounded-xl2 bg-mint py-4 text-lg font-bold text-ink shadow-soft transition-transform active:scale-95 focus-ring"
        @click="start"
      >
        Start
      </button>
      <NuxtLink to="/" class="relative text-sm text-white/60 underline">Not now</NuxtLink>
    </template>

    <template v-else-if="step === 'breathing'">
      <div class="relative flex h-56 w-56 items-center justify-center">
        <svg viewBox="0 0 200 200" class="absolute inset-0 h-full w-full" aria-hidden="true">
          <circle cx="100" cy="100" r="70" fill="none" stroke="rgba(255,255,255,0.12)" stroke-width="2" />
          <circle
            cx="100" cy="100" r="70" fill="none" stroke="#2ED9A3" stroke-width="3" stroke-linecap="round"
            stroke-dasharray="440"
            class="origin-center transition-all ease-in-out"
            :style="{
              strokeDashoffset: breathPhase === 'in' ? 0 : 260,
              transitionDuration: '4000ms',
            }"
          />
        </svg>
        <div
          class="flex h-36 w-36 items-center justify-center rounded-full bg-mint/15 font-display text-xl font-bold transition-transform ease-in-out"
          :class="breathPhase === 'in' ? 'scale-110' : 'scale-90'"
          style="transition-duration: 4000ms"
        >
          {{ breathPhase === 'in' ? 'Breathe in' : 'Breathe out' }}
        </div>
      </div>
      <p class="relative max-w-xs text-white/70">
        Follow the circle. Your baby's crying will still be there in a moment — you deserve this pause.
      </p>
      <button
        class="relative rounded-xl2 border border-white/30 px-6 py-3 font-semibold transition-colors hover:bg-white/10 focus-ring"
        @click="finishBreathing"
      >
        I feel calmer
      </button>
    </template>

    <template v-else-if="step === 'check-in'">
      <h2 class="relative font-display text-2xl font-extrabold motion-safe:animate-rise-in">How are you now?</h2>
      <div class="relative flex w-full max-w-xs flex-col gap-3">
        <button
          class="rounded-xl2 bg-mint py-4 font-bold text-ink shadow-soft transition-transform active:scale-95 focus-ring"
          @click="resolve('self_resolved')"
        >
          I'm okay, thank you
        </button>
        <button
          class="rounded-xl2 border border-white/30 py-4 font-semibold transition-colors hover:bg-white/10 focus-ring"
          @click="resolve('requested_handoff')"
        >
          I'd like to talk to someone
        </button>
      </div>
    </template>

    <template v-else-if="step === 'handoff'">
      <span class="relative text-5xl" aria-hidden="true">🌱</span>
      <h2 class="relative font-display text-2xl font-extrabold">You're not alone</h2>
      <p class="relative max-w-xs text-white/70">
        A trained peer counselor has been notified anonymously and will reach out through the app soon.
      </p>
      <NuxtLink to="/" class="relative rounded-xl2 bg-mint px-6 py-3 font-bold text-ink shadow-soft focus-ring">
        Back home
      </NuxtLink>
    </template>
  </div>
</template>
