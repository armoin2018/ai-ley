// Automatic optimization of components and hooks
// No need for manual useMemo/useCallback in many cases
const OptimizedComponent = ({ items, onSelect }) => {
  // React Compiler automatically optimizes this
  const expensiveValue = items.filter(item => item.isActive)
    .map(item => ({ ...item, processed: true }));
  
  return (
    <ul>
      {expensiveValue.map(item => (
        <li key={item.id} onClick={() => onSelect(item)}>
          {item.name}
        </li>
      ))}
    </ul>
  );
};