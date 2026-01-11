import { component$, useSignal } from '@builder.io/qwik';
import { routeAction$, Form, zod$, z } from '@builder.io/qwik-city';

// Validation schema
const UserSchema = z.object({
  name: z.string().min(2).max(50),
  email: z.string().email(),
  age: z.number().min(1).max(120),
});

// Server action for form submission
export const useCreateUser = routeAction$(async (data) => {
  // This runs on the server
  const response = await fetch('/api/users', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(data)
  });
  
  if (!response.ok) {
    return {
      success: false,
      error: 'Failed to create user'
    };
  }
  
  const user = await response.json();
  
  return {
    success: true,
    user
  };
}, zod$(UserSchema));

// Form component
export const UserForm = component$(() => {
  const createUserAction = useCreateUser();
  const isSubmitting = useSignal(false);
  
  return (
    <div class="user-form">
      <h2>Create New User</h2>
      
      <Form action={createUserAction} class="form">
        <div class="form-group">
          <label for="name">Name *</label>
          <input
            id="name"
            name="name"
            type="text"
            required
            placeholder="Enter name"
          />
        </div>
        
        <div class="form-group">
          <label for="email">Email *</label>
          <input
            id="email"
            name="email"
            type="email"
            required
            placeholder="Enter email"
          />
        </div>
        
        <div class="form-group">
          <label for="age">Age *</label>
          <input
            id="age"
            name="age"
            type="number"
            required
            min="1"
            max="120"
            placeholder="Enter age"
          />
        </div>
        
        <button 
          type="submit" 
          disabled={isSubmitting.value}
          onClick$={() => isSubmitting.value = true}
        >
          {isSubmitting.value ? 'Creating...' : 'Create User'}
        </button>
      </Form>
      
      {/* Display form results */}
      {createUserAction.value?.success && (
        <div class="success">
          User created successfully!
        </div>
      )}
      
      {createUserAction.value?.error && (
        <div class="error">
          {createUserAction.value.error}
        </div>
      )}
      
      {/* Display validation errors */}
      {createUserAction.value?.failed && (
        <div class="validation-errors">
          {Object.entries(createUserAction.value.fieldErrors || {}).map(([field, errors]) => (
            <div key={field} class="field-error">
              <strong>{field}:</strong> {errors?.join(', ')}
            </div>
          ))}
        </div>
      )}
    </div>
  );
});