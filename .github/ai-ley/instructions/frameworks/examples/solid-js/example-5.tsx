import { Component, JSX, createSignal, Show, For } from 'solid-js';

// Type definitions
interface User {
  id: number;
  name: string;
  email: string;
  avatar?: string;
  isActive: boolean;
}

interface UserCardProps {
  user: User;
  onEdit?: (user: User) => void;
  onDelete?: (userId: number) => void;
  showActions?: boolean;
}

// Reusable UserCard Component
const UserCard: Component<UserCardProps> = (props) => {
  const [isExpanded, setIsExpanded] = createSignal(false);
  
  const handleEdit = () => {
    props.onEdit?.(props.user);
  };
  
  const handleDelete = () => {
    if (confirm(`Delete user ${props.user.name}?`)) {
      props.onDelete?.(props.user.id);
    }
  };
  
  return (
    <div class={`user-card ${props.user.isActive ? 'active' : 'inactive'}`}>
      <div class="user-header" onClick={() => setIsExpanded(!isExpanded())}>
        <Show when={props.user.avatar}>
          <img src={props.user.avatar} alt={`${props.user.name} avatar`} />
        </Show>
        
        <div class="user-info">
          <h3>{props.user.name}</h3>
          <p>{props.user.email}</p>
        </div>
        
        <div class="status-indicator">
          <span class={`status ${props.user.isActive ? 'online' : 'offline'}`}>
            {props.user.isActive ? 'Online' : 'Offline'}
          </span>
        </div>
      </div>
      
      <Show when={isExpanded()}>
        <div class="user-details">
          <p>User ID: {props.user.id}</p>
          <p>Status: {props.user.isActive ? 'Active' : 'Inactive'}</p>
          
          <Show when={props.showActions}>
            <div class="actions">
              <button class="edit-btn" onClick={handleEdit}>
                Edit
              </button>
              <button class="delete-btn" onClick={handleDelete}>
                Delete
              </button>
            </div>
          </Show>
        </div>
      </Show>
    </div>
  );
};

// UserList Component with iteration
interface UserListProps {
  users: User[];
  onUserEdit?: (user: User) => void;
  onUserDelete?: (userId: number) => void;
}

const UserList: Component<UserListProps> = (props) => {
  const [filter, setFilter] = createSignal('');
  
  const filteredUsers = createMemo(() => {
    const filterText = filter().toLowerCase();
    return props.users.filter(user => 
      user.name.toLowerCase().includes(filterText) ||
      user.email.toLowerCase().includes(filterText)
    );
  });
  
  return (
    <div class="user-list">
      <div class="list-header">
        <h2>Users ({filteredUsers().length})</h2>
        <input
          type="search"
          placeholder="Search users..."
          value={filter()}
          onInput={(e) => setFilter(e.currentTarget.value)}
        />
      </div>
      
      <div class="list-content">
        <For each={filteredUsers()}>
          {(user) => (
            <UserCard
              user={user}
              showActions={true}
              onEdit={props.onUserEdit}
              onDelete={props.onUserDelete}
            />
          )}
        </For>
        
        <Show when={filteredUsers().length === 0}>
          <div class="empty-state">
            <p>No users found matching your search.</p>
          </div>
        </Show>
      </div>
    </div>
  );
};

export { UserCard, UserList };
export type { User, UserCardProps, UserListProps };