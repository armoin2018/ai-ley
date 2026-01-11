// netlify/edge-functions/geolocation.js
export default async (request, context) => {
  const country = context.geo?.country?.code || 'US';
  const city = context.geo?.city || 'Unknown';

  const url = new URL(request.url);

  // Redirect based on location
  if (url.pathname === '/') {
    if (country === 'CA') {
      return Response.redirect(`${url.origin}/ca`, 302);
    }
    if (country === 'GB') {
      return Response.redirect(`${url.origin}/uk`, 302);
    }
  }

  // Add location headers
  const response = await context.next();
  response.headers.set('X-Country', country);
  response.headers.set('X-City', city);

  return response;
};

// netlify/edge-functions/auth.js
export default async (request, context) => {
  const url = new URL(request.url);

  // Check authentication for protected routes
  if (url.pathname.startsWith('/dashboard')) {
    const token = request.headers.get('Authorization') ||
                  context.cookies.get('auth-token');

    if (!token) {
      return Response.redirect(`${url.origin}/login`, 302);
    }

    // Validate token
    try {
      await validateToken(token);
    } catch (error) {
      return Response.redirect(`${url.origin}/login`, 302);
    }
  }

  return context.next();
};

export const config = {
  path: ["/dashboard/*", "/admin/*"]
};