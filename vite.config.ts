import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react-swc'
import observerPlugin from 'mobx-react-observer/swc-plugin'
import tailwindcss from '@tailwindcss/vite'

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    react({
      plugins: [observerPlugin() as any],
    }),
    tailwindcss(),
  ],
  clearScreen: false,
})
