import { defineConfig } from 'vite'
import tailwindcss from '@tailwindcss/vite'
import babel from 'vite-plugin-babel';
import observerPlugin from './babel-mobx-observer.js';

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    babel({
      babelConfig: {
        plugins: [observerPlugin],
      },
    }),
    tailwindcss(),
  ],
  clearScreen: false,
})
