#!/usr/bin/env python3
"""
Website Crawler for SEO Analysis
=================================
Crawls a target website extracting textual content, metadata, and structural
information for comprehensive per-page SEO analysis.

Features:
- Robots.txt compliance
- Sitemap parsing and URL discovery
- Configurable crawl depth and page limits
- Content extraction (text, headings, meta tags, links)
- Cache management for offline analysis
- Rate limiting and polite crawling

Usage:
    python3 crawl_site.py https://example.com
    python3 crawl_site.py https://example.com --max-pages 50 --max-depth 3
    python3 crawl_site.py https://example.com --output-dir ./cache/example

Requirements:
    pip install requests beautifulsoup4 lxml urllib3
"""

import argparse
import hashlib
import json
import os
import sys
import time
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional, Set
from urllib.parse import urljoin, urlparse, urlunparse
from urllib.robotparser import RobotFileParser

try:
    import requests
    from bs4 import BeautifulSoup
except ImportError:
    print("ERROR: Required packages not installed.")
    print("Install with: pip install requests beautifulsoup4 lxml")
    sys.exit(1)

# Color codes for terminal output
class Colors:
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    BLUE = '\033[94m'
    CYAN = '\033[96m'
    BOLD = '\033[1m'
    END = '\033[0m'


class WebsiteCrawler:
    """
    Polite website crawler that respects robots.txt and implements
    rate limiting for ethical SEO analysis.
    """
    
    def __init__(self, base_url: str, output_dir: str, max_pages: int = 100, 
                 max_depth: int = 3, delay: float = 1.0):
        self.base_url = self._normalize_url(base_url)
        self.domain = urlparse(self.base_url).netloc
        self.output_dir = Path(output_dir)
        self.max_pages = max_pages
        self.max_depth = max_depth
        self.delay = delay
        
        # Tracking sets
        self.visited_urls: Set[str] = set()
        self.to_visit: List[tuple] = [(self.base_url, 0)]  # (url, depth)
        self.failed_urls: Set[str] = set()
        
        # Statistics
        self.stats = {
            'pages_crawled': 0,
            'pages_failed': 0,
            'total_time': 0,
            'start_time': datetime.now().isoformat(),
            'end_time': None
        }
        
        # Setup
        self._setup_directories()
        self._load_robots_txt()
        self._setup_session()
        
    def _normalize_url(self, url: str) -> str:
        """Normalize URL to ensure consistency"""
        if not url.startswith(('http://', 'https://')):
            url = 'https://' + url
        parsed = urlparse(url)
        # Remove trailing slash from path
        path = parsed.path.rstrip('/')
        return urlunparse((parsed.scheme, parsed.netloc, path, '', '', ''))
    
    def _setup_directories(self):
        """Create output directory structure"""
        self.output_dir.mkdir(parents=True, exist_ok=True)
        (self.output_dir / 'pages').mkdir(exist_ok=True)
        (self.output_dir / 'metadata').mkdir(exist_ok=True)
        
    def _setup_session(self):
        """Setup requests session with appropriate headers"""
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (compatible; SEO-Crawler/1.0; +https://github.com/ai-ley)',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
            'Accept-Language': 'en-US,en;q=0.5',
            'Accept-Encoding': 'gzip, deflate',
            'DNT': '1',
            'Connection': 'keep-alive',
            'Upgrade-Insecure-Requests': '1'
        })
        
    def _load_robots_txt(self):
        """Parse and load robots.txt rules"""
        self.robot_parser = RobotFileParser()
        robots_url = urljoin(self.base_url, '/robots.txt')
        
        try:
            response = requests.get(robots_url, timeout=10)
            if response.status_code == 200:
                self.robot_parser.parse(response.text.splitlines())
                print(f"{Colors.GREEN}✓{Colors.END} Loaded robots.txt from {robots_url}")
            else:
                print(f"{Colors.YELLOW}⚠{Colors.END} No robots.txt found (assuming allowed)")
        except Exception as e:
            print(f"{Colors.YELLOW}⚠{Colors.END} Could not load robots.txt: {e}")
            
    def _is_allowed(self, url: str) -> bool:
        """Check if URL is allowed by robots.txt"""
        return self.robot_parser.can_fetch('*', url)
    
    def _is_same_domain(self, url: str) -> bool:
        """Check if URL belongs to the same domain"""
        return urlparse(url).netloc == self.domain
    
    def _should_crawl(self, url: str) -> bool:
        """Determine if URL should be crawled"""
        # Skip if already visited
        if url in self.visited_urls:
            return False
            
        # Skip if not same domain
        if not self._is_same_domain(url):
            return False
            
        # Skip common non-HTML files
        excluded_extensions = ['.pdf', '.jpg', '.jpeg', '.png', '.gif', '.svg', 
                              '.zip', '.rar', '.tar', '.gz', '.css', '.js', 
                              '.xml', '.json', '.mp4', '.mp3', '.doc', '.docx']
        if any(url.lower().endswith(ext) for ext in excluded_extensions):
            return False
            
        # Check robots.txt
        if not self._is_allowed(url):
            return False
            
        return True
    
    def _get_url_id(self, url: str) -> str:
        """Generate unique ID for URL using hash"""
        return hashlib.md5(url.encode()).hexdigest()[:12]
    
    def _extract_content(self, url: str, html: str) -> Dict:
        """Extract all relevant content and metadata from HTML"""
        soup = BeautifulSoup(html, 'lxml')
        
        # Remove script and style elements
        for element in soup(['script', 'style', 'noscript', 'iframe']):
            element.decompose()
        
        # Extract metadata
        title = soup.find('title')
        title_text = title.get_text().strip() if title else ''
        
        meta_desc = soup.find('meta', attrs={'name': 'description'})
        meta_desc_text = meta_desc.get('content', '').strip() if meta_desc else ''
        
        # Extract canonical URL
        canonical = soup.find('link', attrs={'rel': 'canonical'})
        canonical_url = canonical.get('href', '') if canonical else ''
        
        # Extract headings
        headings = {
            'h1': [h.get_text().strip() for h in soup.find_all('h1')],
            'h2': [h.get_text().strip() for h in soup.find_all('h2')],
            'h3': [h.get_text().strip() for h in soup.find_all('h3')],
            'h4': [h.get_text().strip() for h in soup.find_all('h4')],
            'h5': [h.get_text().strip() for h in soup.find_all('h5')],
            'h6': [h.get_text().strip() for h in soup.find_all('h6')],
        }
        
        # Extract all text content
        text_content = soup.get_text(separator=' ', strip=True)
        word_count = len(text_content.split())
        
        # Extract links
        internal_links = []
        external_links = []
        
        for link in soup.find_all('a', href=True):
            href = link.get('href', '').strip()
            if not href or href.startswith(('#', 'javascript:', 'mailto:', 'tel:')):
                continue
                
            # Resolve relative URLs
            absolute_url = urljoin(url, href)
            normalized_url = self._normalize_url(absolute_url)
            
            if self._is_same_domain(normalized_url):
                internal_links.append({
                    'url': normalized_url,
                    'text': link.get_text().strip(),
                    'title': link.get('title', '')
                })
            else:
                external_links.append({
                    'url': normalized_url,
                    'text': link.get_text().strip(),
                    'title': link.get('title', '')
                })
        
        # Extract images
        images = []
        for img in soup.find_all('img'):
            images.append({
                'src': img.get('src', ''),
                'alt': img.get('alt', ''),
                'title': img.get('title', ''),
                'width': img.get('width', ''),
                'height': img.get('height', '')
            })
        
        # Extract Open Graph metadata
        og_data = {}
        for og_tag in soup.find_all('meta', attrs={'property': lambda x: x and x.startswith('og:')}):
            property_name = og_tag.get('property', '').replace('og:', '')
            og_data[property_name] = og_tag.get('content', '')
        
        # Extract Twitter Card metadata
        twitter_data = {}
        for tw_tag in soup.find_all('meta', attrs={'name': lambda x: x and x.startswith('twitter:')}):
            property_name = tw_tag.get('name', '').replace('twitter:', '')
            twitter_data[property_name] = tw_tag.get('content', '')
        
        # Extract schema.org markup
        schema_scripts = soup.find_all('script', attrs={'type': 'application/ld+json'})
        schema_data = []
        for script in schema_scripts:
            try:
                schema_data.append(json.loads(script.string))
            except:
                pass
        
        return {
            'url': url,
            'title': title_text,
            'title_length': len(title_text),
            'meta_description': meta_desc_text,
            'meta_description_length': len(meta_desc_text),
            'canonical_url': canonical_url,
            'headings': headings,
            'word_count': word_count,
            'text_content': text_content[:5000],  # First 5000 chars
            'internal_links': internal_links,
            'internal_link_count': len(internal_links),
            'external_links': external_links,
            'external_link_count': len(external_links),
            'images': images,
            'image_count': len(images),
            'images_without_alt': len([img for img in images if not img['alt']]),
            'open_graph': og_data,
            'twitter_card': twitter_data,
            'schema_markup': schema_data,
            'crawled_at': datetime.now().isoformat()
        }
    
    def _save_page_data(self, url: str, content_data: Dict, response_data: Dict):
        """Save page data to cache"""
        url_id = self._get_url_id(url)
        
        # Save full content data
        content_file = self.output_dir / 'pages' / f'{url_id}.json'
        with open(content_file, 'w', encoding='utf-8') as f:
            json.dump(content_data, f, indent=2, ensure_ascii=False)
        
        # Save metadata
        metadata = {
            'url': url,
            'url_id': url_id,
            'status_code': response_data.get('status_code'),
            'content_type': response_data.get('content_type'),
            'content_length': response_data.get('content_length'),
            'response_time': response_data.get('response_time'),
            'crawled_at': content_data['crawled_at']
        }
        
        metadata_file = self.output_dir / 'metadata' / f'{url_id}.json'
        with open(metadata_file, 'w', encoding='utf-8') as f:
            json.dump(metadata, f, indent=2)
    
    def crawl_page(self, url: str) -> Optional[Dict]:
        """Crawl a single page and extract content"""
        try:
            start_time = time.time()
            
            response = self.session.get(url, timeout=30, allow_redirects=True)
            response_time = time.time() - start_time
            
            # Check if successful
            if response.status_code != 200:
                print(f"{Colors.RED}✗{Colors.END} {url} (Status: {response.status_code})")
                self.failed_urls.add(url)
                self.stats['pages_failed'] += 1
                return None
            
            # Check if HTML content
            content_type = response.headers.get('content-type', '').lower()
            if 'text/html' not in content_type:
                print(f"{Colors.YELLOW}⚠{Colors.END} {url} (Not HTML: {content_type})")
                return None
            
            # Extract content
            content_data = self._extract_content(url, response.text)
            
            # Save response metadata
            response_data = {
                'status_code': response.status_code,
                'content_type': content_type,
                'content_length': len(response.content),
                'response_time': response_time
            }
            
            # Save to cache
            self._save_page_data(url, content_data, response_data)
            
            # Update statistics
            self.stats['pages_crawled'] += 1
            
            print(f"{Colors.GREEN}✓{Colors.END} {url} "
                  f"({content_data['word_count']} words, "
                  f"{content_data['internal_link_count']} internal links, "
                  f"{response_time:.2f}s)")
            
            return content_data
            
        except requests.exceptions.Timeout:
            print(f"{Colors.RED}✗{Colors.END} {url} (Timeout)")
            self.failed_urls.add(url)
            self.stats['pages_failed'] += 1
            return None
        except Exception as e:
            print(f"{Colors.RED}✗{Colors.END} {url} (Error: {str(e)[:50]})")
            self.failed_urls.add(url)
            self.stats['pages_failed'] += 1
            return None
    
    def crawl(self):
        """Main crawl loop"""
        print(f"\n{Colors.BOLD}{Colors.CYAN}{'='*70}{Colors.END}")
        print(f"{Colors.BOLD}{Colors.GREEN}Website Crawler Started{Colors.END}")
        print(f"{Colors.BOLD}{Colors.CYAN}{'='*70}{Colors.END}\n")
        
        print(f"{Colors.YELLOW}Configuration:{Colors.END}")
        print(f"  • Base URL: {Colors.BOLD}{self.base_url}{Colors.END}")
        print(f"  • Max Pages: {Colors.BOLD}{self.max_pages}{Colors.END}")
        print(f"  • Max Depth: {Colors.BOLD}{self.max_depth}{Colors.END}")
        print(f"  • Rate Limit: {Colors.BOLD}{self.delay}s{Colors.END} between requests")
        print(f"  • Output Dir: {Colors.BOLD}{self.output_dir}{Colors.END}\n")
        
        crawl_start = time.time()
        
        while self.to_visit and self.stats['pages_crawled'] < self.max_pages:
            url, depth = self.to_visit.pop(0)
            
            # Skip if too deep
            if depth > self.max_depth:
                continue
            
            # Skip if already visited
            if url in self.visited_urls:
                continue
            
            # Check if allowed
            if not self._should_crawl(url):
                continue
            
            # Mark as visited
            self.visited_urls.add(url)
            
            # Crawl the page
            content_data = self.crawl_page(url)
            
            # Add internal links to queue
            if content_data:
                for link in content_data.get('internal_links', []):
                    link_url = link['url']
                    if link_url not in self.visited_urls and self._should_crawl(link_url):
                        self.to_visit.append((link_url, depth + 1))
            
            # Rate limiting
            time.sleep(self.delay)
        
        crawl_end = time.time()
        self.stats['total_time'] = crawl_end - crawl_start
        self.stats['end_time'] = datetime.now().isoformat()
        
        self._save_crawl_summary()
        self._print_summary()
    
    def _save_crawl_summary(self):
        """Save crawl statistics and summary"""
        summary = {
            'base_url': self.base_url,
            'domain': self.domain,
            'configuration': {
                'max_pages': self.max_pages,
                'max_depth': self.max_depth,
                'rate_limit': self.delay
            },
            'statistics': self.stats,
            'pages_crawled': list(self.visited_urls),
            'pages_failed': list(self.failed_urls),
            'total_urls_discovered': len(self.visited_urls) + len(self.to_visit)
        }
        
        summary_file = self.output_dir / 'crawl_summary.json'
        with open(summary_file, 'w', encoding='utf-8') as f:
            json.dump(summary, f, indent=2, ensure_ascii=False)
    
    def _print_summary(self):
        """Print crawl summary"""
        print(f"\n{Colors.BOLD}{Colors.CYAN}{'='*70}{Colors.END}")
        print(f"{Colors.BOLD}{Colors.GREEN}Crawl Complete!{Colors.END}")
        print(f"{Colors.BOLD}{Colors.CYAN}{'='*70}{Colors.END}\n")
        
        print(f"{Colors.YELLOW}Statistics:{Colors.END}")
        print(f"  • Pages Crawled: {Colors.GREEN}{self.stats['pages_crawled']}{Colors.END}")
        print(f"  • Pages Failed: {Colors.RED}{self.stats['pages_failed']}{Colors.END}")
        print(f"  • Total Time: {Colors.BOLD}{self.stats['total_time']:.2f}s{Colors.END}")
        print(f"  • Avg Time/Page: {Colors.BOLD}{self.stats['total_time']/max(self.stats['pages_crawled'], 1):.2f}s{Colors.END}")
        print(f"\n{Colors.YELLOW}Output:{Colors.END}")
        print(f"  • Data Directory: {Colors.BOLD}{self.output_dir}{Colors.END}")
        print(f"  • Summary File: {Colors.BOLD}{self.output_dir / 'crawl_summary.json'}{Colors.END}")
        print(f"\n{Colors.YELLOW}Next Steps:{Colors.END}")
        print(f"  Run per-page analysis: {Colors.BOLD}python3 analyze_pages.py {self.output_dir}{Colors.END}\n")


