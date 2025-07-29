#!/usr/bin/env python3
"""
Enhance the Obsidian vault with additional navigation and discovery features
"""

import os
import re
from pathlib import Path
import json
from collections import defaultdict

def create_learning_paths(vault_dir):
    """Create structured learning paths for different scenarios"""
    
    learning_paths = {
        "🚀 Complete Beginner": [
            "Getting Started/README.md",
            "Next.js/README.md",
            "Authentication/README.md", 
            "Data & APIs/README.md",
            "Hosting & Deployment/README.md"
        ],
        
        "🔧 Backend Developer": [
            "Authentication/README.md",
            "Data & APIs/README.md",
            "Functions/README.md",
            "File Storage/README.md",
            "API Reference"
        ],
        
        "🎨 Frontend Developer": [
            "Getting Started/README.md",
            "Next.js/README.md",
            "Authentication/README.md",
            "React/README.md",
            "UI Components"
        ],
        
        "🤖 AI/ML Developer": [
            "AI & Machine Learning/README.md",
            "Data & APIs/README.md",
            "Functions/README.md",
            "Analytics/README.md"
        ],
        
        "🚀 DevOps/Deployment": [
            "Hosting & Deployment/README.md",
            "Functions/README.md",
            "Analytics/README.md",
            "Monitoring"
        ]
    }
    
    # Create learning paths directory
    paths_dir = vault_dir / "📚 Learning Paths"
    paths_dir.mkdir(exist_ok=True)
    
    for path_name, topics in learning_paths.items():
        path_content = f"""# {path_name} Learning Path

## 📋 Recommended Learning Sequence

{chr(10).join(f"{i+1}. [[{topic}]]" for i, topic in enumerate(topics))}

## 💡 Tips for This Path
- Follow the sequence for best learning experience
- Complete hands-on exercises in each section
- Build a project to practice concepts
- Join the AWS Amplify community for support

## ⏱️ Estimated Time
- **Beginner**: 2-3 weeks
- **Experienced**: 1 week  
- **Expert**: 2-3 days

---
*Part of the AWS Amplify Documentation Vault*
"""
        
        filename = f"{path_name.replace('🚀 ', '').replace('🔧 ', '').replace('🎨 ', '').replace('🤖 ', '').replace('🚀 ', '').replace(' ', '-')}.md"
        with open(paths_dir / filename, 'w', encoding='utf-8') as f:
            f.write(path_content)

def create_quick_reference(vault_dir):
    """Create quick reference cards for common tasks"""
    
    quick_ref_dir = vault_dir / "⚡ Quick Reference"
    quick_ref_dir.mkdir(exist_ok=True)
    
    references = {
        "Next.js Setup": """# Next.js with Amplify - Quick Setup

## 🚀 Installation
```bash
npm create next-app@latest my-app
cd my-app
npm install aws-amplify @aws-amplify/ui-react
```

## ⚙️ Configuration
```typescript
// Configure Amplify
import { Amplify } from 'aws-amplify';
import outputs from './amplify_outputs.json';
Amplify.configure(outputs);
```

## 🔐 Authentication
```typescript
import { signIn, signOut, getCurrentUser } from 'aws-amplify/auth';
```

## 📊 Data/API
```typescript
import { generateClient } from 'aws-amplify/data';
const client = generateClient();
```

## 📂 Storage
```typescript
import { uploadData, downloadData } from 'aws-amplify/storage';
```

## 🔗 Related Topics
- [[Authentication/]]
- [[Data & APIs/]]
- [[File Storage/]]
- [[Getting Started/]]
""",
        
        "Common Commands": """# AWS Amplify CLI - Common Commands

## 🛠️ Project Setup
```bash
npm install -g @aws-amplify/cli
amplify configure
amplify init
```

## 🔐 Authentication
```bash
amplify add auth
amplify push
```

## 📊 API & Database
```bash
amplify add api
amplify add storage
amplify push
```

## 🚀 Deployment
```bash
amplify add hosting
amplify publish
```

## 🔍 Status & Info
```bash
amplify status
amplify console
amplify env list
```

## 🔗 Related Topics
- [[Getting Started/]]
- [[Hosting & Deployment/]]
- [[Authentication/]]
""",
        
        "Troubleshooting": """# Common Issues & Solutions

## 🚨 Authentication Issues
- Check AWS credentials configuration
- Verify user pool settings
- Clear browser cache/localStorage

## 📊 API/GraphQL Issues  
- Check schema syntax
- Verify resolver configuration
- Check CloudWatch logs

## 🚀 Deployment Issues
- Verify build settings
- Check environment variables
- Review CloudFormation stack

## 💾 Storage Issues
- Check S3 bucket permissions
- Verify file upload size limits
- Check CORS configuration

## 🔗 Get Help
- AWS Amplify Discord Community
- GitHub Issues
- AWS Support
- Stack Overflow

## 🔗 Related Topics
- [[Hosting & Deployment/]]
- [[Authentication/]]
- [[File Storage/]]
"""
    }
    
    for ref_name, content in references.items():
        filename = f"{ref_name.replace(' ', '-')}.md"
        with open(quick_ref_dir / filename, 'w', encoding='utf-8') as f:
            f.write(content)

