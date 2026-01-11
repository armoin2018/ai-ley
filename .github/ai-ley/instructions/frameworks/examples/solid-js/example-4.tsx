import { createSignal, createEffect, createMemo, onCleanup } from 'solid-js';

// Basic Counter Component with Signals
function Counter() {
  const [count, setCount] = createSignal(0);
  const [name, setName] = createSignal('');
  
  // Derived state with createMemo
  const doubleCount = createMemo(() => count() * 2);
  
  // Side effects with createEffect
  createEffect(() => {
    console.log(`Count changed to: ${count()}`);
    document.title = `Count: ${count()}`;
  });
  
  // Cleanup effects
  const timer = setInterval(() => {
    setCount(c => c + 1);
  }, 1000);
  
  onCleanup(() => clearInterval(timer));
  
  return (
    <div class="counter">
      <h1>Hello {name() || 'World'}!</h1>
      <p>Count: {count()}</p>
      <p>Double Count: {doubleCount()}</p>
      
      <input
        type="text"
        placeholder="Enter your name"
        value={name()}
        onInput={(e) => setName(e.currentTarget.value)}
      />
      
      <div class="controls">
        <button onClick={() => setCount(c => c + 1)}>
          Increment
        </button>
        <button onClick={() => setCount(c => c - 1)}>
          Decrement
        </button>
        <button onClick={() => setCount(0)}>
          Reset
        </button>
      </div>
    </div>
  );
}

export default Counter;