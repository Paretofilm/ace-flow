#!/usr/bin/env python3
"""
Convert AWS Amplify MDX documentation to clean Markdown files
Removes JSX components, imports, and converts to standard Markdown
"""

import os
import re
import shutil
from pathlib import Path
import json

def clean_mdx_to_markdown(content):
    """Convert MDX content to clean Markdown"""
    
    # Remove import statements
    content = re.sub(r'^import.*?from.*?;?\n', '', content, flags=re.MULTILINE)
    
    # Remove export statements (meta, getStaticPaths, etc.)
    content = re.sub(r'^export\s+.*?(?=\n\n|\n(?=[A-Za-z#])|\Z)', '', content, flags=re.MULTILINE | re.DOTALL)
    
    # Remove JSX components and replace with markdown equivalents
    component_replacements = {
        # Common Amplify components
        r'<Callout[^>]*>(.*?)</Callout>': r'> **Note**: \1',
        r'<InlineFilter[^>]*>(.*?)</InlineFilter>': r'\1',
        r'<BlockSwitcher[^>]*>(.*?)</BlockSwitcher>': r'\1',
        r'<Block[^>]*>(.*?)</Block>': r'\1',
        r'<Fragments[^>]*/>': '',
        r'<Overview[^>]*/>': '',
        r'<YoutubeEmbed[^>]*/>': r'[YouTube Video]',
        
        # Code blocks and highlights
        r'<Highlight[^>]*>(.*?)</Highlight>': r'`\1`',
        
        # Links and references
        r'<InternalLinkButton[^>]*>(.*?)</InternalLinkButton>': r'[\1]',
        
        # Remove self-closing JSX components
        r'<[A-Z][A-Za-z0-9]*[^>]*/>': '',
        
        # Convert JSX comments to markdown comments
        r'\{\s*/\*.*?\*/\s*\}': '',
        
        # Remove JSX expressions in curly braces (keep simple ones)
        r'\{[^}]*props[^}]*\}': '',
        r'\{[^}]*childPageNodes[^}]*\}': '',
    }
    
    for pattern, replacement in component_replacements.items():
        content = re.sub(pattern, replacement, content, flags=re.DOTALL)
    
    # Clean up extra whitespace
    content = re.sub(r'\n\s*\n\s*\n', '\n\n', content)
    content = content.strip()
    
    return content

def extract_title_from_content(content):
    """Extract title from content - look for first heading or meta title"""
    
    # Look for first # heading
    heading_match = re.search(r'^#\s+(.+)$', content, re.MULTILINE)
    if heading_match:
        return heading_match.group(1).strip()
    
    # Look for ## heading if no # found
    heading_match = re.search(r'^##\s+(.+)$', content, re.MULTILINE)
    if heading_match:
        return heading_match.group(1).strip()
    
    # Look for title in meta export (before cleaning)
    meta_match = re.search(r'title:\s*[\'"]([^\'"]+)[\'"]', content)
    if meta_match:
        return meta_match.group(1).strip()
    
    return "Untitled"

def convert_file(input_path, output_path, relative_path):
    """Convert a single MDX file to Markdown"""
    
    try:
        with open(input_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Extract title before cleaning
        title = extract_title_from_content(content)
        
        # Convert to markdown
        markdown_content = clean_mdx_to_markdown(content)
        
        # Skip if content is mostly empty after cleaning
        if len(markdown_content.strip()) < 50:
            return None
        
        # Add front matter
        frontmatter = f"""---
title: {title}
source: {relative_path}
---

# {title}

{markdown_content}
"""
        
        # Ensure output directory exists
        os.makedirs(os.path.dirname(output_path), exist_ok=True)
        
        # Write markdown file
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(frontmatter)
        
        return {
            'title': title,
            'source': relative_path,
            'output': str(output_path),
            'size': len(markdown_content)
        }
        
    except Exception as e:
        print(f"Error converting {input_path}: {e}")
        return None

def main():
    """Main conversion function"""
    
    input_dir = Path("amplify-docs-complete")
    output_dir = Path("amplify-docs-markdown")
    
    print("🔄 Converting MDX files to Markdown")
    print("=" * 50)
    
    # Clean and create output directory
    if output_dir.exists():
        shutil.rmtree(output_dir)
    output_dir.mkdir()
    
    # Track conversion results
    converted_files = []
    skipped_files = []
    
    # Process all MDX files
    for mdx_file in input_dir.rglob("*.mdx"):
        # Create relative path for output
        relative_path = mdx_file.relative_to(input_dir)
        
        # Change extension to .md
        output_path = output_dir / relative_path.with_suffix('.md')
        
        print(f"Converting: {relative_path}")
        
        result = convert_file(mdx_file, output_path, str(relative_path))
        
        if result:
            converted_files.append(result)
        else:
            skipped_files.append(str(relative_path))
    
    # Create comprehensive index
    index_content = f"""# AWS Amplify Documentation - Markdown Version

Converted from MDX source files to clean Markdown format.

## Conversion Statistics
- **Total files processed**: {len(converted_files) + len(skipped_files)}
- **Successfully converted**: {len(converted_files)}
- **Skipped (insufficient content)**: {len(skipped_files)}

## File Structure

"""
    
    # Group files by directory
    by_directory = {}
    for file_info in converted_files:
        dir_path = str(Path(file_info['source']).parent)
        if dir_path not in by_directory:
            by_directory[dir_path] = []
        by_directory[dir_path].append(file_info)
    
    # Write directory structure
    for directory in sorted(by_directory.keys()):
        if directory != '.':
            index_content += f"\n### {directory}\n\n"
            for file_info in sorted(by_directory[directory], key=lambda x: x['title']):
                output_path = Path(file_info['output']).relative_to(output_dir)
                index_content += f"- [{file_info['title']}]({output_path})\n"
    
    # Add conversion notes
    index_content += f"""

## Conversion Notes

This markdown version has been automatically converted from the original MDX files with the following changes:
- Removed all JSX components and imports
- Converted Amplify-specific components to markdown equivalents
- Preserved code blocks and formatting
- Added frontmatter with title and source information
- Cleaned up whitespace and formatting

## Original Source
Source files from: https://github.com/aws-amplify/docs

## Usage
These files can be:
- Read directly as standard Markdown
- Processed by static site generators
- Imported into documentation tools
- Used for search and indexing
- Converted to other formats (HTML, PDF, etc.)
"""
    
    # Write main index
    with open(output_dir / "README.md", 'w', encoding='utf-8') as f:
        f.write(index_content)
    
    # Write JSON index for programmatic access
    with open(output_dir / "file-index.json", 'w', encoding='utf-8') as f:
        json.dump({
            'converted_files': converted_files,
            'skipped_files': skipped_files,
            'total_converted': len(converted_files),
            'total_skipped': len(skipped_files)
        }, f, indent=2)
    
    print("\n✅ Conversion Complete!")
    print(f"📁 Output directory: {output_dir}")
    print(f"📊 Converted: {len(converted_files)} files")
    print(f"⏭️  Skipped: {len(skipped_files)} files")
    print(f"📖 See {output_dir}/README.md for navigation")

if __name__ == "__main__":
    main()