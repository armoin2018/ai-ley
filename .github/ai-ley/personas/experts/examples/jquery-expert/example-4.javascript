// jQuery with performance optimization
$(document).ready(function() {
  // Cache jQuery objects
  const $container = $('#data-container');
  const $loadingSpinner = $('.loading-spinner');
  
  // Efficient batch DOM updates
  function updateDataDisplay(data) {
    const $fragment = $(document.createDocumentFragment());
    
    data.forEach(item => {
      const $row = $(`
        <div class="data-row" data-id="${item.id}">
          <h3>${item.title}</h3>
          <p>${item.description}</p>
          <button class="btn-action" data-action="edit">Edit</button>
        </div>
      `);
      $fragment.append($row);
    });
    
    $container.empty().append($fragment);
  }
  
  // Event delegation for dynamic content
  $container.on('click', '.btn-action', function(e) {
    e.preventDefault();
    const action = $(this).data('action');
    const itemId = $(this).closest('.data-row').data('id');
    handleAction(action, itemId);
  });
});

// Vanilla JavaScript equivalent
const container = document.getElementById('data-container');
const loadingSpinner = document.querySelector('.loading-spinner');

function updateDataDisplay(data) {
  const fragment = document.createDocumentFragment();
  
  data.forEach(item => {
    const row = document.createElement('div');
    row.className = 'data-row';
    row.dataset.id = item.id;
    row.innerHTML = `
      <h3>${item.title}</h3>
      <p>${item.description}</p>
      <button class="btn-action" data-action="edit">Edit</button>
    `;
    fragment.appendChild(row);
  });
  
  container.replaceChildren(fragment);
}

container.addEventListener('click', function(e) {
  if (e.target.matches('.btn-action')) {
    e.preventDefault();
    const action = e.target.dataset.action;
    const itemId = e.target.closest('.data-row').dataset.id;
    handleAction(action, itemId);
  }
});