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

// Each category gets its own accent so the card communicates what kind
// of tip it is before you even read it — development (mint, "growing"),
// positive discipline (dawn, "in the moment"), health (ink, "care").
const categoryMeta: Record<string, { label: string; badge: string }> = {
  development: { label: 'Development', badge: 'bg-mint/15 text-mint-deep' },
  discipline: { label: 'Positive discipline', badge: 'bg-dawn/20 text-[#9a5c1c]' },
  health: { label: 'Health', badge: 'bg-ink/10 text-ink' },
}

const playing = ref(false)

function playAudio() {
  const url = props.card.audio_url?.[props.lang] ?? props.card.audio_url?.en
  if (!url) return
  const audio = new Audio(url)
  playing.value = true
  audio.addEventListener('ended', () => { playing.value = false })
  audio.play().catch(() => { playing.value = false })
}
</script>

<template>
  <div class="flex w-full flex-col gap-4 rounded-xl2 bg-white p-6 shadow-card ring-1 ring-ink/5">
    <div class="flex items-center justify-between">
      <span class="rounded-full px-3 py-1 text-xs font-semibold" :class="categoryMeta[card.category]?.badge ?? 'bg-ash/10 text-ash'">
        {{ categoryMeta[card.category]?.label ?? card.category }}
      </span>
      <span v-if="completed" class="flex items-center gap-1 text-sm font-semibold text-mint-deep">
        ✓ Done
      </span>
    </div>

    <h3 class="font-display text-xl font-bold leading-snug text-ink">
      {{ card.title[lang] ?? card.title.en }}
    </h3>
    <p class="leading-relaxed text-ash">{{ card.body[lang] ?? card.body.en }}</p>

    <div class="flex gap-3 pt-2">
      <button
        v-if="card.audio_url?.[lang] || card.audio_url?.en"
        class="flex flex-1 items-center justify-center gap-2 rounded-xl2 border border-ink/15 py-3 font-semibold text-ink transition-colors hover:bg-ink/5 focus-ring"
        @click="playAudio"
      >
        <span :class="{ 'motion-safe:animate-pulse': playing }">{{ playing ? '🔊' : '▶' }}</span>
        Listen
      </button>
      <button
        class="flex-1 rounded-xl2 py-3 font-semibold text-white transition-transform active:scale-[0.98] focus-ring"
        :class="completed ? 'bg-ash/40' : 'bg-mint hover:bg-mint-deep'"
        @click="emit('complete', card.id)"
      >
        {{ completed ? 'Completed' : 'Mark done' }}
      </button>
    </div>
  </div>
</template>
