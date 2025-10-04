#!/usr/bin/env python3
"""
SEO Report HTTP Server
======================
Lightweight HTTP server for serving SEO audit report files.
Handles AJAX requests with proper CORS headers and MIME types.

Usage:
    python3 serve_report.py [port]
    
Default port: 8000

Then open: http://localhost:8000/seo-audit-report.html
"""

import http.server
import os
import socketserver
import sys
from datetime import datetime


# Color codes for terminal output
class Colors:
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    BLUE = '\033[94m'
    CYAN = '\033[96m'
    BOLD = '\033[1m'
    END = '\033[0m'

class SEOReportHandler(http.server.SimpleHTTPRequestHandler):
    """Custom HTTP request handler with CORS and proper MIME types"""
    
    # Extended MIME type mappings
    extensions_map = {
        '': 'application/octet-stream',
        '.html': 'text/html',
        '.htm': 'text/html',
        '.css': 'text/css',
        '.js': 'application/javascript',
        '.json': 'application/json',
        '.md': 'text/markdown',
        '.txt': 'text/plain',
        '.csv': 'text/csv',
        '.png': 'image/png',
        '.jpg': 'image/jpeg',
        '.jpeg': 'image/jpeg',
        '.gif': 'image/gif',
        '.svg': 'image/svg+xml',
        '.ico': 'image/x-icon',
        '.woff': 'font/woff',
        '.woff2': 'font/woff2',
        '.ttf': 'font/ttf',
        '.eot': 'application/vnd.ms-fontobject',
        '.otf': 'font/otf',
    }
    
    def end_headers(self):
        """Add CORS headers to all responses"""
        # CORS headers for cross-origin requests
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        
        # Cache control headers
        self.send_header('Cache-Control', 'no-store, no-cache, must-revalidate')
        self.send_header('Expires', '0')
        
        super().end_headers()
    
    def do_OPTIONS(self):
        """Handle preflight CORS requests"""
        self.send_response(200)
        self.end_headers()
    
    def log_message(self, format, *args):
        """Override to add color-coded logging"""
        timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        status_code = args[1] if len(args) > 1 else '000'
        
        # Color code by status
        if status_code.startswith('2'):
            color = Colors.GREEN
        elif status_code.startswith('3'):
            color = Colors.CYAN
        elif status_code.startswith('4'):
            color = Colors.YELLOW
        elif status_code.startswith('5'):
            color = Colors.RED
        else:
            color = Colors.END
        
        print(f"{Colors.BLUE}[{timestamp}]{Colors.END} "
              f"{color}{format % args}{Colors.END}")

def print_banner(port):
    """Print server startup banner with file inventory"""
    print(f"\n{Colors.BOLD}{Colors.CYAN}{'='*60}{Colors.END}")
    print(f"{Colors.BOLD}{Colors.GREEN}SEO Report Server Started{Colors.END}")
    print(f"{Colors.BOLD}{Colors.CYAN}{'='*60}{Colors.END}\n")
    
    print(f"{Colors.YELLOW}Server Information:{Colors.END}")
    print(f"  • Port: {Colors.BOLD}{port}{Colors.END}")
    print(f"  • Directory: {Colors.BOLD}{os.getcwd()}{Colors.END}")
    print(f"  • Access URL: {Colors.BOLD}{Colors.GREEN}http://localhost:{port}/seo-audit-report.html{Colors.END}\n")
    
    print(f"{Colors.YELLOW}Available Files:{Colors.END}")
    
    # List report files
    report_files = [
        ('seo-audit-report.html', 'Interactive Dashboard (START HERE)'),
        ('technical-analysis.json', 'Structured Data (Auto-loaded by HTML)'),
        ('seo-audit-summary.md', 'Executive Summary (View in Markdown tab)'),
        ('seo-analysis.md', 'Detailed Analysis (View in Markdown tab)'),
        ('recommendations.csv', 'Action Items (Download/Open in Excel)'),
        ('README.md', 'Usage Instructions (View in Markdown tab)'),
    ]
    
    for filename, description in report_files:
        if os.path.exists(filename):
            size = os.path.getsize(filename)
            size_kb = size / 1024
            status = f"{Colors.GREEN}✓{Colors.END}"
            print(f"  {status} {Colors.BOLD}{filename:<30}{Colors.END} "
                  f"({size_kb:>6.1f} KB) - {description}")
        else:
            status = f"{Colors.RED}✗{Colors.END}"
            print(f"  {status} {Colors.BOLD}{filename:<30}{Colors.END} "
                  f"{'MISSING':>9} - {description}")
    
    print(f"\n{Colors.YELLOW}Quick Start:{Colors.END}")
    print(f"  1. Open {Colors.BOLD}http://localhost:{port}/seo-audit-report.html{Colors.END} in your browser")
    print(f"  2. Navigate using tabs: Overview, Technical, Content, Performance, etc.")
    print(f"  3. Click {Colors.BOLD}📚 Documentation{Colors.END} tab to view markdown files")
    print(f"  4. Press {Colors.BOLD}{Colors.RED}Ctrl+C{Colors.END} to stop the server\n")
    
    print(f"{Colors.CYAN}{'='*60}{Colors.END}")
    print(f"{Colors.GREEN}Server is running...{Colors.END}\n")

def main():
    """Main server function"""
    # Get port from command line or use default
    port = int(sys.argv[1]) if len(sys.argv) > 1 else 8000
    
    # Create server
    handler = SEOReportHandler
    
    try:
        with socketserver.TCPServer(("", port), handler) as httpd:
            print_banner(port)
            
            # Serve forever
            httpd.serve_forever()
            
    except KeyboardInterrupt:
        print(f"\n\n{Colors.YELLOW}Server stopped by user{Colors.END}")
        print(f"{Colors.GREEN}Thank you for using SEO Report Server!{Colors.END}\n")
        sys.exit(0)
    except OSError as e:
        if e.errno == 48:  # Address already in use
            print(f"\n{Colors.RED}Error: Port {port} is already in use{Colors.END}")
            print(f"{Colors.YELLOW}Try using a different port:{Colors.END}")
            print(f"  python3 serve_report.py 8001\n")
        else:
            print(f"\n{Colors.RED}Error starting server: {e}{Colors.END}\n")
        sys.exit(1)

if __name__ == "__main__":
    main()
