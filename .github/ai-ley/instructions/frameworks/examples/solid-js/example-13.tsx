// L Wrong - not calling signal as function
const BadComponent = () => {
  const [count, setCount] = createSignal(0);
  return <div>{count}</div>; // Missing function call
};

//  Correct - calling signal as function
const GoodComponent = () => {
  const [count, setCount] = createSignal(0);
  return <div>{count()}</div>; // Proper function call
};