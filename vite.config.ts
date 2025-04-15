import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'
import observerPlugin from './babel-mobx-observer.js';

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    react({
      babel: {
        plugins: [observerPlugin],
      }
    }),
    tailwindcss(),
  ],
  clearScreen: false,
})
