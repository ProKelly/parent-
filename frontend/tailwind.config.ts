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
        // Palette lifted from the UNICEF submission deck so the app and
        // the pitch materials read as one continuous brand, plus one
        // warm addition so the app doesn't read as clinically cool.
        ink: '#0B3D3F',       // deep teal — primary background / trust, calm
        'ink-light': '#123F42',
        mint: '#2ED9A3',      // signature accent — growth, safety, "go"
        'mint-deep': '#18A47A', // pressed/hover state for mint surfaces
        dawn: '#F2A65A',      // warm amber — reserved for progress & celebratory moments
        paper: '#FBFAF6',     // warm off-white, not clinical white
        alert: '#E4572E',     // the fixed emergency button — urgent but human
        ash: '#5B7472',       // muted body text on paper
      },
      fontFamily: {
        // Baloo 2: rounded, warm, unambiguous at small sizes — chosen over a
        // generic geometric sans because the primary audience reads at a
        // low-literacy level; rounded terminals read faster at a glance.
        display: ['"Baloo 2"', 'system-ui', 'sans-serif'],
        body: ['"Inter"', 'system-ui', 'sans-serif'],
      },
      borderRadius: {
        xl2: '1.25rem',
      },
      boxShadow: {
        soft: '0 8px 24px -8px rgba(11, 61, 63, 0.18)',
        card: '0 2px 10px -2px rgba(11, 61, 63, 0.10)',
      },
      keyframes: {
        drift: {
          '0%, 100%': { transform: 'translate(0, 0) rotate(0deg)' },
          '50%': { transform: 'translate(-14px, 10px) rotate(4deg)' },
        },
        'drift-slow': {
          '0%, 100%': { transform: 'translate(0, 0) rotate(0deg)' },
          '50%': { transform: 'translate(10px, -12px) rotate(-3deg)' },
        },
        'pulse-ring': {
          '0%': { transform: 'scale(1)', opacity: '0.5' },
          '100%': { transform: 'scale(1.6)', opacity: '0' },
        },
        'rise-in': {
          '0%': { opacity: '0', transform: 'translateY(10px)' },
          '100%': { opacity: '1', transform: 'translateY(0)' },
        },
      },
      animation: {
        drift: 'drift 14s ease-in-out infinite',
        'drift-slow': 'drift-slow 19s ease-in-out infinite',
        'pulse-ring': 'pulse-ring 2.2s cubic-bezier(0.2, 0.6, 0.4, 1) infinite',
        'rise-in': 'rise-in 0.5s ease-out both',
      },
    },
  },
  plugins: [],
}
