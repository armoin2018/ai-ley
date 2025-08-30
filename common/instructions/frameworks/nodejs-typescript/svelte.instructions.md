---
applyTo: 'svelte, sveltekit'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on SvelteKit and modern Svelte patterns'
---

# Svelte Framework Instructions for AI Agents

## When to Use Svelte
Use Svelte when you need:
- Minimal bundle sizes with compile-time optimizations
- Excellent performance with zero runtime overhead
- Simple, intuitive syntax without virtual DOM complexity
- Fast prototyping with less boilerplate code
- Progressive web apps with SvelteKit
- Component libraries with minimal overhead
- Real-time applications with built-in reactivity

## When to Avoid Svelte
Consider alternatives when:
- Large enterprise applications with extensive tooling needs (Angular)
- Massive ecosystem requirements (React)
- Team already skilled in other frameworks
- Need for extensive third-party component libraries
- Legacy browser support requirements (IE11)
- Complex state management needs (consider React/Redux)

## Framework Overview
- **Framework**: Svelte 4.x with SvelteKit 1.x
- **Type**: Compile-time framework with optional meta-framework
- **Architecture**: Component-based with compile-time optimizations
- **Language**: JavaScript/TypeScript with enhanced syntax
- **Use Cases**: SPAs, static sites, PWAs, component libraries

## Installation & Setup

### ✅ Recommended: SvelteKit (Full-stack framework)
```bash
# Create new SvelteKit project
npm create svelte@latest my-app
cd my-app
npm install
npm run dev
```

### ✅ Alternative: Vite + Svelte (Lightweight)
```bash
# Create with Vite
npm create vite@latest my-app -- --template svelte
npm create vite@latest my-app -- --template svelte-ts
cd my-app
npm install
npm run dev
```

### ❌ Avoid: Standalone Svelte for new projects
```bash
# Don't use for modern development
npm install svelte
```

### AI Agent Decision Tree
- **For full applications**: Use SvelteKit (routing, SSR, API routes)
- **For component libraries**: Use Vite + Svelte
- **For prototyping**: Use SvelteKit with adapter-static
- **For existing apps**: Progressive adoption with standalone Svelte

## Project Structure

### ✅ SvelteKit Structure
```
sveltekit-app/
├── src/
│   ├── routes/              # File-based routing
│   │   ├── +layout.svelte   # Layout components
│   │   ├── +page.svelte     # Page components
│   │   └── api/             # API routes
│   ├── lib/                 # Shared components and utilities
│   │   ├── components/      # Reusable components
│   │   ├── stores/          # Svelte stores
│   │   └── utils/           # Utility functions
│   ├── app.html             # HTML template
│   └── hooks.client.js      # Client-side hooks
├── static/                  # Static assets
├── tests/                   # Test files
├── svelte.config.js         # Svelte configuration
├── vite.config.js           # Vite configuration
└── package.json
```

### ✅ Component Architecture
```
src/lib/components/
├── ui/                      # Basic UI components
│   ├── Button.svelte
│   ├── Input.svelte
│   └── Modal.svelte
├── layout/                  # Layout components
│   ├── Header.svelte
│   ├── Sidebar.svelte
│   └── Footer.svelte
├── features/                # Feature-specific components
│   ├── UserProfile.svelte
│   ├── ProductCard.svelte
│   └── SearchForm.svelte
└── forms/                   # Form components
    ├── ContactForm.svelte
    └── LoginForm.svelte
```

## Core Concepts

### Components with Script, Markup, and Style
✅ **Best Practice**: Single-file components with TypeScript
```svelte
<!-- UserCard.svelte -->
<script lang="ts">
  import { createEventDispatcher } from 'svelte';
  
  interface User {
    id: number;
    name: string;
    email: string;
    avatar: string;
  }
  
  export let user: User;
  export let loading = false;
  
  const dispatch = createEventDispatcher<{
    edit: User;
    delete: number;
  }>();
  
  function handleEdit() {
    dispatch('edit', user);
  }
  
  function handleDelete() {
    dispatch('delete', user.id);
  }
</script>

<div class="user-card" class:loading>
  <img src={user.avatar} alt={user.name} />
  <h3>{user.name}</h3>
  <p>{user.email}</p>
  <div class="actions">
    <button on:click={handleEdit} disabled={loading}>
      {loading ? 'Loading...' : 'Edit'}
    </button>
    <button on:click={handleDelete} class="danger" disabled={loading}>
      Delete
    </button>
  </div>
</div>

<style>
  .user-card {
    padding: 1rem;
    border: 1px solid #ccc;
    border-radius: 8px;
    transition: all 0.2s ease;
  }
  
  .user-card:hover {
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  }
  
  .user-card.loading {
    opacity: 0.6;
  }
  
  .user-card img {
    width: 64px;
    height: 64px;
    border-radius: 50%;
    object-fit: cover;
  }
  
  .actions {
    display: flex;
    gap: 0.5rem;
    margin-top: 1rem;
  }
  
  button {
    padding: 0.5rem 1rem;
    border: 1px solid #ccc;
    border-radius: 4px;
    background: white;
    cursor: pointer;
  }
  
  button:hover {
    background: #f5f5f5;
  }
  
  button.danger {
    border-color: #dc3545;
    color: #dc3545;
  }
  
  button:disabled {
    cursor: not-allowed;
    opacity: 0.5;
  }
</style>
```

