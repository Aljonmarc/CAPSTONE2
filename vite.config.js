import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import vue from '@vitejs/plugin-vue';

export default defineConfig({
    plugins: [
        laravel({
            input: 'resources/js/app.js',
            refresh: true,
        }),
        vue({
            template: {
                transformAssetUrls: {
                    base: null,
                    includeAbsolute: false,
                },
            },
        }),
    ],
    build: {
        rollupOptions: {
            output: {
                // Manually split vendor code into a separate chunk
                manualChunks: {
                    vendor: [
                        'vue',
                        '@inertiajs/vue3',
                        'ziggy-js',
                        'element-plus',
                    ],
                },
            },
        },
        chunkSizeWarningLimit: 1000, // Adjust chunk size warning limit if needed
    },
});
