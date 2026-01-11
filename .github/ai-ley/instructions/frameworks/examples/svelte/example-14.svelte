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