### Reactivity and Stores
✅ **Best Practice**: Reactive statements and stores for state management
```typescript
// stores/user.ts
import { writable, derived } from 'svelte/store';

interface User {
  id: number;
  name: string;
  email: string;
  role: 'admin' | 'user';
}

// Writable stores
export const users = writable<User[]>([]);
export const currentUser = writable<User | null>(null);
export const loading = writable(false);
export const error = writable<string | null>(null);

// Derived stores
export const userCount = derived(users, ($users) => $users.length);
export const adminUsers = derived(users, ($users) => 
  $users.filter(user => user.role === 'admin')
);
export const isAuthenticated = derived(currentUser, ($currentUser) => 
  $currentUser !== null
);

// Store actions
export const userActions = {
  async fetchUsers() {
    loading.set(true);
    error.set(null);
    try {
      const response = await fetch('/api/users');
      if (!response.ok) throw new Error('Failed to fetch users');
      const data = await response.json();
      users.set(data);
    } catch (err) {
      error.set(err instanceof Error ? err.message : 'Unknown error');
    } finally {
      loading.set(false);
    }
  },
  
  addUser(newUser: Omit<User, 'id'>) {
    users.update(($users) => [
      ...$users,
      { ...newUser, id: Date.now() }
    ]);
  },
  
  removeUser(id: number) {
    users.update(($users) => $users.filter(user => user.id !== id));
  }
};
```

### SvelteKit Routing and Data Loading
✅ **Best Practice**: File-based routing with load functions
```typescript
// src/routes/users/+page.ts
import type { PageLoad } from './$types';

export const load: PageLoad = async ({ fetch }) => {
  try {
    const response = await fetch('/api/users');
    if (!response.ok) {
      throw new Error('Failed to fetch users');
    }
    const users = await response.json();
    
    return {
      users,
      meta: {
        title: 'Users',
        description: 'Manage application users'
      }
    };
  } catch (error) {
    return {
      users: [],
      error: error instanceof Error ? error.message : 'Unknown error'
    };
  }
};
```

```svelte
<!-- src/routes/users/+page.svelte -->
<script lang="ts">
  import type { PageData } from './$types';
  import UserCard from '$lib/components/UserCard.svelte';
  
  export let data: PageData;
  
  $: ({ users, error, meta } = data);
</script>

<svelte:head>
  <title>{meta?.title || 'Users'}</title>
  <meta name="description" content={meta?.description || ''} />
</svelte:head>

<div class="users-page">
  <h1>Users</h1>
  
  {#if error}
    <div class="error">Error: {error}</div>
  {:else if users.length === 0}
    <div class="empty">No users found</div>
  {:else}
    <div class="users-grid">
      {#each users as user (user.id)}
        <UserCard 
          {user} 
          on:edit={(event) => console.log('Edit user:', event.detail)}
          on:delete={(event) => console.log('Delete user:', event.detail)}
        />
      {/each}
    </div>
  {/if}
</div>

<style>
  .users-page {
    padding: 2rem;
  }
  
  .users-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 1rem;
    margin-top: 2rem;
  }
  
  .error {
    color: #dc3545;
    padding: 1rem;
    background: #f8d7da;
    border-radius: 4px;
  }
  
  .empty {
    text-align: center;
    color: #6c757d;
    padding: 2rem;
  }
</style>
```

