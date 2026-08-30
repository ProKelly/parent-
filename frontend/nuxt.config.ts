// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2024-11-01',
  devtools: { enabled: true },
  modules: ['@nuxtjs/tailwindcss', '@vite-pwa/nuxt'],
  css: ['~/assets/css/main.css'],

  runtimeConfig: {
    public: {
      supabaseUrl: process.env.NUXT_PUBLIC_SUPABASE_URL || '',
      supabaseAnonKey: process.env.NUXT_PUBLIC_SUPABASE_ANON_KEY || '',
      apiBase: process.env.NUXT_PUBLIC_API_BASE || 'http://localhost:8000',
    },
  },

  app: {
    head: {
      title: 'YouthParent+',
      meta: [
        { name: 'viewport', content: 'width=device-width, initial-scale=1, viewport-fit=cover' },
        { name: 'theme-color', content: '#0B3D3F' },
        {
          name: 'description',
          content: 'A digital shield to prevent parental burnout and protect vulnerable young families in Cameroon.',
        },
      ],
    },
  },

  // Offline-first PWA: caches the shell + Pocket Mentor content so the
  // app runs with zero network, per the "Offline Sync Model" slide.
  pwa: {
    registerType: 'autoUpdate',
    manifest: {
      name: 'YouthParent+',
      short_name: 'YouthParent+',
      description: 'A digital shield for young parents in Cameroon.',
      theme_color: '#0B3D3F',
      background_color: '#0B3D3F',
      display: 'standalone',
      start_url: '/',
      icons: [
        { src: '/icons/icon-192.png', sizes: '192x192', type: 'image/png' },
        { src: '/icons/icon-512.png', sizes: '512x512', type: 'image/png' },
      ],
    },
    workbox: {
      navigateFallback: '/',
      globPatterns: ['**/*.{js,css,html,png,svg,mp3}'],
      runtimeCaching: [
        {
          // Milestone cards + audio: cache-first so Pocket Mentor works
          // with zero connectivity after the first sync.
          urlPattern: /\/api\/mentor\/cards/,
          handler: 'CacheFirst',
          options: { cacheName: 'mentor-cards', expiration: { maxEntries: 200 } },
        },
        {
          urlPattern: /\.(mp3)$/,
          handler: 'CacheFirst',
          options: { cacheName: 'audio-clips', expiration: { maxEntries: 100 } },
        },
      ],
    },
    devOptions: { enabled: true },
  },
})
