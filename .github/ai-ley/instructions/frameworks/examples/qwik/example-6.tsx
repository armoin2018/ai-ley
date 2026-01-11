import { 
  component$, 
  createContextId, 
  useContextProvider, 
  useContext, 
  useStore, 
  $, 
  Slot 
} from '@builder.io/qwik';

// User context and store
interface User {
  id: number;
  name: string;
  email: string;
  avatar?: string;
}

interface UserStore {
  users: User[];
  loading: boolean;
  error: string | null;
  selectedUser: User | null;
}

export const UserContext = createContextId<UserStore>('user-context');

// User Provider Component
export const UserProvider = component$(() => {
  const userStore = useStore<UserStore>({
    users: [],
    loading: false,
    error: null,
    selectedUser: null
  });
  
  useContextProvider(UserContext, userStore);
  
  return <Slot />;
});

// User Actions (Custom Hook Pattern)
export const useUserActions = () => {
  const store = useContext(UserContext);
  
  const fetchUsers = $(async () => {
    store.loading = true;
    store.error = null;
    
    try {
      const response = await fetch('/api/users');
      if (!response.ok) throw new Error('Failed to fetch users');
      
      const users = await response.json();
      store.users = users;
    } catch (error) {
      store.error = error instanceof Error ? error.message : 'Unknown error';
    } finally {
      store.loading = false;
    }
  });
  
  const addUser = $(async (userData: Omit<User, 'id'>) => {
    try {
      const response = await fetch('/api/users', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(userData)
      });
      
      if (!response.ok) throw new Error('Failed to add user');
      
      const newUser = await response.json();
      store.users = [...store.users, newUser];
    } catch (error) {
      store.error = error instanceof Error ? error.message : 'Failed to add user';
    }
  });
  
  const updateUser = $(async (id: number, updates: Partial<User>) => {
    try {
      const response = await fetch(`/api/users/${id}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(updates)
      });
      
      if (!response.ok) throw new Error('Failed to update user');
      
      const updatedUser = await response.json();
      store.users = store.users.map(user => 
        user.id === id ? updatedUser : user
      );
    } catch (error) {
      store.error = error instanceof Error ? error.message : 'Failed to update user';
    }
  });
  
  const deleteUser = $(async (id: number) => {
    try {
      const response = await fetch(`/api/users/${id}`, {
        method: 'DELETE'
      });
      
      if (!response.ok) throw new Error('Failed to delete user');
      
      store.users = store.users.filter(user => user.id !== id);
      
      if (store.selectedUser?.id === id) {
        store.selectedUser = null;
      }
    } catch (error) {
      store.error = error instanceof Error ? error.message : 'Failed to delete user';
    }
  });
  
  const selectUser = $((user: User | null) => {
    store.selectedUser = user;
  });
  
  return {
    fetchUsers,
    addUser,
    updateUser,
    deleteUser,
    selectUser
  };
};

// Component using the store
export const UserList = component$(() => {
  const store = useContext(UserContext);
  const { fetchUsers, deleteUser, selectUser } = useUserActions();
  
  // Fetch users on component mount
  useOnDocument('DOMContentLoaded', fetchUsers);
  
  return (
    <div class="user-list">
      <h2>Users ({store.users.length})</h2>
      
      {store.loading && <div class="loading">Loading users...</div>}
      
      {store.error && (
        <div class="error">
          Error: {store.error}
        </div>
      )}
      
      <div class="users-grid">
        {store.users.map((user) => (
          <div key={user.id} class="user-card">
            <h3>{user.name}</h3>
            <p>{user.email}</p>
            
            <div class="user-actions">
              <button onClick$={() => selectUser(user)}>
                Select
              </button>
              <button 
                onClick$={() => deleteUser(user.id)}
                class="delete-btn"
              >
                Delete
              </button>
            </div>
          </div>
        ))}
      </div>
      
      {store.selectedUser && (
        <div class="selected-user">
          <h3>Selected User:</h3>
          <p>{store.selectedUser.name}</p>
        </div>
      )}
    </div>
  );
});