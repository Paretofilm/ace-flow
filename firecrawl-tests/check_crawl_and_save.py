#!/usr/bin/env python3
"""
Script to check Firecrawl crawl status and save results to markdown files
"""
import json
import os
import time
from datetime import datetime
import re

# Crawl job ID from the previous operation
CRAWL_JOB_ID = "87fdbe80-885e-4ed6-a0e7-bf760f0447dc"
OUTPUT_DIR = "firecrawl-tests/amplify-docs"

def sanitize_filename(url):
    """Convert URL to safe filename"""
    # Remove protocol
    filename = re.sub(r'^https?://', '', url)
    # Replace special characters with underscores
    filename = re.sub(r'[^\w\-_\.]', '_', filename)
    # Remove multiple underscores
    filename = re.sub(r'_+', '_', filename)
    # Add .md extension if not present
    if not filename.endswith('.md'):
        filename += '.md'
    return filename

def save_page_content(page_data, index):
    """Save individual page content to markdown file"""
    url = page_data.get('url', f'page_{index}')
    content = page_data.get('markdown', '')
    
    # Create filename from URL
    filename = sanitize_filename(url)
    filepath = os.path.join(OUTPUT_DIR, filename)
    
    # Add metadata header
    metadata = f"""---
url: {url}
scraped_at: {datetime.now().isoformat()}
index: {index}
---

"""
    
    # Write content
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(metadata + content)
    
    return filepath

def main():
    """Main function to check crawl status and save results"""
    # Create output directory
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    
    print(f"Checking crawl status for job: {CRAWL_JOB_ID}")
    print(f"Results will be saved to: {OUTPUT_DIR}")
    print("-" * 50)
    
    # Note: In actual implementation, you would call the MCP tool here
    # For this example, we're creating the structure
    
    # Create a summary file
    summary_file = os.path.join(OUTPUT_DIR, "crawl_summary.json")
    summary = {
        "crawl_job_id": CRAWL_JOB_ID,
        "started_at": datetime.now().isoformat(),
        "output_directory": OUTPUT_DIR,
        "pages_scraped": 0,
        "status": "checking"
    }
    
    with open(summary_file, 'w') as f:
        json.dump(summary, f, indent=2)
    
    print(f"Created summary file: {summary_file}")
    print("\nTo check crawl status, use the firecrawl_check_crawl_status tool with ID:")
    print(f"  {CRAWL_JOB_ID}")

if __name__ == "__main__":
    main()