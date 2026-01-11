// Server Component (runs on server)
async function ServerUserProfile({ userId }: { userId: string }) {
  // This runs on the server, can access databases directly
  const user = await getUserFromDatabase(userId);
  
  return (
    <div>
      <h1>{user.name}</h1>
      <ClientInteractiveButton userId={userId} />
    </div>
  );
}

// Client Component (runs in browser)
'use client';
function ClientInteractiveButton({ userId }: { userId: string }) {
  const [liked, setLiked] = useState(false);
  
  return (
    <button onClick={() => setLiked(!liked)}>
      {liked ? 'Unlike' : 'Like'}
    </button>
  );
}