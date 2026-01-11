import { component$, useSignal, $ } from '@builder.io/qwik';
import { isServer } from '@builder.io/qwik/build';

// Resumable Counter Component
export const Counter = component$(() => {
  const count = useSignal(0);
  
  // The $ suffix indicates lazy loading
  const increment = $(() => {
    count.value++;
  });
  
  const decrement = $(() => {
    count.value--;
  });
  
  // Conditional client-side only code
  const handleKeyboard = $((event: KeyboardEvent) => {
    if (event.key === 'ArrowUp') {
      count.value++;
    } else if (event.key === 'ArrowDown') {
      count.value--;
    }
  });
  
  return (
    <div class="counter">
      <h1>Count: {count.value}</h1>
      
      <div class="controls">
        <button onClick$={decrement}>-</button>
        <button onClick$={increment}>+</button>
      </div>
      
      <div class="keyboard-hint">
        Use arrow keys to control (client-side only)
      </div>
      
      {/* Only attach keyboard listener on client */}
      {!isServer && (
        <div 
          window:onKeyDown$={handleKeyboard}
          tabIndex={0}
          style={{ outline: 'none' }}
        />
      )}
    </div>
  );
});