import { Router, Route, Routes, A, useNavigate, useParams } from '@solidjs/router';
import { Component, lazy } from 'solid-js';

// Lazy load page components
const Home = lazy(() => import('./pages/Home'));
const About = lazy(() => import('./pages/About'));
const UserDetail = lazy(() => import('./pages/UserDetail'));
const NotFound = lazy(() => import('./pages/NotFound'));

// Navigation component
const Navigation: Component = () => {
  return (
    <nav class="navigation">
      <div class="nav-brand">
        <A href="/">My SolidJS App</A>
      </div>
      
      <ul class="nav-links">
        <li><A href="/" activeClass="active">Home</A></li>
        <li><A href="/about" activeClass="active">About</A></li>
        <li><A href="/users" activeClass="active">Users</A></li>
      </ul>
    </nav>
  );
};

// Page component with params
const UserDetail: Component = () => {
  const params = useParams();
  const navigate = useNavigate();
  const [user, setUser] = createSignal<User | null>(null);
  
  createEffect(async () => {
    try {
      const response = await fetch(`/api/users/${params.id}`);
      const userData = await response.json();
      setUser(userData);
    } catch (error) {
      console.error('Failed to load user:', error);
      navigate('/users', { replace: true });
    }
  });
  
  return (
    <div class="user-detail">
      <Show when={user()} fallback={<div>Loading user...</div>}>
        <h1>{user()!.name}</h1>
        <p>Email: {user()!.email}</p>
        <button onClick={() => navigate('/users')}>
          Back to Users
        </button>
      </Show>
    </div>
  );
};

// Main App with Router
const App: Component = () => {
  return (
    <Router>
      <div class="app">
        <Navigation />
        
        <main class="main-content">
          <Routes>
            <Route path="/" component={Home} />
            <Route path="/about" component={About} />
            <Route path="/users" component={UserList} />
            <Route path="/users/:id" component={UserDetail} />
            <Route path="*" component={NotFound} />
          </Routes>
        </main>
      </div>
    </Router>
  );
};

export default App;