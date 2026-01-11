// L Wrong - functions are not serializable
const badStore = useStore({
  users: [],
  addUser: (user) => { /* ... */ }  // Functions can't be serialized
});

//  Correct - only data, functions defined separately
const goodStore = useStore({
  users: [],
  loading: false
});

const addUser = $((user) => {
  goodStore.users.push(user);
});