// ✅ Debouncing for frequent operations
function debounce(func, delay) {
  let timeoutId;
  
  return function debounced(...args) {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => func.apply(this, args), delay);
  };
}

// ✅ Throttling for rate limiting
function throttle(func, limit) {
  let inThrottle;
  
  return function throttled(...args) {
    if (!inThrottle) {
      func.apply(this, args);
      inThrottle = true;
      setTimeout(() => inThrottle = false, limit);
    }
  };
}

// ✅ Memoization for expensive calculations
function memoize(fn) {
  const cache = new Map();
  
  return function memoized(...args) {
    const key = JSON.stringify(args);
    
    if (cache.has(key)) {
      return cache.get(key);
    }
    
    const result = fn.apply(this, args);
    cache.set(key, result);
    
    return result;
  };
}

// ✅ Lazy evaluation for large datasets
function* lazyFilter(iterable, predicate) {
  for (const item of iterable) {
    if (predicate(item)) {
      yield item;
    }
  }
}

function* lazyMap(iterable, mapper) {
  for (const item of iterable) {
    yield mapper(item);
  }
}

// Usage
const largeDataset = [/* millions of items */];
const processedData = lazyMap(
  lazyFilter(largeDataset, item => item.isValid),
  item => ({ id: item.id, name: item.name })
);

// Only processes items as needed
for (const item of processedData) {
  if (someCondition) break; // Can exit early
  console.log(item);
}