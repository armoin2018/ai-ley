// src/routes/layout.tsx - Root layout
import { component$, Slot } from '@builder.io/qwik';
import { Header } from '~/components/layout/header';
import { Footer } from '~/components/layout/footer';

export default component$(() => {
  return (
    <div class="app-layout">
      <Header />
      <main class="main-content">
        <Slot />
      </main>
      <Footer />
    </div>
  );
});

// src/routes/index.tsx - Home page
import { component$ } from '@builder.io/qwik';
import { type DocumentHead } from '@builder.io/qwik-city';
import { Counter } from '~/components/counter';

export default component$(() => {
  return (
    <div class="home-page">
      <h1>Welcome to Qwik</h1>
      <p>Instant loading, resumable framework</p>
      <Counter />
    </div>
  );
});

export const head: DocumentHead = {
  title: 'Welcome to Qwik',
  meta: [
    {
      name: 'description',
      content: 'Qwik site description',
    },
  ],
};

// src/routes/users/index.tsx - Users list page
import { component$ } from '@builder.io/qwik';
import { routeLoader$ } from '@builder.io/qwik-city';
import { UserCard } from '~/components/user-card';

// Server-side data loading
export const useUsers = routeLoader$(async () => {
  // This runs on the server
  const response = await fetch('https://api.example.com/users');
  const users = await response.json();
  return users;
});

export default component$(() => {
  const users = useUsers();
  
  return (
    <div class="users-page">
      <h1>Users</h1>
      <div class="users-grid">
        {users.value.map((user: any) => (
          <UserCard key={user.id} user={user} />
        ))}
      </div>
    </div>
  );
});

// src/routes/users/[id]/index.tsx - User detail page
import { component$ } from '@builder.io/qwik';
import { routeLoader$ } from '@builder.io/qwik-city';
import type { DocumentHead } from '@builder.io/qwik-city';

export const useUser = routeLoader$(async (requestEvent) => {
  const userId = requestEvent.params.id;
  const response = await fetch(`https://api.example.com/users/${userId}`);
  
  if (!response.ok) {
    throw new Error('User not found');
  }
  
  return response.json();
});

export default component$(() => {
  const user = useUser();
  
  return (
    <div class="user-detail">
      <h1>{user.value.name}</h1>
      <p>Email: {user.value.email}</p>
      <p>ID: {user.value.id}</p>
    </div>
  );
});

export const head: DocumentHead = ({ resolveValue }) => {
  const user = resolveValue(useUser);
  return {
    title: `${user.name} - User Profile`,
    meta: [
      {
        name: 'description',
        content: `Profile page for ${user.name}`,
      },
    ],
  };
};