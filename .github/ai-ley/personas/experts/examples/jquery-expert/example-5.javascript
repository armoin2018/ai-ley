// jQuery AJAX implementation
function fetchData(endpoint, options = {}) {
  return $.ajax({
    url: endpoint,
    method: 'GET',
    dataType: 'json',
    timeout: 10000,
    ...options
  })
  .done(function(data, textStatus, jqXHR) {
    console.log('Data loaded successfully');
  })
  .fail(function(jqXHR, textStatus, errorThrown) {
    handleAjaxError(jqXHR, textStatus, errorThrown);
  })
  .always(function() {
    $('.loading-spinner').addClass('d-none');
  });
}

// Modern fetch equivalent
async function fetchData(endpoint, options = {}) {
  const loadingSpinner = document.querySelector('.loading-spinner');
  
  try {
    const response = await fetch(endpoint, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        ...options.headers
      },
      ...options
    });
    
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }
    
    const data = await response.json();
    console.log('Data loaded successfully');
    return data;
    
  } catch (error) {
    handleFetchError(error);
    throw error;
  } finally {
    loadingSpinner.classList.add('d-none');
  }
}