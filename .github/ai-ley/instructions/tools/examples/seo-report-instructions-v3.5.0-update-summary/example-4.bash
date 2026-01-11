# Analyze with CSV output (default)
python3 analyze_pages.py ./cache/example

# JSON output for automation
python3 analyze_pages.py ./cache/example --format json

# Generate both formats
python3 analyze_pages.py ./cache/example --format both

# Custom output path
python3 analyze_pages.py ./cache/example --output ./reports/page-analysis.csv