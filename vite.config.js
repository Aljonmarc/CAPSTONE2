import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import vue from '@vitejs/plugin-vue';

export default defineConfig({
    server: {
        host: '0.0.0.0',   // Allow access from outside the container
        port: process.env.PORT || 5173,  // Set the port based on environment variable (Render uses PORT)
    },
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
                // Split the vendor code into a separate chunk
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