### API Routes (SvelteKit)
✅ **Best Practice**: Type-safe API routes
```typescript
// src/routes/api/users/+server.ts
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

interface User {
  id: number;
  name: string;
  email: string;
  role: 'admin' | 'user';
}

// Mock database
let users: User[] = [
  { id: 1, name: 'John Doe', email: 'john@example.com', role: 'admin' },
  { id: 2, name: 'Jane Smith', email: 'jane@example.com', role: 'user' }
];

export const GET: RequestHandler = async () => {
  return json(users);
};

export const POST: RequestHandler = async ({ request }) => {
  try {
    const data = await request.json();
    const newUser: User = {
      id: Date.now(),
      name: data.name,
      email: data.email,
      role: data.role || 'user'
    };
    
    users.push(newUser);
    return json(newUser, { status: 201 });
  } catch (error) {
    return json(
      { error: 'Invalid request data' },
      { status: 400 }
    );
  }
};
```

## Best Practices

### ✅ Do's
- Use TypeScript for better development experience
- Leverage Svelte's built-in reactivity instead of external state management
- Use stores for shared state across components
- Implement proper error boundaries and loading states
- Use SvelteKit for full applications with routing needs
- Follow the single responsibility principle for components
- Use CSS custom properties for theming
- Implement proper accessibility (a11y) practices

### ❌ Don'ts
- Don't use external state management for simple applications
- Don't ignore Svelte's reactivity patterns
- Don't make components too large (>200 lines)
- Don't forget to handle loading and error states
- Don't use jQuery or DOM manipulation libraries
- Don't ignore TypeScript warnings
- Don't skip testing for critical functionality

### Performance Optimization
```svelte
<!-- Lazy loading components -->
<script>
  import { onMount } from 'svelte';
  
  let HeavyComponent;
  
  onMount(async () => {
    const module = await import('./HeavyComponent.svelte');
    HeavyComponent = module.default;
  });
</script>

{#if HeavyComponent}
  <svelte:component this={HeavyComponent} />
{/if}
```

```typescript
// Virtual scrolling for large lists
import { writable } from 'svelte/store';

export function createVirtualList<T>(items: T[], itemHeight: number) {
  const visibleItems = writable<T[]>([]);
  const scrollTop = writable(0);
  
  function updateVisibleItems(containerHeight: number, scroll: number) {
    const startIndex = Math.floor(scroll / itemHeight);
    const endIndex = Math.min(
      startIndex + Math.ceil(containerHeight / itemHeight) + 1,
      items.length
    );
    
    visibleItems.set(items.slice(startIndex, endIndex));
  }
  
  return {
    visibleItems,
    scrollTop,
    updateVisibleItems,
    totalHeight: items.length * itemHeight
  };
}
```

## Development Workflow

### ✅ Recommended Development Setup
```bash
# Development
npm run dev

# Type checking
npm run check
npm run check:watch

# Testing
npm run test
npm run test:coverage

# Building
npm run build
npm run preview

# Linting
npm run lint
```

### IDE Configuration
- **VS Code Extensions**: Svelte for VS Code, TypeScript Svelte Plugin
- **Settings**: Enable TypeScript strict mode, Svelte IntelliSense
- **Debugging**: Use browser DevTools with Svelte DevTools extension

### AI Agent Decision Matrix
| Scenario         | Recommended Approach          | Avoid                         |
| ---------------- | ----------------------------- | ----------------------------- |
| New application  | SvelteKit + TypeScript        | Standalone Svelte             |
| Component lib    | Vite + Svelte + TypeScript    | SvelteKit (overkill)          |
| State management | Svelte stores                 | External libraries            |
| Styling          | Scoped CSS + CSS variables    | CSS-in-JS libraries           |
| Testing          | Vitest + Testing Library      | Jest without proper setup     |
| Deployment       | Adapter-based (Vercel/Netlify) | Manual server configuration  |

## Integration Guidelines
- **With APIs**: Use SvelteKit load functions for SSR data
- **With databases**: Implement proper data layer separation
- **With authentication**: Use SvelteKit hooks for session management
- **With CSS frameworks**: Prefer utility-first (Tailwind) over component libraries
- **With backend**: Design API-first architecture with proper error handling

