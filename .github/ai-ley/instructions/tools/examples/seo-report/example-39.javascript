// HTML Report must include JavaScript to dynamically load JSON data
<script>
  let seoData = null;

  // Load technical-analysis.json from same directory
  fetch('technical-analysis.json')
    .then(response => response.json())
    .then(data => {
      seoData = data.seo_audit;
      initializeDashboard();
    })
    .catch(error => {
      console.error('Error loading JSON:', error);
      alert('Error loading SEO data. Ensure technical-analysis.json exists.');
    });

  function initializeDashboard() {
    updateScoreCards();
    createCharts();
    populateAllSections();
  }

  function updateScoreCards() {
    // Animate score values from 0 to actual score
    const scores = seoData.overall_scores;
    animateScore('overall-score', scores.total_seo_health);
    animateScore('technical-score', scores.category_scores.technical_seo);
    // ... repeat for all categories
  }

  function createCharts() {
    // Create Chart.js bar chart for category scores
    const ctx = document.getElementById('categoryChart').getContext('2d');
    new Chart(ctx, {
      type: 'bar',
      data: {
        labels: ['Technical', 'Content', 'Performance', 'Strategy', 'Authority'],
        datasets: [{
          label: 'SEO Score',
          data: [/* scores from JSON */],
          backgroundColor: [/* colors based on score ranges */]
        }]
      },
      options: {
        responsive: true,
        scales: { y: { beginAtZero: true, max: 100 } }
      }
    });

    // Create radar chart comparing current vs target scores
    // ... radar chart implementation
  }

  function populateAllSections() {
    populateCriticalIssues();
    populateTechnicalSection();
    populateContentSection();
    // ... populate all other sections from JSON data
  }
</script>