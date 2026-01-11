# SEO Audit Report - Viewing Instructions

## Quick Start

1. Start the local server:
   python3 serve_report.py

2. Open in browser:
   http://localhost:8080/seo-audit-report.html

3. View markdown documents:

   - Click "📄 Documents" tab
   - Select document from dropdown

4. Stop the server:
   Press Ctrl+C

## Available Files

- seo-audit-report.html - Interactive dashboard
- technical-analysis.json - Structured data
- seo-audit-summary.md - Executive summary
- seo-analysis.md - Detailed analysis
- recommendations.csv - Action plan
- serve_report.py - Development server

## Troubleshooting

Problem: "Failed to load JSON data"
Solution: Use Python server, not direct file opening

Problem: "Port 8080 already in use"
Solution: Change PORT in serve_report.py

Problem: "Markdown not rendering"
Solution: Check browser console, ensure marked.js loads