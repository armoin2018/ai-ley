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