## Common Patterns
```svelte
<!-- Form handling with validation -->
<script lang="ts">
  import { createEventDispatcher } from 'svelte';
  
  const dispatch = createEventDispatcher<{
    submit: { email: string; password: string };
  }>();
  
  let email = '';
  let password = '';
  let errors: { [key: string]: string } = {};
  
  function validate() {
    errors = {};
    
    if (!email) errors.email = 'Email is required';
    else if (!/\S+@\S+\.\S+/.test(email)) errors.email = 'Invalid email';
    
    if (!password) errors.password = 'Password is required';
    else if (password.length < 8) errors.password = 'Password must be at least 8 characters';
    
    return Object.keys(errors).length === 0;
  }
  
  function handleSubmit() {
    if (validate()) {
      dispatch('submit', { email, password });
    }
  }
</script>

<form on:submit|preventDefault={handleSubmit}>
  <div class="field">
    <label for="email">Email</label>
    <input
      id="email"
      type="email"
      bind:value={email}
      class:error={errors.email}
      required
    />
    {#if errors.email}
      <span class="error-message">{errors.email}</span>
    {/if}
  </div>
  
  <div class="field">
    <label for="password">Password</label>
    <input
      id="password"
      type="password"
      bind:value={password}
      class:error={errors.password}
      required
    />
    {#if errors.password}
      <span class="error-message">{errors.password}</span>
    {/if}
  </div>
  
  <button type="submit">Sign In</button>
</form>
```

## Testing

### ✅ Component Testing
```typescript
// tests/UserCard.test.ts
import { render, screen, fireEvent } from '@testing-library/svelte';
import UserCard from '../src/lib/components/UserCard.svelte';

describe('UserCard', () => {
  const mockUser = {
    id: 1,
    name: 'John Doe',
    email: 'john@example.com',
    avatar: '/avatar.jpg'
  };

  it('renders user information', () => {
    render(UserCard, { props: { user: mockUser } });
    
    expect(screen.getByText('John Doe')).toBeInTheDocument();
    expect(screen.getByText('john@example.com')).toBeInTheDocument();
    expect(screen.getByAltText('John Doe')).toHaveAttribute('src', '/avatar.jpg');
  });

  it('emits edit event when edit button clicked', async () => {
    const { component } = render(UserCard, { props: { user: mockUser } });
    const editButton = screen.getByText('Edit');
    
    const editEventPromise = new Promise((resolve) => {
      component.$on('edit', (event) => resolve(event.detail));
    });
    
    await fireEvent.click(editButton);
    const editEvent = await editEventPromise;
    
    expect(editEvent).toEqual(mockUser);
  });
});
```

### ✅ Integration Testing
```typescript
// tests/routes/users.test.ts
import { expect, test } from '@playwright/test';

test('users page displays user list', async ({ page }) => {
  await page.goto('/users');
  
  await expect(page.locator('h1')).toHaveText('Users');
  await expect(page.locator('.user-card')).toHaveCount.greaterThan(0);
});

test('user card edit functionality', async ({ page }) => {
  await page.goto('/users');
  
  const firstUserCard = page.locator('.user-card').first();
  await firstUserCard.locator('button:text("Edit")').click();
  
  // Verify edit modal or navigation occurred
  await expect(page).toHaveURL(/.*\/users\/\d+\/edit/);
});
```

## Security Considerations
- Implement proper input validation and sanitization
- Use CSRF protection for forms
- Sanitize user-generated content
- Implement proper authentication and authorization
- Use environment variables for sensitive configuration
- Enable Content Security Policy (CSP)
- Validate and sanitize all API inputs

## Error Handling
```svelte
<!-- Error boundary pattern -->
<script lang="ts">
  import { onMount } from 'svelte';
  
  let error: Error | null = null;
  let loading = true;
  let data: any = null;
  
  onMount(async () => {
    try {
      const response = await fetch('/api/data');
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      data = await response.json();
    } catch (err) {
      error = err instanceof Error ? err : new Error('Unknown error');
    } finally {
      loading = false;
    }
  });
</script>

{#if loading}
  <div class="loading">Loading...</div>
{:else if error}
  <div class="error">
    <h3>Something went wrong</h3>
    <p>{error.message}</p>
    <button on:click={() => window.location.reload()}>
      Try Again
    </button>
  </div>
{:else}
  <!-- Render data -->
  <div class="content">
    {JSON.stringify(data)}
  </div>
{/if}
```

## AI Agent Quick Reference
- **Component Creation**: Focus on single-file components with TypeScript
- **State Management**: Use Svelte stores for shared state, reactive statements for local state
- **Routing**: Implement file-based routing with SvelteKit
- **Data Fetching**: Use load functions for SSR, stores for client-side state
- **Performance**: Leverage Svelte's compile-time optimizations
- **Testing**: Use Testing Library with Vitest for component tests
- **Deployment**: Use appropriate SvelteKit adapters for target platforms