def main():
    parser = argparse.ArgumentParser(
        description='Crawl website for SEO analysis',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python3 crawl_site.py https://example.com
  python3 crawl_site.py https://example.com --max-pages 50 --max-depth 3
  python3 crawl_site.py https://example.com --output-dir ./cache/example --delay 0.5
        """
    )
    
    parser.add_argument('url', help='Website URL to crawl')
    parser.add_argument('--max-pages', type=int, default=100,
                       help='Maximum number of pages to crawl (default: 100)')
    parser.add_argument('--max-depth', type=int, default=3,
                       help='Maximum crawl depth (default: 3)')
    parser.add_argument('--delay', type=float, default=1.0,
                       help='Delay between requests in seconds (default: 1.0)')
    parser.add_argument('--output-dir', type=str, default=None,
                       help='Output directory for cached data (default: auto-generated)')
    
    args = parser.parse_args()
    
    # Generate output directory if not provided
    if args.output_dir is None:
        domain = urlparse(args.url).netloc.replace('www.', '')
        date_str = datetime.now().strftime('%Y.%m.%d')
        args.output_dir = f'.project/seo/{domain}/{date_str}/cache'
    
    # Create crawler and start
    crawler = WebsiteCrawler(
        base_url=args.url,
        output_dir=args.output_dir,
        max_pages=args.max_pages,
        max_depth=args.max_depth,
        delay=args.delay
    )
    
    try:
        crawler.crawl()
    except KeyboardInterrupt:
        print(f"\n\n{Colors.YELLOW}Crawl interrupted by user{Colors.END}")
        crawler.stats['end_time'] = datetime.now().isoformat()
        crawler._save_crawl_summary()
        crawler._print_summary()
        sys.exit(0)


if __name__ == '__main__':
    main()
