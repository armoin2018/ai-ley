# Generate CSV
python3 analyze_pages.py ./cache/example --format csv

# Open in Excel
open page-analysis.csv

# Sort by Priority column (CRITICAL first)
# Filter by specific scores (e.g., Content Score < 70)
# Create action plan from All Issues column