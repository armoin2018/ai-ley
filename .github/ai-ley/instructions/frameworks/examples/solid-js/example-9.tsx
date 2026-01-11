import { createSignal, createMemo } from 'solid-js';
import { createStore } from 'solid-js/store';

interface FormData {
  name: string;
  email: string;
  age: number;
  preferences: {
    newsletter: boolean;
    theme: 'light' | 'dark';
  };
}

interface FormErrors {
  name?: string;
  email?: string;
  age?: string;
}

const UserForm: Component<{
  initialData?: Partial<FormData>;
  onSubmit: (data: FormData) => void;
  onCancel?: () => void;
}> = (props) => {
  const [formData, setFormData] = createStore<FormData>({
    name: '',
    email: '',
    age: 0,
    preferences: {
      newsletter: false,
      theme: 'light'
    },
    ...props.initialData
  });
  
  const [errors, setErrors] = createStore<FormErrors>({});
  const [isSubmitting, setIsSubmitting] = createSignal(false);
  
  const isValid = createMemo(() => {
    return formData.name.length > 0 && 
           formData.email.includes('@') && 
           formData.age > 0;
  });
  
  const validateField = (field: keyof FormData, value: any) => {
    switch (field) {
      case 'name':
        if (!value || value.length < 2) {
          setErrors('name', 'Name must be at least 2 characters');
        } else {
          setErrors('name', undefined);
        }
        break;
        
      case 'email':
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(value)) {
          setErrors('email', 'Please enter a valid email address');
        } else {
          setErrors('email', undefined);
        }
        break;
        
      case 'age':
        if (value < 1 || value > 120) {
          setErrors('age', 'Age must be between 1 and 120');
        } else {
          setErrors('age', undefined);
        }
        break;
    }
  };
  
  const handleSubmit = async (e: Event) => {
    e.preventDefault();
    
    if (!isValid()) return;
    
    setIsSubmitting(true);
    
    try {
      await props.onSubmit(formData);
    } catch (error) {
      console.error('Form submission failed:', error);
    } finally {
      setIsSubmitting(false);
    }
  };
  
  return (
    <form class="user-form" onSubmit={handleSubmit}>
      <div class="form-group">
        <label for="name">Name *</label>
        <input
          id="name"
          type="text"
          value={formData.name}
          onInput={(e) => {
            const value = e.currentTarget.value;
            setFormData('name', value);
            validateField('name', value);
          }}
          onBlur={(e) => validateField('name', e.currentTarget.value)}
          class={errors.name ? 'error' : ''}
        />
        <Show when={errors.name}>
          <span class="error-message">{errors.name}</span>
        </Show>
      </div>
      
      <div class="form-group">
        <label for="email">Email *</label>
        <input
          id="email"
          type="email"
          value={formData.email}
          onInput={(e) => {
            const value = e.currentTarget.value;
            setFormData('email', value);
            validateField('email', value);
          }}
          onBlur={(e) => validateField('email', e.currentTarget.value)}
          class={errors.email ? 'error' : ''}
        />
        <Show when={errors.email}>
          <span class="error-message">{errors.email}</span>
        </Show>
      </div>
      
      <div class="form-group">
        <label for="age">Age *</label>
        <input
          id="age"
          type="number"
          value={formData.age}
          onInput={(e) => {
            const value = parseInt(e.currentTarget.value);
            setFormData('age', value);
            validateField('age', value);
          }}
          onBlur={(e) => validateField('age', parseInt(e.currentTarget.value))}
          class={errors.age ? 'error' : ''}
        />
        <Show when={errors.age}>
          <span class="error-message">{errors.age}</span>
        </Show>
      </div>
      
      <div class="form-group">
        <label>
          <input
            type="checkbox"
            checked={formData.preferences.newsletter}
            onChange={(e) => setFormData('preferences', 'newsletter', e.currentTarget.checked)}
          />
          Subscribe to newsletter
        </label>
      </div>
      
      <div class="form-group">
        <label for="theme">Theme</label>
        <select
          id="theme"
          value={formData.preferences.theme}
          onChange={(e) => setFormData('preferences', 'theme', e.currentTarget.value as 'light' | 'dark')}
        >
          <option value="light">Light</option>
          <option value="dark">Dark</option>
        </select>
      </div>
      
      <div class="form-actions">
        <button type="submit" disabled={!isValid() || isSubmitting()}>
          {isSubmitting() ? 'Submitting...' : 'Submit'}
        </button>
        
        <Show when={props.onCancel}>
          <button type="button" onClick={props.onCancel}>
            Cancel
          </button>
        </Show>
      </div>
    </form>
  );
};