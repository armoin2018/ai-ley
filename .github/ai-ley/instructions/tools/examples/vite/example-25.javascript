// .env
VITE_API_URL=http://localhost:8080  # ✓ Accessible
API_SECRET=secret                   # ✗ Not accessible (no VITE_ prefix)

// Usage
console.log(import.meta.env.VITE_API_URL) // ✓ Works
console.log(process.env.VITE_API_URL)     // ✗ Won't work in browser

// For server-side or Node.js scripts
import { loadEnv } from 'vite'

const env = loadEnv('development', process.cwd(), '')
console.log(env.API_SECRET) // ✓ Works in Node.js context