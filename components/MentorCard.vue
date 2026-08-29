<script setup lang="ts">
const props = defineProps<{
  card: {
    id: string
    title: Record<string, string>
    body: Record<string, string>
    audio_url?: Record<string, string>
    category: string
  }
  lang: string
  completed: boolean
}>()

const emit = defineEmits<{ complete: [id: string] }>()

const categoryLabel: Record<string, string> = {
  development: 'Development',
  discipline: 'Positive discipline',
  health: 'Health',
}

function playAudio() {
  const url = props.card.audio_url?.[props.lang] ?? props.card.audio_url?.en
  if (!url) return
  new Audio(url).play().catch(() => {
    // Offline with no cached clip yet — fail silently, text still works.
  })
}
</script>

<template>
  <div class="flex w-full flex-col gap-4 rounded-xl2 bg-white p-6 shadow-sm ring-1 ring-ink/5">
    <div class="flex items-center justify-between">
      <span class="rounded-full bg-mint/15 px-3 py-1 text-xs font-semibold text-ink">
        {{ categoryLabel[card.category] ?? card.category }}
      </span>
      <span v-if="completed" class="text-mint" aria-label="Completed">✓ Done</span>
    </div>

    <h3 class="font-display text-xl font-extrabold leading-snug text-ink">
      {{ card.title[lang] ?? card.title.en }}
    </h3>
    <p class="text-ash leading-relaxed">{{ card.body[lang] ?? card.body.en }}</p>

    <div class="flex gap-3 pt-2">
      <button
        v-if="card.audio_url?.[lang] || card.audio_url?.en"
        class="flex-1 rounded-xl2 border border-ink/15 py-3 font-semibold text-ink focus-ring"
        @click="playAudio"
      >
        ▶ Listen
      </button>
      <button
        class="flex-1 rounded-xl2 py-3 font-semibold text-white focus-ring"
        :class="completed ? 'bg-ash/40' : 'bg-mint'"
        @click="emit('complete', card.id)"
      >
        {{ completed ? 'Completed' : 'Mark done' }}
      </button>
    </div>
  </div>
