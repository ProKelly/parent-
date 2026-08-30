import { createClient } from '@supabase/supabase-js'

export default defineNuxtPlugin(() => {
  const config = useRuntimeConfig()
  const supabase = createClient(config.public.supabaseUrl, config.public.supabaseAnonKey, {
    auth: {
      persistSession: true,
      autoRefreshToken: true,
      // Anonymous-friendly: young parents shouldn't need an account to
      // use the emergency button or browse the Safe Hub. Login unlocks
      // sync across devices and progress history.
      detectSessionInUrl: true,
    },
  })

  return {
    provide: { supabase },
  }
})
