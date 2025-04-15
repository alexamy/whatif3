import { defineConfig } from 'vite'
import tailwindcss from '@tailwindcss/vite'
import observerPlugin from './babel-mobx-observer.js';

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    tailwindcss(),
  ],
  clearScreen: false,
})
