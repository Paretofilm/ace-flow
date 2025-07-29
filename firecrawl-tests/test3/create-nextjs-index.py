#!/usr/bin/env python3
"""
Create a focused index of Next.js specific documentation
"""

import json
from pathlib import Path
import re

def main():
    # Load the conversion index
    with open("amplify-docs-markdown/index.json", 'r') as f:
        data = json.load(f)
    
    converted_files = data['converted']
    
    # Find Next.js specific files
    nextjs_files = []
    nextjs_keywords = ['nextjs', 'next-js', 'next.js', 'app-router', 'pages-router']
    
    for file_info in converted_files:
        source = file_info['source'].lower()
        title = file_info['title'].lower()
        
        # Check if file is Next.js related
        if any(keyword in source or keyword in title for keyword in nextjs_keywords):
            nextjs_files.append(file_info)
    
    # Create Next.js focused README
    nextjs_readme = f"""# Next.js Specific AWS Amplify Documentation

This is a curated collection of **{len(nextjs_files)} Next.js-specific documentation files** from the complete AWS Amplify documentation.

## 🚀 Quick Start Guides

### App Router (Recommended)
"""
    
    # Categorize files
    categories = {
        'quickstart': [],
        'hosting': [],
        'app-router': [],
        'pages-router': [],
        'ssr': [],
        'other': []
    }
    
    for file_info in nextjs_files:
        source = file_info['source'].lower()
        title = file_info['title'].lower()
        
        if 'quickstart' in source or 'quickstart' in title:
            categories['quickstart'].append(file_info)
        elif 'app-router' in source or 'app router' in title:
            categories['app-router'].append(file_info)
        elif 'pages-router' in source or 'pages router' in title:
            categories['pages-router'].append(file_info)
        elif 'hosting' in source or 'hosting' in title:
            categories['hosting'].append(file_info)
        elif 'ssr' in source or 'server-side' in title:
            categories['ssr'].append(file_info)
        else:
            categories['other'].append(file_info)
    
    # Build the index
    for category, files in categories.items():
        if files:
            nextjs_readme += f"\n### {category.replace('-', ' ').title()}\n\n"
            for file_info in files:
                nextjs_readme += f"- [{file_info['title']}]({file_info['output']})\n"
    
    nextjs_readme += f"""

## 📊 Statistics
- **Total Next.js files**: {len(nextjs_files)}
- **Source files**: MDX from https://github.com/aws-amplify/docs
- **Conversion**: Automatic MDX → Markdown

## 📖 File Structure
```
amplify-docs-markdown/
├── fragments/
│   ├── gen2/quickstart/create-nextjs-*
│   ├── guides/hosting/nextjs.md
│   └── lib/ssr/nextjs/
└── pages/
    └── [platform files for Next.js]
```

## 🎯 Key Topics Covered
- Setting up new Next.js projects with Amplify
- App Router vs Pages Router implementations
- Server-side rendering (SSR) configuration
- Static site generation (SSG) deployment
- Hosting and deployment options
- Authentication integration
- API and database connections

## 💡 Usage Tips
1. Start with quickstart guides for new projects
2. Choose App Router for new applications (recommended)
3. Use Pages Router guides for existing applications
4. Check hosting guides for deployment options

## 🔗 Related Documentation
For complete documentation, see the main `README.md` in the parent directory.
"""
    
    # Write Next.js README
    with open("amplify-docs-markdown/NEXTJS-README.md", 'w') as f:
        f.write(nextjs_readme)
    
    # Create a separate directory with just Next.js files
    nextjs_dir = Path("nextjs-specific-docs")
    nextjs_dir.mkdir(exist_ok=True)
    
    # Copy Next.js specific files
    copied_count = 0
    for file_info in nextjs_files:
        source_path = Path("amplify-docs-markdown") / file_info['output']
        dest_path = nextjs_dir / file_info['output']
        
        # Create directories
        dest_path.parent.mkdir(parents=True, exist_ok=True)
        
        # Copy file
        if source_path.exists():
            import shutil
            shutil.copy2(source_path, dest_path)
            copied_count += 1
    
    # Create index for Next.js directory
    with open(nextjs_dir / "README.md", 'w') as f:
        f.write(nextjs_readme.replace("amplify-docs-markdown/", ""))
    
    print(f"📋 Created Next.js focused documentation index")
    print(f"🎯 Found {len(nextjs_files)} Next.js-specific files")
    print(f"📁 Created separate Next.js directory with {copied_count} files")
    print(f"📖 See amplify-docs-markdown/NEXTJS-README.md")
    print(f"📂 See nextjs-specific-docs/ for standalone collection")

if __name__ == "__main__":
    main()