def create_topic_map(vault_dir):
    """Create a visual topic map for Obsidian graph view"""
    
    map_content = """# 🗺️ AWS Amplify Topic Map

This page creates connections between all major topics for better graph visualization in Obsidian.

## 🏗️ Core Architecture
[[Authentication/]] ↔ [[Data & APIs/]] ↔ [[File Storage/]]
[[Functions/]] ↔ [[Data & APIs/]] ↔ [[Analytics/]]
[[Hosting & Deployment/]] ↔ [[Getting Started/]]

## 🖥️ Frontend Technologies  
[[Next.js/]] ↔ [[React/]] ↔ [[Server-Side Rendering/]]
[[Authentication/]] ↔ [[Next.js/]]
[[Data & APIs/]] ↔ [[React/]]

## 🤖 Advanced Features
[[AI & Machine Learning/]] ↔ [[Data & APIs/]]
[[Analytics/]] ↔ [[Functions/]]
[[Maps & Location/]] ↔ [[Data & APIs/]]
[[Push Notifications/]] ↔ [[Authentication/]]

## 🎯 Learning Paths
[[📚 Learning Paths/Complete-Beginner]]
[[📚 Learning Paths/Backend-Developer]]  
[[📚 Learning Paths/Frontend-Developer]]
[[📚 Learning Paths/AI-ML-Developer]]
[[📚 Learning Paths/DevOps-Deployment]]

## ⚡ Quick Access
[[⚡ Quick Reference/Next.js-Setup]]
[[⚡ Quick Reference/Common-Commands]]
[[⚡ Quick Reference/Troubleshooting]]

---
*Use Obsidian's Graph View to visualize these connections*
"""
    
    with open(vault_dir / "🗺️ Topic Map.md", 'w', encoding='utf-8') as f:
        f.write(map_content)

def create_search_index(vault_dir):
    """Create searchable index of all content"""
    
    # Scan all markdown files and create index
    all_files = []
    for md_file in vault_dir.rglob("*.md"):
        if md_file.name == "README.md":
            continue
            
        rel_path = md_file.relative_to(vault_dir)
        
        # Extract title from frontmatter or filename
        try:
            with open(md_file, 'r', encoding='utf-8') as f:
                content = f.read()
                
            # Extract title from frontmatter
            title_match = re.search(r'^title:\s*(.+)$', content, re.MULTILINE)
            title = title_match.group(1).strip() if title_match else md_file.stem
            
            # Extract topics/tags
            topics_match = re.search(r'^topics:\s*(.+)$', content, re.MULTILINE)
            topics = topics_match.group(1).strip() if topics_match else "[]"
            
            all_files.append({
                'title': title,
                'path': str(rel_path),
                'topics': topics,
                'directory': str(rel_path.parent)
            })
            
        except Exception as e:
            continue
    
    # Create searchable index
    index_content = f"""# 🔍 Complete File Index

Total files: {len(all_files)}

## 📁 By Directory
"""
    
    # Group by directory
    by_dir = defaultdict(list)
    for file_info in all_files:
        by_dir[file_info['directory']].append(file_info)
    
    for directory in sorted(by_dir.keys()):
        files = by_dir[directory]
        index_content += f"\n### {directory} ({len(files)} files)\n"
        for file_info in sorted(files, key=lambda x: x['title']):
            index_content += f"- [[{file_info['path']}|{file_info['title']}]]\n"
    
    index_content += f"""

## 🏷️ Search Tips
- Use Ctrl/Cmd + O for quick file search
- Use Ctrl/Cmd + Shift + F for full text search  
- Use tags: #aws #amplify #nextjs
- Use graph view for visual connections

---
*{len(all_files)} files indexed*
"""
    
    with open(vault_dir / "🔍 File Index.md", 'w', encoding='utf-8') as f:
        f.write(index_content)

