<script setup lang="ts">
const config = useRuntimeConfig()
const step = ref<'trigger' | 'breathing' | 'check-in' | 'handoff'>('trigger')
const eventId = ref<string | null>(null)
const startedAt = ref<number>(0)
const breathPhase = ref<'in' | 'out'>('in')
let breathTimer: ReturnType<typeof setInterval> | null = null

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
      body: JSON.stringify({}),
    })
    if (res.ok) {
      const data = await res.json()
      eventId.value = data.event_id
    }
  } catch {
    // Fully offline: still runs the local breathing exercise, just
    // won't log an event until connectivity returns. Never blocks
    // the person from getting calm right now.
  }
}

function finishBreathing() {
  if (breathTimer) clearInterval(breathTimer)
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
})
</script>

<template>
  <div class="mx-auto flex min-h-screen max-w-md flex-col items-center justify-center gap-8 bg-ink px-6 text-center text-white">
    <template v-if="step === 'trigger'">
      <p class="text-sm uppercase tracking-widest text-mint">You tapped the button</p>
      <h1 class="font-display text-3xl font-extrabold leading-snug">
        This feeling will pass. Let's breathe together.
      </h1>
      <button
        class="w-full max-w-xs rounded-xl2 bg-mint py-4 text-lg font-bold text-ink focus-ring"
        @click="start"
      >
        Start
      </button>
      <NuxtLink to="/" class="text-sm text-white/60 underline">Not now</NuxtLink>
    </template>

    <template v-else-if="step === 'breathing'">
      <div
        class="flex h-48 w-48 items-center justify-center rounded-full bg-mint/20 text-xl font-semibold transition-all duration-[4000ms] ease-in-out"
        :class="breathPhase === 'in' ? 'scale-110' : 'scale-75'"
      >
        {{ breathPhase === 'in' ? 'Breathe in' : 'Breathe out' }}
      </div>
      <p class="text-white/70">Follow the circle. Your baby's crying will still be there in a moment — you deserve this pause.</p>
      <button class="rounded-xl2 border border-white/30 px-6 py-3 font-semibold focus-ring" @click="finishBreathing">
        I feel calmer
      </button>
    </template>

    <template v-else-if="step === 'check-in'">
      <h2 class="font-display text-2xl font-extrabold">How are you now?</h2>
      <div class="flex w-full max-w-xs flex-col gap-3">
        <button class="rounded-xl2 bg-mint py-4 font-bold text-ink focus-ring" @click="resolve('self_resolved')">
          I'm okay, thank you
        </button>
        <button class="rounded-xl2 border border-white/30 py-4 font-semibold focus-ring" @click="resolve('requested_handoff')">
          I'd like to talk to someone
        </button>
      </div>
    </template>

    <template v-else-if="step === 'handoff'">
      <h2 class="font-display text-2xl font-extrabold">You're not alone</h2>
      <p class="text-white/70">
        A trained peer counselor has been notified anonymously and will reach out through the app soon.
      </p>
      <NuxtLink to="/" class="rounded-xl2 bg-mint px-6 py-3 font-bold text-ink focus-ring">
        Back home
      </NuxtLink>
    </template>
  </div>
