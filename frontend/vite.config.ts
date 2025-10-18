import { defineConfig, loadEnv } from "vite";
import react from "@vitejs/plugin-react-swc";
import path from "path";
import { componentTagger } from "lovable-tagger";

// https://vitejs.dev/config/
export default defineConfig(({ mode }) => {
  // Declare variables before returning the object
  const env = loadEnv(mode, process.cwd(), "VITE_");
  const port = parseInt(env.VITE_PORT) || 8080;
  const allowedUrls = env.VITE_ALLOWED_URLS?.split(",") || [];

  return {
    server: {
      host: "::",
      port,
      allowedHosts: allowedUrls,
      hmr: mode === 'production' ? false : {
        port: 24678, // Use a different port for HMR in development
      },
    },
    build: {
      outDir: 'dist',
      sourcemap: mode !== 'production',
      minify: mode === 'production' ? 'terser' : false,
    },
    plugins: [
      react(),
      mode === "development" && componentTagger(),
    ].filter(Boolean),
    resolve: {
      alias: {
        "@": path.resolve(__dirname, "./src"),
      },
    },
    define: {
      global: 'globalThis',
    },
  };
});
