<script setup lang="ts">
// Low-literacy-friendly auth: phone + OTP rather than email/password.
// Login is optional — the emergency button and Safe Hub work without
// it; this only unlocks cross-device sync of Pocket Mentor progress.
const supabase = useSupabase()
const phone = ref('')
const otp = ref('')
const stage = ref<'phone' | 'otp' | 'done'>('phone')
const error = ref('')

async function sendOtp() {
  error.value = ''
  const { error: err } = await supabase.auth.signInWithOtp({ phone: phone.value })
  if (err) {
    error.value = err.message
    return
  }
  stage.value = 'otp'
}

async function verifyOtp() {
  error.value = ''
  const { error: err } = await supabase.auth.verifyOtp({ phone: phone.value, token: otp.value, type: 'sms' })
  if (err) {
    error.value = err.message
    return
  }
  navigateTo('/')
}
</script>

<template>
  <div class="mx-auto flex min-h-screen max-w-md flex-col justify-center gap-6 px-6">
    <header>
      <h1 class="font-display text-2xl font-extrabold text-ink">Save your progress</h1>
      <p class="text-ash">Optional — everything still works without an account.</p>
    </header>

    <form v-if="stage === 'phone'" class="flex flex-col gap-3" @submit.prevent="sendOtp">
      <input
        v-model="phone"
        type="tel"
        placeholder="+237 6XX XXX XXX"
        class="rounded-xl2 border border-ink/15 px-4 py-3 focus-ring"
      />
      <button class="rounded-xl2 bg-ink py-3 font-semibold text-white focus-ring" type="submit">
        Send code
      </button>
    </form>

    <form v-else-if="stage === 'otp'" class="flex flex-col gap-3" @submit.prevent="verifyOtp">
      <input
        v-model="otp"
        inputmode="numeric"
        placeholder="6-digit code"
        class="rounded-xl2 border border-ink/15 px-4 py-3 focus-ring"
      />
      <button class="rounded-xl2 bg-mint py-3 font-semibold text-ink focus-ring" type="submit">
        Confirm
      </button>
    </form>

    <p v-if="error" class="text-sm text-alert">{{ error }}</p>
    <NuxtLink to="/" class="text-center text-sm text-ash underline">Skip for now</NuxtLink>
  </div>
