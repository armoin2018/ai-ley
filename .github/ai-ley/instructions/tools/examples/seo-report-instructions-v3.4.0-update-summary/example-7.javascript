async function loadMarkdownFile(filename) {
     // Fetch markdown file via AJAX
     const response = await fetch(filename);
     const markdownText = await response.text();

     // Parse markdown to HTML using marked.js
     const htmlContent = marked.parse(markdownText);

     // Display and enhance
     document.getElementById('markdown-content').innerHTML = htmlContent;
     enhanceMarkdownRendering();
   }