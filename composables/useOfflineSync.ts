// Implements the "Offline Sync Model" slide: locally encrypted-ish
// (browser-storage) queue of interactions, flushed as soon as the
// device sees network again. Kept dependency-free (localStorage) so
// it works even on very low-end Android devices.

const QUEUE_KEY = 'yp_progress_queue_v1'
const CARDS_CACHE_KEY = 'yp_mentor_cards_v1'

interface QueuedProgress {
  child_id: string
  card_id: string
  completed_at: string
}

export function useOfflineSync() {
  const config = useRuntimeConfig()

  function getQueue(): QueuedProgress[] {
    if (typeof window === 'undefined') return []
    const raw = window.localStorage.getItem(QUEUE_KEY)
    return raw ? JSON.parse(raw) : []
  }

  function saveQueue(queue: QueuedProgress[]) {
    window.localStorage.setItem(QUEUE_KEY, JSON.stringify(queue))
  }

  // Call this the instant a parent marks a milestone card complete —
  // works with zero network, no spinner, no failure state.
  function queueProgress(childId: string, cardId: string) {
    const queue = getQueue()
    queue.push({ child_id: childId, card_id: cardId, completed_at: new Date().toISOString() })
    saveQueue(queue)
  }

  // Call on app start and on 'online' events. Silently no-ops offline.
  async function flushQueue(authToken: string | null) {
    if (!authToken || typeof navigator !== 'undefined' && !navigator.onLine) return
    const queue = getQueue()
    if (queue.length === 0) return

    const remaining: QueuedProgress[] = []
    for (const item of queue) {
      try {
        const res = await fetch(`${config.public.apiBase}/api/mentor/progress`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${authToken}` },
          body: JSON.stringify(item),
        })
        if (!res.ok) remaining.push(item)
      } catch {
        remaining.push(item)
      }
    }
    saveQueue(remaining)
  }

  // Milestone cards are downloaded once (ideally over community Wi-Fi)
  // and cached for fully-offline daily browsing.
  function cacheCards(cards: unknown[]) {
    window.localStorage.setItem(CARDS_CACHE_KEY, JSON.stringify(cards))
  }

  function getCachedCards<T = unknown>(): T[] {
    if (typeof window === 'undefined') return []
    const raw = window.localStorage.getItem(CARDS_CACHE_KEY)
    return raw ? JSON.parse(raw) : []
  }

  return { queueProgress, flushQueue, cacheCards, getCachedCards, getQueue }
}