def enhance_readme(vault_dir):
    """Enhance the main README with better navigation"""
    
    enhanced_readme = """# 🚀 AWS Amplify Documentation Vault

Welcome to your **organized AWS Amplify documentation vault**, optimized for Obsidian browsing and knowledge discovery.

## 🎯 Start Here
- **New to Amplify?** → [[📚 Learning Paths/Complete-Beginner]]
- **Need Quick Setup?** → [[⚡ Quick Reference/Next.js-Setup]]  
- **Having Issues?** → [[⚡ Quick Reference/Troubleshooting]]
- **Explore Visually** → [[🗺️ Topic Map]]

## 📚 Topics Overview (14 Topics, 2,198 Files)

### 🚀 Getting Started
- [[Getting Started/]] (205 files) - Setup guides and tutorials
- [[Next.js/]] (1 files) - Next.js specific documentation
- [[React/]] (19 files) - React framework guides

### 🔐 Backend Core
- [[Authentication/]] (515 files) - User management and security
- [[Data & APIs/]] (458 files) - GraphQL, REST APIs, databases
- [[Functions/]] (21 files) - Serverless functions
- [[File Storage/]] (136 files) - S3 storage and file management

### 🤖 Advanced Features  
- [[AI & Machine Learning/]] (25 files) - ML models and predictions
- [[Analytics/]] (114 files) - User analytics and tracking
- [[Maps & Location/]] (87 files) - Geolocation services
- [[Push Notifications/]] (156 files) - Mobile notifications
- [[Server-Side Rendering/]] (3 files) - SSR configuration

### 🚀 Operations
- [[Hosting & Deployment/]] (11 files) - Deploy and host applications
- [[General/]] (447 files) - General documentation and guides

## 🧭 Navigation Tools
- 🗺️ **[[🗺️ Topic Map]]** - Visual topic connections  
- 🔍 **[[🔍 File Index]]** - Complete searchable file list
- 📚 **[[📚 Learning Paths/]]** - Structured learning sequences
- ⚡ **[[⚡ Quick Reference/]]** - Commands and troubleshooting

## 🔍 Search & Discovery Tips

### Obsidian Features
- **Quick Switcher** (Ctrl/Cmd + O) - Jump to any file
- **Global Search** (Ctrl/Cmd + Shift + F) - Search all content
- **Graph View** - Visualize topic connections  
- **Backlinks** - See what references each topic
- **Tags** - Filter by #aws #amplify #nextjs

### Best Practices
1. Start with learning paths for structured approach
2. Use graph view to discover related topics
3. Bookmark frequently used quick references
4. Use search to find specific implementations
5. Follow internal links to explore related concepts

## 📊 Vault Statistics
- **Total Topics**: 14 well-organized categories
- **Total Files**: 2,198 documentation files
- **Source**: AWS Amplify Official Documentation
- **Format**: Enhanced Markdown with Obsidian features
- **Navigation**: Cross-linked with internal references

## 🎨 Obsidian Configuration
This vault comes pre-configured with:
- Optimized theme and plugins
- Tag structure for easy filtering  
- Graph view settings for topic visualization
- File naming conventions for easy browsing

---
*Generated from AWS Amplify docs repository | Optimized for knowledge discovery*
"""
    
    with open(vault_dir / "README.md", 'w', encoding='utf-8') as f:
        f.write(enhanced_readme)

def main():
    """Enhance the Obsidian vault with additional features"""
    
    vault_dir = Path("amplify-obsidian-vault")
    
    print("🔧 Enhancing Obsidian vault with navigation features...")
    
    # Create enhanced navigation features
    create_learning_paths(vault_dir)
    create_quick_reference(vault_dir)  
    create_topic_map(vault_dir)
    create_search_index(vault_dir)
    enhance_readme(vault_dir)
    
    print("✅ Vault enhancement complete!")
    print("\n🧠 **Enhanced Features Added:**")
    print("📚 Learning Paths - Structured learning sequences")
    print("⚡ Quick Reference - Commands and troubleshooting")  
    print("🗺️ Topic Map - Visual connections for graph view")
    print("🔍 File Index - Complete searchable catalog")
    print("🎯 Enhanced Navigation - Better discovery tools")
    
    print(f"\n🚀 **Ready for Obsidian!**")
    print(f"Open '{vault_dir}' in Obsidian to start exploring")

if __name__ == "__main__":
    main()