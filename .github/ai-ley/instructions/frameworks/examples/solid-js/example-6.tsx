import { createContext, useContext, createSignal, createMemo, JSX } from 'solid-js';
import { createStore, produce } from 'solid-js/store';

// User Store
interface UserState {
  users: User[];
  loading: boolean;
  error: string | null;
  selectedUser: User | null;
}

interface UserStore {
  state: UserState;
  actions: {
    fetchUsers: () => Promise<void>;
    addUser: (user: Omit<User, 'id'>) => void;
    updateUser: (id: number, updates: Partial<User>) => void;
    deleteUser: (id: number) => void;
    selectUser: (user: User | null) => void;
    clearError: () => void;
  };
}

const UserContext = createContext<UserStore>();

export const UserProvider = (props: { children: JSX.Element }) => {
  const [state, setState] = createStore<UserState>({
    users: [],
    loading: false,
    error: null,
    selectedUser: null
  });
  
  const actions = {
    fetchUsers: async () => {
      setState('loading', true);
      setState('error', null);
      
      try {
        const response = await fetch('/api/users');
        if (!response.ok) throw new Error('Failed to fetch users');
        
        const users = await response.json();
        setState('users', users);
      } catch (error) {
        setState('error', error instanceof Error ? error.message : 'Unknown error');
      } finally {
        setState('loading', false);
      }
    },
    
    addUser: (userData: Omit<User, 'id'>) => {
      const newUser: User = {
        ...userData,
        id: Date.now() // Simple ID generation
      };
      
      setState('users', users => [...users, newUser]);
    },
    
    updateUser: (id: number, updates: Partial<User>) => {
      setState('users', 
        produce(users => {
          const userIndex = users.findIndex(u => u.id === id);
          if (userIndex !== -1) {
            Object.assign(users[userIndex], updates);
          }
        })
      );
    },
    
    deleteUser: (id: number) => {
      setState('users', users => users.filter(u => u.id !== id));
      
      // Clear selection if deleted user was selected
      if (state.selectedUser?.id === id) {
        setState('selectedUser', null);
      }
    },
    
    selectUser: (user: User | null) => {
      setState('selectedUser', user);
    },
    
    clearError: () => {
      setState('error', null);
    }
  };
  
  const store: UserStore = { state, actions };
  
  return (
    <UserContext.Provider value={store}>
      {props.children}
    </UserContext.Provider>
  );
};

export const useUserStore = () => {
  const context = useContext(UserContext);
  if (!context) {
    throw new Error('useUserStore must be used within UserProvider');
  }
  return context;
};

// App State Store (Global)
interface AppState {
  theme: 'light' | 'dark';
  sidebarOpen: boolean;
  notifications: Notification[];
}

interface Notification {
  id: string;
  type: 'success' | 'error' | 'warning' | 'info';
  message: string;
  duration?: number;
}

export const createAppStore = () => {
  const [state, setState] = createStore<AppState>({
    theme: 'light',
    sidebarOpen: false,
    notifications: []
  });
  
  const toggleTheme = () => {
    setState('theme', theme => theme === 'light' ? 'dark' : 'light');
  };
  
  const toggleSidebar = () => {
    setState('sidebarOpen', open => !open);
  };
  
  const addNotification = (notification: Omit<Notification, 'id'>) => {
    const id = crypto.randomUUID();
    const newNotification = { ...notification, id };
    
    setState('notifications', notifications => [...notifications, newNotification]);
    
    // Auto-remove after duration
    if (notification.duration) {
      setTimeout(() => {
        removeNotification(id);
      }, notification.duration);
    }
  };
  
  const removeNotification = (id: string) => {
    setState('notifications', notifications => 
      notifications.filter(n => n.id !== id)
    );
  };
  
  return {
    state,
    toggleTheme,
    toggleSidebar,
    addNotification,
    removeNotification
  };
};