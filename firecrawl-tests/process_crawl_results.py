#!/usr/bin/env python3
"""
Process and save Firecrawl crawl results for AWS Amplify documentation
"""
import json
import os
import re
from datetime import datetime
from urllib.parse import urlparse

CRAWL_JOB_ID = "87fdbe80-885e-4ed6-a0e7-bf760f0447dc"
BASE_OUTPUT_DIR = "firecrawl-tests/amplify-docs"

def create_directory_structure(url):
    """Create directory structure based on URL path"""
    parsed = urlparse(url)
    path = parsed.path.strip('/')
    
    if path:
        # Create nested directories based on URL structure
        path_parts = path.split('/')
        # Remove 'nextjs' from the beginning if present
        if path_parts and path_parts[0] == 'nextjs':
            path_parts = path_parts[1:]
        
        if path_parts:
            dir_path = os.path.join(BASE_OUTPUT_DIR, *path_parts[:-1])
            os.makedirs(dir_path, exist_ok=True)
            return dir_path, path_parts[-1]
    
    return BASE_OUTPUT_DIR, 'index'

def sanitize_filename(name):
    """Sanitize filename for safe file system use"""
    # Replace special characters with hyphens
    name = re.sub(r'[^\w\-_]', '-', name)
    # Remove multiple hyphens
    name = re.sub(r'-+', '-', name)
    # Remove leading/trailing hyphens
    name = name.strip('-')
    return name or 'unnamed'

def save_page_content(page_data, index):
    """Save individual page content to markdown file in organized structure"""
    url = page_data.get('metadata', {}).get('url', page_data.get('url', ''))
    content = page_data.get('markdown', '')
    title = page_data.get('metadata', {}).get('title', '')
    
    if not url:
        print(f"Warning: No URL found for page at index {index}")
        return None
    
    # Create directory structure
    dir_path, filename_base = create_directory_structure(url)
    
    # Sanitize filename
    filename = sanitize_filename(filename_base)
    if not filename.endswith('.md'):
        filename += '.md'
    
    filepath = os.path.join(dir_path, filename)
    
    # Check for duplicate filenames and add index if needed
    if os.path.exists(filepath):
        base_name = filename[:-3]  # Remove .md
        counter = 1
        while os.path.exists(filepath):
            filename = f"{base_name}-{counter}.md"
            filepath = os.path.join(dir_path, filename)
            counter += 1
    
    # Create metadata header
    metadata = f"""---
title: {title}
url: {url}
scraped_at: {datetime.now().isoformat()}
crawl_job_id: {CRAWL_JOB_ID}
index: {index}
---

# {title}

"""
    
    # Write content
    try:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(metadata + content)
        print(f"✓ Saved: {filepath}")
        return filepath
    except Exception as e:
        print(f"✗ Error saving {filepath}: {e}")
        return None

def create_index_file(pages_info):
    """Create an index file with links to all scraped pages"""
    index_path = os.path.join(BASE_OUTPUT_DIR, "README.md")
    
    content = f"""# AWS Amplify Next.js Documentation

Scraped on: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
Total pages: {len(pages_info)}
Crawl Job ID: {CRAWL_JOB_ID}

## Table of Contents

"""
    
    # Group pages by directory
    pages_by_dir = {}
    for info in pages_info:
        if info['saved_path']:
            rel_path = os.path.relpath(info['saved_path'], BASE_OUTPUT_DIR)
            dir_name = os.path.dirname(rel_path)
            if dir_name not in pages_by_dir:
                pages_by_dir[dir_name] = []
            pages_by_dir[dir_name].append({
                'title': info['title'],
                'path': rel_path,
                'url': info['url']
            })
    
    # Write grouped content
    for dir_name in sorted(pages_by_dir.keys()):
        if dir_name:
            content += f"\n### {dir_name.replace('/', ' > ')}\n\n"
        else:
            content += "\n### Root\n\n"
        
        for page in sorted(pages_by_dir[dir_name], key=lambda x: x['title']):
            content += f"- [{page['title']}]({page['path']}) - [Original]({page['url']})\n"
    
    with open(index_path, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"\n✓ Created index file: {index_path}")

def process_crawl_results(crawl_data):
    """Process crawl results and save to organized structure"""
    os.makedirs(BASE_OUTPUT_DIR, exist_ok=True)
    
    # Extract pages data
    pages = crawl_data.get('data', [])
    if not pages:
        print("No pages found in crawl results")
        return
    
    print(f"Processing {len(pages)} pages...")
    print("-" * 50)
    
    pages_info = []
    
    for index, page in enumerate(pages):
        saved_path = save_page_content(page, index)
        
        pages_info.append({
            'url': page.get('metadata', {}).get('url', page.get('url', '')),
            'title': page.get('metadata', {}).get('title', 'Untitled'),
            'saved_path': saved_path,
            'index': index
        })
    
    # Create index file
    create_index_file(pages_info)
    
    # Create summary
    summary = {
        "crawl_job_id": CRAWL_JOB_ID,
        "processed_at": datetime.now().isoformat(),
        "total_pages": len(pages),
        "successfully_saved": len([p for p in pages_info if p['saved_path']]),
        "output_directory": BASE_OUTPUT_DIR,
        "pages": pages_info
    }
    
    summary_path = os.path.join(BASE_OUTPUT_DIR, "crawl_summary.json")
    with open(summary_path, 'w', encoding='utf-8') as f:
        json.dump(summary, f, indent=2)
    
    print(f"\n✓ Created summary file: {summary_path}")
    print(f"✓ Successfully processed {summary['successfully_saved']} out of {summary['total_pages']} pages")

# Note: This would be called with actual crawl data from the MCP tool
if __name__ == "__main__":
    print("This script should be called with crawl data from the MCP tool")
    print(f"Crawl Job ID: {CRAWL_JOB_ID}")