import type { Config } from 'tailwindcss'

export default <Partial<Config>>{
  content: [
    './components/**/*.{vue,js}',
    './pages/**/*.vue',
    './app.vue',
  ],
  theme: {
    extend: {
      colors: {
        // Palette lifted straight from the UNICEF submission deck so the
        // app and the pitch materials read as one continuous brand.
        ink: '#0B3D3F',       // deep teal — primary background / trust, calm
        'ink-light': '#123F42',
        mint: '#2ED9A3',      // signature accent — growth, safety, "go"
        paper: '#F4FBF9',     // near-white warm background for content screens
        alert: '#E4572E',     // the fixed emergency button — warm red-orange, urgent but not alarming
        ash: '#5B7472',       // muted body text on paper
      },
      fontFamily: {
        display: ['"Nunito"', 'system-ui', 'sans-serif'],
        body: ['"Inter"', 'system-ui', 'sans-serif'],
      },
      borderRadius: {
        xl2: '1.25rem',
      },
    },
  },
  plugins: [],
}
