import type { SupabaseClient } from '@supabase/supabase-js'

export function useSupabase(): SupabaseClient {
  const { $supabase } = useNuxtApp()
  return $supabase as SupabaseClient
}

export async function useAuthToken(): Promise<string | null> {
  const supabase = useSupabase()
  const { data } = await supabase.auth.getSession()
  return data.session?.access_token ?? null
}
