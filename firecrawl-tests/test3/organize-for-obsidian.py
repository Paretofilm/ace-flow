#!/usr/bin/env python3
"""
Reorganize AWS Amplify documentation for optimal browsing in Obsidian and other knowledge tools
Creates a topic-based structure with cross-references and navigation aids
"""

import os
import re
import shutil
import json
from pathlib import Path
from collections import defaultdict

def extract_topics_from_path(file_path):
    """Extract semantic topics from file path"""
    path_parts = file_path.split('/')
    topics = []
    
    # Common topic mappings
    topic_mapping = {
        'auth': 'Authentication',
        'data': 'Data & APIs', 
        'storage': 'File Storage',
        'functions': 'Functions',
        'hosting': 'Hosting & Deployment',
        'ai': 'AI & Machine Learning',
        'analytics': 'Analytics',
        'notifications': 'Push Notifications',
        'geo': 'Maps & Location',
        'quickstart': 'Getting Started',
        'start': 'Getting Started',
        'build-a-backend': 'Backend Development',
        'build-ui': 'UI Development',
        'deploy-and-host': 'Deployment',
        'ssr': 'Server-Side Rendering',
        'nextjs': 'Next.js',
        'react': 'React',
        'typescript': 'TypeScript',
        'javascript': 'JavaScript'
    }
    
    for part in path_parts:
        part_clean = part.replace('-', '').replace('_', '').lower()
        for key, topic in topic_mapping.items():
            if key in part_clean and topic not in topics:
                topics.append(topic)
    
    return topics if topics else ['General']

def create_obsidian_links(content, file_map):
    """Add Obsidian-style [[wiki links]] for internal references"""
    
    # Find potential internal references
    patterns = [
        r'amplify\s+(\w+)',
        r'aws\s+(\w+)',
        r'next\.?js\s+(\w+)',
        r'authentication',
        r'storage',
        r'functions',
        r'hosting',
        r'deployment'
    ]
    
    # This is a simplified implementation
    # In practice, you'd want more sophisticated linking
    return content

def sanitize_filename(name):
    """Create clean filenames for Obsidian"""
    # Remove special characters, keep spaces
    name = re.sub(r'[^\w\s-]', '', name)
    # Replace multiple spaces/hyphens with single space
    name = re.sub(r'[\s-]+', ' ', name)
    return name.strip()

