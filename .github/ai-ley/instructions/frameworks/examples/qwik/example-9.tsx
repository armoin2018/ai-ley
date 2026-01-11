import { routeLoader$, server$ } from '@builder.io/qwik-city';
import { component$, Resource, useResource$ } from '@builder.io/qwik';

// Route loader for SSR data
export const useProductData = routeLoader$(async (requestEvent) => {
  const productId = requestEvent.params.productId;
  
  // Server-side data fetching
  const response = await fetch(`${requestEvent.env.get('API_URL')}/products/${productId}`);
  
  if (!response.ok) {
    throw requestEvent.error(404, 'Product not found');
  }
  
  return response.json();
});

// Server function for API calls
export const fetchRelatedProducts = server$(async function(productId: string) {
  // This runs on the server
  const response = await fetch(`${this.env.get('API_URL')}/products/${productId}/related`);
  return response.json();
});

// Component with client-side data fetching
export const ProductDetail = component$(() => {
  const productData = useProductData();
  
  // Client-side resource for related products
  const relatedProductsResource = useResource$<any[]>(async ({ track, cleanup }) => {
    // Track product ID changes
    const productId = track(() => productData.value.id);
    
    // Abort controller for cleanup
    const controller = new AbortController();
    cleanup(() => controller.abort());
    
    try {
      const relatedProducts = await fetchRelatedProducts(productId);
      return relatedProducts;
    } catch (error) {
      if (error.name === 'AbortError') {
        return [];
      }
      throw error;
    }
  });
  
  return (
    <div class="product-detail">
      <div class="product-info">
        <h1>{productData.value.name}</h1>
        <p>{productData.value.description}</p>
        <p class="price">${productData.value.price}</p>
      </div>
      
      <div class="related-products">
        <h2>Related Products</h2>
        <Resource
          value={relatedProductsResource}
          onPending={() => <div>Loading related products...</div>}
          onRejected={(error) => <div>Error loading related products: {error.message}</div>}
          onResolved={(relatedProducts) => (
            <div class="products-grid">
              {relatedProducts.map((product) => (
                <div key={product.id} class="product-card">
                  <h3>{product.name}</h3>
                  <p>${product.price}</p>
                </div>
              ))}
            </div>
          )}
        />
      </div>
    </div>
  );
});