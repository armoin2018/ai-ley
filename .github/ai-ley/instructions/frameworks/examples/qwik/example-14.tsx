// L Wrong - different content on server vs client
const BadComponent = component$(() => {
  return <div>{Date.now()}</div>;  // Will be different on server vs client
});

//  Correct - consistent content
const GoodComponent = component$(() => {
  const timestamp = useSignal(0);
  
  useVisibleTask$(() => {
    // Client-side only
    timestamp.value = Date.now();
  });
  
  return (
    <div>
      {isServer ? 'Loading...' : `Time: ${timestamp.value}`}
    </div>
  );
});