// Add marked.js library via CDN in HTML <head>
// <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>

let currentMarkdownFile = '';
let currentMarkdownContent = '';

/**
 * Load and render markdown file
 */
async function loadMarkdownFile(filename) {
  if (!filename) {
    document.getElementById('markdown-content').innerHTML =
      '<p class="placeholder">Select a document to view...</p>';
    return;
  }

  try {
    const response = await fetch(filename);
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    const markdownText = await response.text();
    currentMarkdownFile = filename;
    currentMarkdownContent = markdownText;

    // Render markdown to HTML using marked.js
    const htmlContent = marked.parse(markdownText);

    // Display rendered content
    document.getElementById('markdown-content').innerHTML = htmlContent;

    // Enhance rendered content
    enhanceMarkdownRendering();

    console.log(`✓ Loaded: ${filename} (${markdownText.length} bytes)`);
  } catch (error) {
    console.error('Error loading markdown:', error);
    document.getElementById('markdown-content').innerHTML = `
      <div class="error-message">
        <h3>⚠️ Error Loading Document</h3>
        <p><strong>File:</strong> ${filename}</p>
        <p><strong>Error:</strong> ${error.message}</p>
        <p>Make sure the Python server is running and the file exists.</p>
      </div>
    `;
  }
}

/**
 * Enhance rendered markdown with syntax highlighting and interactive features
 */
function enhanceMarkdownRendering() {
  const content = document.getElementById('markdown-content');

  // Add anchor links to headings
  const headings = content.querySelectorAll('h1, h2, h3, h4, h5, h6');
  headings.forEach((heading) => {
    const id = heading.textContent
      .toLowerCase()
      .replace(/[^\w\s-]/g, '')
      .replace(/\s+/g, '-');
    heading.id = id;

    // Add copy link button
    const linkBtn = document.createElement('a');
    linkBtn.href = `#${id}`;
    linkBtn.className = 'heading-anchor';
    linkBtn.innerHTML = '🔗';
    linkBtn.title = 'Copy link to this section';
    heading.appendChild(linkBtn);
  });

  // Make tables responsive
  const tables = content.querySelectorAll('table');
  tables.forEach((table) => {
    const wrapper = document.createElement('div');
    wrapper.className = 'table-wrapper';
    table.parentNode.insertBefore(wrapper, table);
    wrapper.appendChild(table);
  });

  // Add copy buttons to code blocks
  const codeBlocks = content.querySelectorAll('pre code');
  codeBlocks.forEach((block) => {
    const pre = block.parentElement;
    const copyBtn = document.createElement('button');
    copyBtn.className = 'copy-code-btn';
    copyBtn.innerHTML = '📋 Copy';
    copyBtn.onclick = () => copyCodeToClipboard(block.textContent, copyBtn);
    pre.appendChild(copyBtn);
  });
}

/**
 * Copy code block content to clipboard
 */
function copyCodeToClipboard(text, button) {
  navigator.clipboard
    .writeText(text)
    .then(() => {
      const originalText = button.innerHTML;
      button.innerHTML = '✓ Copied!';
      button.classList.add('copied');

      setTimeout(() => {
        button.innerHTML = originalText;
        button.classList.remove('copied');
      }, 2000);
    })
    .catch((err) => {
      console.error('Failed to copy:', err);
      alert('Failed to copy to clipboard');
    });
}

/**
 * Download current markdown file
 */
function downloadMarkdown() {
  if (!currentMarkdownFile || !currentMarkdownContent) {
    alert('No document loaded to download');
    return;
  }

  const blob = new Blob([currentMarkdownContent], { type: 'text/markdown' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = currentMarkdownFile;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  URL.revokeObjectURL(url);

  console.log(`✓ Downloaded: ${currentMarkdownFile}`);
}

// Configure marked.js options for better rendering
marked.setOptions({
  headerIds: true,
  mangle: false,
  breaks: true,
  gfm: true, // GitHub Flavored Markdown
  tables: true,
  smartLists: true,
  smartypants: true,
});