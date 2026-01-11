const ComponentWithCleanup = () => {
  const [data, setData] = createSignal(null);
  
  //  Proper cleanup
  createEffect(() => {
    const controller = new AbortController();
    
    fetch('/api/data', { signal: controller.signal })
      .then(response => response.json())
      .then(setData);
    
    onCleanup(() => {
      controller.abort();
    });
  });
  
  return <div>{data()}</div>;
};