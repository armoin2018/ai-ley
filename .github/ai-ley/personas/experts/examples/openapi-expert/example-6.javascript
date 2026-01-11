// swagger-ui-setup.js
import SwaggerUI from 'swagger-ui-bundle';
import 'swagger-ui-bundle/swagger-ui-bundle.css';

SwaggerUI({
  url: './openapi.yaml',
  dom_id: '#swagger-ui',
  deepLinking: true,
  presets: [
    SwaggerUI.presets.apis,
    SwaggerUI.presets.standalone
  ],
  plugins: [
    SwaggerUI.plugins.DownloadUrl
  ],
  layout: "StandaloneLayout",
  requestInterceptor: (request) => {
    // Add authentication token
    const token = localStorage.getItem('authToken');
    if (token) {
      request.headers.Authorization = `Bearer ${token}`;
    }
    return request;
  },
  responseInterceptor: (response) => {
    // Handle API responses
    console.log('API Response:', response);
    return response;
  }
});