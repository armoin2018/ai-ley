#!/usr/bin/env python3
"""
Per-Page SEO Analyzer
=====================
Analyzes cached website data from crawl_site.py and generates detailed
per-page SEO reports with specific recommendations for each URL.

Features:
- Title tag optimization analysis
- Meta description quality assessment
- Heading structure evaluation
- Content quality scoring
- Internal/external linking analysis
- Image optimization recommendations
- Schema markup validation
- Performance issue detection
- Per-page action items with priorities

Usage:
    python3 analyze_pages.py ./cache/example
    python3 analyze_pages.py ./cache/example --format html
    python3 analyze_pages.py ./cache/example --output-file page-analysis.csv

Requirements:
    No external dependencies (uses Python stdlib only)
"""

import argparse
import csv
import json
import sys
from collections import Counter
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Tuple


# Color codes for terminal output
class Colors:
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    BLUE = '\033[94m'
    CYAN = '\033[96m'
    BOLD = '\033[1m'
    END = '\033[0m'


class PageAnalyzer:
    """
    Analyzes individual page SEO metrics and generates recommendations
    """
    
    # SEO best practice thresholds
    TITLE_MIN = 30
    TITLE_MAX = 60
    META_DESC_MIN = 120
    META_DESC_MAX = 158
    MIN_WORD_COUNT = 300
    IDEAL_WORD_COUNT = 1000
    MAX_H1_COUNT = 1
    
    def __init__(self, cache_dir: str):
        self.cache_dir = Path(cache_dir)
        self.pages_dir = self.cache_dir / 'pages'
        self.metadata_dir = self.cache_dir / 'metadata'
        
        if not self.pages_dir.exists():
            print(f"{Colors.RED}Error: Cache directory not found: {self.cache_dir}{Colors.END}")
            sys.exit(1)
        
        self.page_files = list(self.pages_dir.glob('*.json'))
        self.analyzed_pages = []
        
    def load_page_data(self, page_file: Path) -> Dict:
        """Load page data from JSON file"""
        with open(page_file, 'r', encoding='utf-8') as f:
            return json.load(f)
    
    def load_metadata(self, url_id: str) -> Dict:
        """Load page metadata"""
        metadata_file = self.metadata_dir / f'{url_id}.json'
        if metadata_file.exists():
            with open(metadata_file, 'r', encoding='utf-8') as f:
                return json.load(f)
        return {}
    
    def analyze_title(self, page_data: Dict) -> Tuple[int, List[str]]:
        """Analyze title tag and return score + issues"""
        title = page_data.get('title', '')
        title_length = page_data.get('title_length', 0)
        issues = []
        score = 100
        
        if not title:
            issues.append("CRITICAL: Missing title tag")
            return 0, issues
        
        if title_length < self.TITLE_MIN:
            issues.append(f"Title too short ({title_length} chars, target: {self.TITLE_MIN}-{self.TITLE_MAX})")
            score -= 30
        elif title_length > self.TITLE_MAX:
            issues.append(f"Title too long ({title_length} chars, target: {self.TITLE_MIN}-{self.TITLE_MAX}) - may be truncated in SERPs")
            score -= 20
        
        # Check for duplicate words (potential keyword stuffing)
        words = title.lower().split()
        word_counts = Counter(words)
        duplicates = [word for word, count in word_counts.items() if count > 2 and len(word) > 3]
        if duplicates:
            issues.append(f"Potential keyword stuffing: '{', '.join(duplicates)}' repeated")
            score -= 15
        
        # Check if title starts with brand name (usually not optimal)
        if title.split()[0].isupper() and len(title.split()[0]) > 2:
            issues.append("Consider moving brand name to end of title for better keyword positioning")
            score -= 5
        
        return max(score, 0), issues
    
    def analyze_meta_description(self, page_data: Dict) -> Tuple[int, List[str]]:
        """Analyze meta description and return score + issues"""
        meta_desc = page_data.get('meta_description', '')
        meta_length = page_data.get('meta_description_length', 0)
        issues = []
        score = 100
        
        if not meta_desc:
            issues.append("CRITICAL: Missing meta description")
            return 0, issues
        
        if meta_length < self.META_DESC_MIN:
            issues.append(f"Meta description too short ({meta_length} chars, target: {self.META_DESC_MIN}-{self.META_DESC_MAX})")
            score -= 30
        elif meta_length > self.META_DESC_MAX:
            issues.append(f"Meta description too long ({meta_length} chars, target: {self.META_DESC_MIN}-{self.META_DESC_MAX}) - will be truncated")
            score -= 20
        
        # Check for call-to-action
        cta_words = ['buy', 'shop', 'learn', 'discover', 'find', 'get', 'try', 'start', 'join', 'subscribe', 'download']
        has_cta = any(word in meta_desc.lower() for word in cta_words)
        if not has_cta:
            issues.append("No call-to-action detected - consider adding action verbs")
            score -= 10
        
        return max(score, 0), issues
    
    def analyze_headings(self, page_data: Dict) -> Tuple[int, List[str]]:
        """Analyze heading structure and return score + issues"""
        headings = page_data.get('headings', {})
        issues = []
        score = 100
        
        h1_count = len(headings.get('h1', []))
        h2_count = len(headings.get('h2', []))
        
        # Check H1
        if h1_count == 0:
            issues.append("CRITICAL: No H1 heading found")
            score -= 40
        elif h1_count > self.MAX_H1_COUNT:
            issues.append(f"Multiple H1 headings ({h1_count}) - should have only one")
            score -= 20
        
        # Check if H1 exists but is empty
        if h1_count > 0:
            h1_text = headings['h1'][0]
            if not h1_text or len(h1_text) < 10:
                issues.append("H1 heading is too short or empty")
                score -= 15
        
        # Check H2 presence
        if h2_count == 0:
            issues.append("No H2 headings - consider adding subheadings for better structure")
            score -= 15
        
        # Check heading hierarchy
        if h1_count > 0 and h2_count > 0:
            # Basic hierarchy check
            all_headings = []
            for level in ['h1', 'h2', 'h3', 'h4', 'h5', 'h6']:
                for heading in headings.get(level, []):
                    all_headings.append((level, heading))
            
            # Check if skipping levels (e.g., H1 -> H3 without H2)
            prev_level = 0
            for level, text in all_headings:
                curr_level = int(level[1])
                if prev_level > 0 and curr_level > prev_level + 1:
                    issues.append(f"Heading hierarchy issue: skipped from H{prev_level} to H{curr_level}")
                    score -= 5
                    break
                prev_level = curr_level
        
        return max(score, 0), issues
    
    def analyze_content(self, page_data: Dict) -> Tuple[int, List[str]]:
        """Analyze content quality and return score + issues"""
        word_count = page_data.get('word_count', 0)
        text_content = page_data.get('text_content', '')
        issues = []
        score = 100
        
        if word_count < self.MIN_WORD_COUNT:
            issues.append(f"CRITICAL: Thin content ({word_count} words, minimum: {self.MIN_WORD_COUNT})")
            score -= 50
        elif word_count < self.IDEAL_WORD_COUNT:
            issues.append(f"Content below ideal length ({word_count} words, target: {self.IDEAL_WORD_COUNT}+)")
            score -= 20
        
        # Check for very long paragraphs (poor readability)
        paragraphs = text_content.split('\n\n') if text_content else []
        long_paragraphs = [p for p in paragraphs if len(p.split()) > 100]
        if len(long_paragraphs) > 2:
            issues.append("Multiple long paragraphs detected - consider breaking up for readability")
            score -= 10
        
        # Check for duplicate content phrases (basic check)
        sentences = text_content.split('. ') if text_content else []
        if len(sentences) > 5:
            sentence_counts = Counter(sentences)
            duplicates = [s[:50] for s, count in sentence_counts.items() if count > 1 and len(s) > 20]
            if duplicates:
                issues.append(f"Potential duplicate content detected: {len(duplicates)} repeated sentences")
                score -= 15
        
        return max(score, 0), issues
    
    def analyze_links(self, page_data: Dict) -> Tuple[int, List[str]]:
        """Analyze internal and external linking"""
        internal_count = page_data.get('internal_link_count', 0)
        external_count = page_data.get('external_link_count', 0)
        internal_links = page_data.get('internal_links', [])
        issues = []
        score = 100
        
        # Check internal linking
        if internal_count == 0:
            issues.append("CRITICAL: No internal links - poor for SEO and user navigation")
            score -= 40
        elif internal_count < 3:
            issues.append(f"Few internal links ({internal_count}) - add more contextual links")
            score -= 20
        elif internal_count > 100:
            issues.append(f"Excessive internal links ({internal_count}) - may dilute link equity")
            score -= 10
        
        # Check for links without anchor text
        empty_anchor_links = [link for link in internal_links if not link.get('text', '').strip()]
        if empty_anchor_links:
            issues.append(f"{len(empty_anchor_links)} internal links missing anchor text")
            score -= 15
        
        # Check external links
        if external_count == 0:
            issues.append("No external links - consider linking to authoritative sources")
            score -= 5
        elif external_count > 50:
            issues.append(f"Many external links ({external_count}) - verify all are valuable")
            score -= 5
        
        return max(score, 0), issues
    
    def analyze_images(self, page_data: Dict) -> Tuple[int, List[str]]:
        """Analyze image optimization"""
        image_count = page_data.get('image_count', 0)
        images_without_alt = page_data.get('images_without_alt', 0)
        images = page_data.get('images', [])
        issues = []
        score = 100
        
        if image_count == 0:
            issues.append("No images on page - visual content improves engagement")
            score -= 10
        
        if images_without_alt > 0:
            pct_missing = (images_without_alt / image_count * 100) if image_count > 0 else 0
            if pct_missing > 50:
                issues.append(f"CRITICAL: {images_without_alt}/{image_count} images missing alt text ({pct_missing:.0f}%)")
                score -= 40
            else:
                issues.append(f"{images_without_alt}/{image_count} images missing alt text")
                score -= 20
        
        # Check for oversized images (basic heuristic)
        large_images = [img for img in images if 'scaled' in img.get('src', '').lower() or 
                       any(size in img.get('src', '').lower() for size in ['2560', '3000', '4000'])]
        if large_images:
            issues.append(f"{len(large_images)} potentially oversized images detected - compress and optimize")
            score -= 15
        
        return max(score, 0), issues
    
    def analyze_schema(self, page_data: Dict) -> Tuple[int, List[str]]:
        """Analyze schema markup presence"""
        schema_data = page_data.get('schema_markup', [])
        og_data = page_data.get('open_graph', {})
        twitter_data = page_data.get('twitter_card', {})
        issues = []
        score = 100
        
        if not schema_data:
            issues.append("No schema.org structured data found - missing rich result opportunities")
            score -= 30
        
        if not og_data:
            issues.append("No Open Graph tags - missing social media optimization")
            score -= 20
        
        if not twitter_data:
            issues.append("No Twitter Card tags - missing Twitter optimization")
            score -= 10
        
        return max(score, 0), issues
    
    def calculate_overall_score(self, scores: Dict[str, int]) -> int:
        """Calculate weighted overall score"""
        weights = {
            'title': 0.20,
            'meta_description': 0.15,
            'headings': 0.15,
            'content': 0.25,
            'links': 0.15,
            'images': 0.05,
            'schema': 0.05
        }
        
        overall = sum(scores[key] * weights[key] for key in weights)
        return int(overall)
    
    def get_priority_level(self, score: int) -> str:
        """Determine priority based on score"""
        if score < 50:
            return "CRITICAL"
        elif score < 70:
            return "HIGH"
        elif score < 85:
            return "MEDIUM"
        else:
            return "LOW"
    
    def analyze_page(self, page_file: Path) -> Dict:
        """Perform complete analysis on a single page"""
        page_data = self.load_page_data(page_file)
        url_id = page_file.stem
        metadata = self.load_metadata(url_id)
        
        # Run all analyses
        title_score, title_issues = self.analyze_title(page_data)
        meta_score, meta_issues = self.analyze_meta_description(page_data)
        heading_score, heading_issues = self.analyze_headings(page_data)
        content_score, content_issues = self.analyze_content(page_data)
        link_score, link_issues = self.analyze_links(page_data)
        image_score, image_issues = self.analyze_images(page_data)
        schema_score, schema_issues = self.analyze_schema(page_data)
        
        scores = {
            'title': title_score,
            'meta_description': meta_score,
            'headings': heading_score,
            'content': content_score,
            'links': link_score,
            'images': image_score,
            'schema': schema_score
        }
        
        overall_score = self.calculate_overall_score(scores)
        priority = self.get_priority_level(overall_score)
        
        # Combine all issues
        all_issues = {
            'title': title_issues,
            'meta_description': meta_issues,
            'headings': heading_issues,
            'content': content_issues,
            'links': link_issues,
            'images': image_issues,
            'schema': schema_issues
        }
        
        return {
            'url': page_data.get('url', ''),
            'url_id': url_id,
            'overall_score': overall_score,
            'priority': priority,
            'scores': scores,
            'issues': all_issues,
            'metadata': {
                'title': page_data.get('title', ''),
                'title_length': page_data.get('title_length', 0),
                'meta_description_length': page_data.get('meta_description_length', 0),
                'word_count': page_data.get('word_count', 0),
                'internal_links': page_data.get('internal_link_count', 0),
                'external_links': page_data.get('external_link_count', 0),
                'images': page_data.get('image_count', 0),
                'images_without_alt': page_data.get('images_without_alt', 0),
                'h1_count': len(page_data.get('headings', {}).get('h1', [])),
                'response_time': metadata.get('response_time', 0)
            }
        }
    
    def analyze_all(self):
        """Analyze all cached pages"""
        print(f"\n{Colors.BOLD}{Colors.CYAN}{'='*70}{Colors.END}")
        print(f"{Colors.BOLD}{Colors.GREEN}Per-Page SEO Analysis{Colors.END}")
        print(f"{Colors.BOLD}{Colors.CYAN}{'='*70}{Colors.END}\n")
        
        print(f"{Colors.YELLOW}Analyzing:{Colors.END}")
        print(f"  • Cache Directory: {Colors.BOLD}{self.cache_dir}{Colors.END}")
        print(f"  • Total Pages: {Colors.BOLD}{len(self.page_files)}{Colors.END}\n")
        
        for i, page_file in enumerate(self.page_files, 1):
            analysis = self.analyze_page(page_file)
            self.analyzed_pages.append(analysis)
            
            # Print progress
            score = analysis['overall_score']
            priority = analysis['priority']
            url = analysis['url']
            
            if priority == "CRITICAL":
                color = Colors.RED
            elif priority == "HIGH":
                color = Colors.YELLOW
            elif priority == "MEDIUM":
                color = Colors.BLUE
            else:
                color = Colors.GREEN
            
            print(f"{color}[{i}/{len(self.page_files)}]{Colors.END} "
                  f"Score: {color}{score}/100{Colors.END} "
                  f"Priority: {color}{priority}{Colors.END} - {url}")
        
        self._print_summary()
    
    def _print_summary(self):
        """Print analysis summary"""
        print(f"\n{Colors.BOLD}{Colors.CYAN}{'='*70}{Colors.END}")
        print(f"{Colors.BOLD}{Colors.GREEN}Analysis Complete!{Colors.END}")
        print(f"{Colors.BOLD}{Colors.CYAN}{'='*70}{Colors.END}\n")
        
        # Calculate statistics
        scores = [p['overall_score'] for p in self.analyzed_pages]
        avg_score = sum(scores) / len(scores) if scores else 0
        
        priority_counts = Counter([p['priority'] for p in self.analyzed_pages])
        
        print(f"{Colors.YELLOW}Overall Statistics:{Colors.END}")
        print(f"  • Average Score: {Colors.BOLD}{avg_score:.1f}/100{Colors.END}")
        print(f"  • Highest Score: {Colors.GREEN}{max(scores) if scores else 0}{Colors.END}")
        print(f"  • Lowest Score: {Colors.RED}{min(scores) if scores else 0}{Colors.END}")
        
        print(f"\n{Colors.YELLOW}Priority Distribution:{Colors.END}")
        print(f"  • {Colors.RED}CRITICAL:{Colors.END} {priority_counts.get('CRITICAL', 0)} pages")
        print(f"  • {Colors.YELLOW}HIGH:{Colors.END} {priority_counts.get('HIGH', 0)} pages")
        print(f"  • {Colors.BLUE}MEDIUM:{Colors.END} {priority_counts.get('MEDIUM', 0)} pages")
        print(f"  • {Colors.GREEN}LOW:{Colors.END} {priority_counts.get('LOW', 0)} pages")
        
        # Top issues
        all_issues = []
        for page in self.analyzed_pages:
            for category, issues in page['issues'].items():
                all_issues.extend(issues)
        
        issue_counts = Counter(all_issues)
        top_issues = issue_counts.most_common(5)
        
        if top_issues:
            print(f"\n{Colors.YELLOW}Top 5 Common Issues:{Colors.END}")
            for issue, count in top_issues:
                print(f"  • ({count} pages) {issue[:60]}...")
    
    def export_csv(self, output_file: str):
        """Export analysis results to CSV"""
        with open(output_file, 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            
            # Header
            writer.writerow([
                'URL',
                'Overall Score',
                'Priority',
                'Title Score',
                'Meta Desc Score',
                'Headings Score',
                'Content Score',
                'Links Score',
                'Images Score',
                'Schema Score',
                'Title Length',
                'Meta Desc Length',
                'Word Count',
                'Internal Links',
                'External Links',
                'Images',
                'Missing Alt Tags',
                'H1 Count',
                'Response Time (s)',
                'All Issues'
            ])
            
            # Data rows
            for page in self.analyzed_pages:
                # Collect all issues
                all_issues = []
                for category, issues in page['issues'].items():
                    for issue in issues:
                        all_issues.append(f"[{category.upper()}] {issue}")
                
                writer.writerow([
                    page['url'],
                    page['overall_score'],
                    page['priority'],
                    page['scores']['title'],
                    page['scores']['meta_description'],
                    page['scores']['headings'],
                    page['scores']['content'],
                    page['scores']['links'],
                    page['scores']['images'],
                    page['scores']['schema'],
                    page['metadata']['title_length'],
                    page['metadata']['meta_description_length'],
                    page['metadata']['word_count'],
                    page['metadata']['internal_links'],
                    page['metadata']['external_links'],
                    page['metadata']['images'],
                    page['metadata']['images_without_alt'],
                    page['metadata']['h1_count'],
                    f"{page['metadata']['response_time']:.2f}",
                    ' | '.join(all_issues)
                ])
        
        print(f"\n{Colors.GREEN}✓{Colors.END} Exported to: {Colors.BOLD}{output_file}{Colors.END}")
    
    def export_json(self, output_file: str):
        """Export analysis results to JSON"""
        output = {
            'analysis_date': datetime.now().isoformat(),
            'cache_directory': str(self.cache_dir),
            'total_pages': len(self.analyzed_pages),
            'pages': self.analyzed_pages
        }
        
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(output, f, indent=2, ensure_ascii=False)
        
        print(f"\n{Colors.GREEN}✓{Colors.END} Exported to: {Colors.BOLD}{output_file}{Colors.END}")


def main():
    parser = argparse.ArgumentParser(
        description='Analyze cached website data for per-page SEO insights',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python3 analyze_pages.py ./cache/example
  python3 analyze_pages.py ./cache/example --format csv --output page-analysis.csv
  python3 analyze_pages.py ./cache/example --format json --output page-analysis.json
        """
    )
    
    parser.add_argument('cache_dir', help='Directory containing cached page data')
    parser.add_argument('--format', choices=['csv', 'json', 'both'], default='csv',
                       help='Output format (default: csv)')
    parser.add_argument('--output', type=str, default=None,
                       help='Output file path (default: auto-generated)')
    
    args = parser.parse_args()
    
    # Create analyzer
    analyzer = PageAnalyzer(args.cache_dir)
    
    # Run analysis
    analyzer.analyze_all()
    
    # Determine output file
    if args.output:
        output_base = args.output.rsplit('.', 1)[0]
    else:
        output_base = str(Path(args.cache_dir).parent / 'page-analysis')
    
    # Export results
    if args.format in ['csv', 'both']:
        analyzer.export_csv(f"{output_base}.csv")
    
    if args.format in ['json', 'both']:
        analyzer.export_json(f"{output_base}.json")
    
    print(f"\n{Colors.YELLOW}Next Steps:{Colors.END}")
    print(f"  • Review high-priority pages first")
    print(f"  • Address CRITICAL issues immediately")
    print(f"  • Use CSV for project management and tracking")
    print(f"  • Use JSON for automated processing\n")


if __name__ == '__main__':
    main()
