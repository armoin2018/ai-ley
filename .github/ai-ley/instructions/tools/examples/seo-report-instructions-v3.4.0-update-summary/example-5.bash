# Navigate to report directory
cd .project/seo/{domain}/{YYYY.MM.DD}/

# Make executable (first time only)
chmod +x serve_report.py

# Start server
python3 serve_report.py

# Access in browser
open http://localhost:8080/seo-audit-report.html

# Stop server
# Press Ctrl+C