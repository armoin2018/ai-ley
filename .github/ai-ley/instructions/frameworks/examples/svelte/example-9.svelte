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