#!/usr/bin/env python3
"""
Efficient batch conversion of MDX to Markdown with progress tracking
"""

import os
import re
import shutil
from pathlib import Path
import json
import time

def clean_mdx_to_markdown(content):
    """Convert MDX content to clean Markdown"""
    
    # Remove import statements
    content = re.sub(r'^import.*?from.*?;?\n', '', content, flags=re.MULTILINE)
    
    # Remove export statements
    content = re.sub(r'^export\s+.*?(?=\n\n|\n(?=[A-Za-z#])|\Z)', '', content, flags=re.MULTILINE | re.DOTALL)
    
    # Simple JSX component removal
    component_replacements = {
        r'<Callout[^>]*>(.*?)</Callout>': r'> **Note**: \1',
        r'<YoutubeEmbed[^>]*/>': r'[YouTube Video]',
        r'<[A-Z][A-Za-z0-9]*[^>]*\s*/?>': '',  # Self-closing components
        r'<[A-Z][A-Za-z0-9]*[^>]*>.*?</[A-Z][A-Za-z0-9]*>': '',  # Component blocks
        r'\{\s*/\*.*?\*/\s*\}': '',  # JSX comments
        r'\{[^}]*\}': '',  # JSX expressions
    }
    
    for pattern, replacement in component_replacements.items():
        content = re.sub(pattern, replacement, content, flags=re.DOTALL)
    
    # Clean up whitespace
    content = re.sub(r'\n\s*\n\s*\n+', '\n\n', content)
    return content.strip()

def extract_title(content):
    """Extract title from content"""
    # Look for first heading
    heading_match = re.search(r'^##+\s+(.+)$', content, re.MULTILINE)
    if heading_match:
        return heading_match.group(1).strip()
    
    # Look for title in original meta
    meta_match = re.search(r'title:\s*[\'"]([^\'"]+)[\'"]', content)
    if meta_match:
        return meta_match.group(1).strip()
    
    return "Documentation"

def main():
    """Convert MDX files to Markdown with progress tracking"""
    
    input_dir = Path("amplify-docs-complete")
    output_dir = Path("amplify-docs-markdown")
    
    print("🔄 Converting MDX to Markdown (Batch Processing)")
    print("=" * 50)
    
    # Clean output directory
    if output_dir.exists():
        shutil.rmtree(output_dir)
    output_dir.mkdir()
    
    # Get all MDX files
    mdx_files = list(input_dir.rglob("*.mdx"))
    total_files = len(mdx_files)
    
    print(f"📁 Found {total_files} MDX files to convert")
    
    converted = []
    skipped = []
    
    start_time = time.time()
    
    for i, mdx_file in enumerate(mdx_files, 1):
        # Progress indicator
        if i % 50 == 0 or i == total_files:
            elapsed = time.time() - start_time
            rate = i / elapsed if elapsed > 0 else 0
            eta = (total_files - i) / rate if rate > 0 else 0
            print(f"Progress: {i}/{total_files} ({i/total_files*100:.1f}%) | Rate: {rate:.1f} files/sec | ETA: {eta:.1f}s")
        
        try:
            # Read original file
            with open(mdx_file, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Convert to markdown
            markdown_content = clean_mdx_to_markdown(content)
            
            # Skip if too short after cleaning
            if len(markdown_content.strip()) < 30:
                skipped.append(str(mdx_file.relative_to(input_dir)))
                continue
            
            # Extract title
            title = extract_title(content)
            
            # Prepare output path
            relative_path = mdx_file.relative_to(input_dir)
            output_path = output_dir / relative_path.with_suffix('.md')
            
            # Create directory if needed
            output_path.parent.mkdir(parents=True, exist_ok=True)
            
            # Create markdown with frontmatter
            final_content = f"""---
title: {title}
source: {relative_path}
---

# {title}

{markdown_content}
"""
            
            # Write file
            with open(output_path, 'w', encoding='utf-8') as f:
                f.write(final_content)
            
            converted.append({
                'title': title,
                'source': str(relative_path),
                'output': str(output_path.relative_to(output_dir))
            })
            
        except Exception as e:
            print(f"❌ Error processing {mdx_file}: {e}")
            skipped.append(str(mdx_file.relative_to(input_dir)))
    
    # Create README
    readme_content = f"""# AWS Amplify Documentation - Markdown Version

Converted from {total_files} MDX source files to clean Markdown.

## Statistics
- ✅ **Converted**: {len(converted)} files
- ⏭️ **Skipped**: {len(skipped)} files  
- 📊 **Success Rate**: {len(converted)/total_files*100:.1f}%

## Directory Structure
The files maintain the same directory structure as the original documentation.

### Key Sections
- `pages/` - Page structure and navigation
- `fragments/` - Content fragments and guides

## Usage
These are standard Markdown files that can be:
- Read directly
- Imported into documentation tools
- Converted to other formats
- Indexed for search

## Original Source
https://github.com/aws-amplify/docs
"""
    
    with open(output_dir / "README.md", 'w') as f:
        f.write(readme_content)
    
    # Create file index
    with open(output_dir / "index.json", 'w') as f:
        json.dump({
            'converted': converted,
            'skipped': skipped,
            'total': total_files,
            'success_rate': len(converted)/total_files
        }, f, indent=2)
    
    elapsed = time.time() - start_time
    print(f"\n✅ Conversion Complete!")
    print(f"⏱️  Total time: {elapsed:.1f} seconds")
    print(f"📊 Converted: {len(converted)}/{total_files} files")
    print(f"📁 Output: {output_dir}")

if __name__ == "__main__":
    main()