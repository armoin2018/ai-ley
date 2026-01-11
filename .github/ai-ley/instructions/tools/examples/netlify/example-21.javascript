// netlify/edge-functions/feature-flags.js
export default async (request, context) => {
  const url = new URL(request.url);
  const userId = context.cookies.get('user-id');

  // Feature flag logic
  const showNewFeature = shouldShowFeature(userId, 'new-dashboard');

  if (showNewFeature && url.pathname === '/dashboard') {
    return Response.redirect(`${url.origin}/dashboard-v2`, 302);
  }

  return context.next();
};

function shouldShowFeature(userId, featureName) {
  // Implement feature flag logic
  const hash = simpleHash(userId + featureName);
  return hash % 100 < 25; // 25% of users see new feature
}