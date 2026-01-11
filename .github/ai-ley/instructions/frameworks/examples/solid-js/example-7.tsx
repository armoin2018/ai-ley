import { createSignal, createMemo, For, Index, lazy, Suspense } from 'solid-js';
import { Dynamic } from 'solid-js/web';

// Lazy loading components
const LazyModal = lazy(() => import('./Modal'));
const LazyChart = lazy(() => import('./Chart'));

// Optimized list rendering
const OptimizedList = () => {
  const [items, setItems] = createSignal<Array<{ id: number; name: string; data: any }>>([]);
  
  // Use Index for referentially stable items
  return (
    <div class="optimized-list">
      <Index each={items()}>
        {(item, index) => (
          <div class="list-item">
            <span>{item().name}</span>
            <button onClick={() => {
              setItems(items => items.filter((_, i) => i !== index));
            }}>
              Remove
            </button>
          </div>
        )}
      </Index>
    </div>
  );
};

// Memoized expensive calculations
const ExpensiveComponent = (props: { data: number[] }) => {
  const expensiveCalculation = createMemo(() => {
    console.log('Performing expensive calculation...');
    return props.data.reduce((sum, num) => {
      // Simulate expensive operation
      for (let i = 0; i < 100000; i++) {
        sum += Math.sin(num * i);
      }
      return sum;
    }, 0);
  });
  
  return (
    <div>
      <h3>Expensive Calculation Result:</h3>
      <p>{expensiveCalculation().toFixed(2)}</p>
    </div>
  );
};

// Dynamic component loading
const DynamicComponentLoader = () => {
  const [componentType, setComponentType] = createSignal('button');
  
  const componentMap = {
    button: () => <button>Dynamic Button</button>,
    input: () => <input placeholder="Dynamic Input" />,
    textarea: () => <textarea placeholder="Dynamic Textarea" />
  };
  
  return (
    <div>
      <select 
        value={componentType()} 
        onChange={(e) => setComponentType(e.currentTarget.value)}
      >
        <option value="button">Button</option>
        <option value="input">Input</option>
        <option value="textarea">Textarea</option>
      </select>
      
      <Dynamic component={componentMap[componentType() as keyof typeof componentMap]} />
    </div>
  );
};

// Resource loading with Suspense
const DataComponent = () => {
  return (
    <Suspense fallback={<div>Loading chart...</div>}>
      <LazyChart />
    </Suspense>
  );
};