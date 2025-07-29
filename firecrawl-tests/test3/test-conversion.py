#!/usr/bin/env python3
"""
Test MDX to Markdown conversion on a single file
"""

import os
import re
from pathlib import Path

def clean_mdx_to_markdown(content):
    """Convert MDX content to clean Markdown"""
    
    # Remove import statements
    content = re.sub(r'^import.*?from.*?;?\n', '', content, flags=re.MULTILINE)
    
    # Remove export statements
    content = re.sub(r'^export\s+.*?(?=\n\n|\n(?=[A-Za-z#])|\Z)', '', content, flags=re.MULTILINE | re.DOTALL)
    
    # Remove JSX components
    component_replacements = {
        r'<Callout[^>]*>(.*?)</Callout>': r'> **Note**: \1',
        r'<YoutubeEmbed[^>]*/>': r'[YouTube Video]',
        r'<[A-Z][A-Za-z0-9]*[^>]*/>': '',
        r'\{\s*/\*.*?\*/\s*\}': '',
        r'\{[^}]*props[^}]*\}': '',
    }
    
    for pattern, replacement in component_replacements.items():
        content = re.sub(pattern, replacement, content, flags=re.DOTALL)
    
    # Clean up whitespace
    content = re.sub(r'\n\s*\n\s*\n', '\n\n', content)
    return content.strip()

# Test with a single file
test_file = Path("amplify-docs-complete/fragments/guides/hosting/nextjs.mdx")

if test_file.exists():
    print(f"Testing conversion of: {test_file}")
    
    with open(test_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    print("\n--- Original Content (first 500 chars) ---")
    print(content[:500])
    
    cleaned = clean_mdx_to_markdown(content)
    
    print("\n--- Converted Content (first 500 chars) ---")
    print(cleaned[:500])
    
    print(f"\nOriginal length: {len(content)}")
    print(f"Converted length: {len(cleaned)}")
    
    # Save test output
    with open("test-output.md", 'w', encoding='utf-8') as f:
        f.write(f"# Test Conversion\n\n{cleaned}")
    
    print("✅ Test conversion saved to test-output.md")
else:
    print(f"❌ Test file not found: {test_file}")
    print("Available files:")
    for f in Path("amplify-docs-complete").rglob("*.mdx"):
        print(f"  {f}")
        if len(list(Path("amplify-docs-complete").rglob("*.mdx"))) > 5:
            print("  ... (showing first 5)")
            break