def main():
    """Reorganize documentation for optimal browsing"""
    
    input_dir = Path("amplify-docs-markdown")
    output_dir = Path("amplify-obsidian-vault")
    
    print("🧠 Creating Obsidian-Optimized AWS Amplify Documentation Vault")
    print("=" * 70)
    
    # Clean and create output directory
    if output_dir.exists():
        shutil.rmtree(output_dir)
    output_dir.mkdir()
    
    # Load conversion index
    with open(input_dir / "index.json", 'r') as f:
        data = json.load(f)
    
    converted_files = data['converted']
    
    # Create topic-based organization
    topics = defaultdict(list)
    file_map = {}
    
    print("📋 Analyzing and categorizing files...")
    
    for file_info in converted_files:
        source = file_info['source']
        title = file_info['title']
        
        # Extract topics
        file_topics = extract_topics_from_path(source)
        
        # Determine primary topic
        primary_topic = file_topics[0] if file_topics else 'General'
        
        # Create clean filename
        clean_title = sanitize_filename(title)
        if len(clean_title) > 60:  # Limit filename length
            clean_title = clean_title[:60] + "..."
        
        new_filename = f"{clean_title}.md"
        
        # Avoid duplicates
        counter = 1
        base_filename = new_filename
        while new_filename in [f['new_filename'] for topic_files in topics.values() for f in topic_files]:
            name_part = base_filename.replace('.md', '')
            new_filename = f"{name_part} {counter}.md"
            counter += 1
        
        file_info['new_filename'] = new_filename
        file_info['topics'] = file_topics
        file_info['primary_topic'] = primary_topic
        
        topics[primary_topic].append(file_info)
        file_map[title] = new_filename
    
    print(f"📊 Found {len(topics)} main topics")
    
    # Create topic directories and copy files
    for topic, files in topics.items():
        topic_dir = output_dir / topic
        topic_dir.mkdir(exist_ok=True)
        
        print(f"📁 Creating topic: {topic} ({len(files)} files)")
        
        for file_info in files:
            # Read original file
            source_path = input_dir / file_info['output']
            if not source_path.exists():
                continue
                
            with open(source_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Enhance content for Obsidian
            enhanced_content = enhance_for_obsidian(content, file_info, topics)
            
            # Write to new location
            dest_path = topic_dir / file_info['new_filename']
            with open(dest_path, 'w', encoding='utf-8') as f:
                f.write(enhanced_content)
    
    # Create navigation and index files
    create_navigation_files(output_dir, topics)
    
    # Create Obsidian vault configuration
    create_obsidian_config(output_dir)
    
    print(f"\n✅ Obsidian vault created successfully!")
    print(f"📁 Location: {output_dir}")
    print(f"📊 Topics: {len(topics)}")
    print(f"📄 Files: {sum(len(files) for files in topics.values())}")
    print(f"\n🧠 Open '{output_dir}' in Obsidian to start browsing!")

def enhance_for_obsidian(content, file_info, topics):
    """Enhance content with Obsidian-specific features"""
    
    # Parse existing frontmatter
    frontmatter_match = re.match(r'^---\n(.*?)\n---\n(.*)$', content, re.DOTALL)
    if frontmatter_match:
        existing_frontmatter = frontmatter_match.group(1)
        main_content = frontmatter_match.group(2)
    else:
        existing_frontmatter = ""
        main_content = content
    
    # Create enhanced frontmatter
    frontmatter = f"""---
title: {file_info['title']}
topics: {file_info['topics']}
primary_topic: {file_info['primary_topic']}
source: {file_info['source']}
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, {', '.join(tag.lower().replace(' ', '-') for tag in file_info['topics'])}]
---"""
    
    # Add topic navigation
    topic_links = []
    for topic in file_info['topics']:
        topic_links.append(f"[[{topic}/]]")
    
    navigation = f"""
## 🧭 Navigation
**Topics**: {' • '.join(topic_links)}
**Primary**: [[{file_info['primary_topic']}/]]

---
"""
    
    # Combine everything
    enhanced_content = f"""{frontmatter}

{navigation}
{main_content}

---

## 📚 Related Topics
{chr(10).join(f"- [[{topic}/]]" for topic in file_info['topics'])}

## 📖 Source
Original: `{file_info['source']}`"""
    
    return enhanced_content

def create_navigation_files(output_dir, topics):
    """Create navigation and index files"""
    
    # Main vault index
    main_index = f"""# 🚀 AWS Amplify Documentation Vault

Welcome to your organized AWS Amplify documentation vault, optimized for Obsidian browsing.

## 📚 Topics Overview

{chr(10).join(f"- [[{topic}/]] ({len(files)} files)" for topic, files in sorted(topics.items()))}

## 🎯 Quick Start
1. Browse by [[Getting Started/]] for new projects
2. Check [[Next.js/]] for framework-specific guides  
3. Explore [[Backend Development/]] for API and database setup
4. See [[Deployment/]] for hosting options

## 🔍 Search Tips
- Use Obsidian's search to find specific topics
- Browse by tags: #aws #amplify #nextjs
- Use graph view to see connections between topics

## 📊 Vault Statistics
- **Total Topics**: {len(topics)}
- **Total Files**: {sum(len(files) for files in topics.values())}
- **Source**: AWS Amplify Official Documentation
- **Format**: Markdown with Obsidian enhancements

---
*Generated from AWS Amplify docs repository*
"""
    
    with open(output_dir / "README.md", 'w') as f:
        f.write(main_index)
    
    # Create topic index files
    for topic, files in topics.items():
        topic_dir = output_dir / topic
        
        topic_index = f"""# {topic}

## 📋 Files in this Topic

{chr(10).join(f"- [[{file_info['new_filename']}|{file_info['title']}]]" for file_info in sorted(files, key=lambda x: x['title']))}

## 🔗 Related Topics
{chr(10).join(f"- [[{other_topic}/]]" for other_topic in sorted(topics.keys()) if other_topic != topic)}

---
**Files**: {len(files)} | **Topic**: {topic}
"""
        
        with open(topic_dir / "README.md", 'w') as f:
            f.write(topic_index)

def create_obsidian_config(output_dir):
    """Create Obsidian vault configuration"""
    
    obsidian_dir = output_dir / ".obsidian"
    obsidian_dir.mkdir(exist_ok=True)
    
    # App configuration
    app_config = {
        "legacyEditor": False,
        "livePreview": True,
        "theme": "moonstone",
        "cssTheme": "",
        "translucency": False
    }
    
    with open(obsidian_dir / "app.json", 'w') as f:
        json.dump(app_config, f, indent=2)
    
    # Core plugins
    core_plugins = [
        "file-explorer",
        "global-search", 
        "switcher",
        "graph",
        "backlink",
        "outgoing-link",
        "tag-pane",
        "page-preview",
        "daily-notes",
        "templates",
        "note-composer",
        "command-palette",
        "markdown-importer",
        "outline",
        "word-count"
    ]
    
    with open(obsidian_dir / "core-plugins.json", 'w') as f:
        json.dump(core_plugins, f, indent=2)

if __name__ == "__main__":
    main()