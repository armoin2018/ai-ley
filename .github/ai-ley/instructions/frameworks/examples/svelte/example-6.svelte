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