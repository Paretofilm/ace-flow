#!/usr/bin/env python3
"""
Enhance the Obsidian vault with additional navigation and discovery features
"""

import os
import re
from pathlib import Path
import json
from collections import defaultdict

def clean_filename(name):
    """Clean filename for filesystem compatibility"""
    # Remove emojis and special characters
    name = re.sub(r'[^\w\s-]', '', name)
    # Replace spaces and slashes with hyphens
    name = re.sub(r'[\s/]+', '-', name)
    return name.strip('-')

def create_learning_paths(vault_dir):
    """Create structured learning paths for different scenarios"""
    
    learning_paths = {
        "Complete Beginner": [
            "Getting Started",
            "Next.js", 
            "Authentication",
            "Data & APIs",
            "Hosting & Deployment"
        ],
        
        "Backend Developer": [
            "Authentication",
            "Data & APIs", 
            "Functions",
            "File Storage"
        ],
        
        "Frontend Developer": [
            "Getting Started",
            "Next.js",
            "Authentication", 
            "React"
        ],
        
        "AI ML Developer": [
            "AI & Machine Learning",
            "Data & APIs",
            "Functions",
            "Analytics"
        ],
        
        "DevOps Deployment": [
            "Hosting & Deployment",
            "Functions",
            "Analytics"
        ]
    }
    
    # Create learning paths directory
    paths_dir = vault_dir / "Learning-Paths"
    paths_dir.mkdir(exist_ok=True)
    
    for path_name, topics in learning_paths.items():
        path_content = f"""# 🚀 {path_name} Learning Path

## 📋 Recommended Learning Sequence

{chr(10).join(f"{i+1}. [[{topic}/]]" for i, topic in enumerate(topics))}

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
        
        filename = f"{clean_filename(path_name)}.md"
        with open(paths_dir / filename, 'w', encoding='utf-8') as f:
            f.write(path_content)

def create_quick_reference(vault_dir):
    """Create quick reference cards for common tasks"""
    
    quick_ref_dir = vault_dir / "Quick-Reference"
    quick_ref_dir.mkdir(exist_ok=True)
    
    references = {
        "Next.js Setup": """# ⚡ Next.js with Amplify - Quick Setup

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
        
        "Common Commands": """# ⚡ AWS Amplify CLI - Common Commands

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
        
        "Troubleshooting": """# ⚡ Common Issues & Solutions

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
        filename = f"{clean_filename(ref_name)}.md"
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
[[Learning-Paths/Complete-Beginner]]
[[Learning-Paths/Backend-Developer]]  
[[Learning-Paths/Frontend-Developer]]
[[Learning-Paths/AI-ML-Developer]]
[[Learning-Paths/DevOps-Deployment]]

## ⚡ Quick Access
[[Quick-Reference/Next-js-Setup]]
[[Quick-Reference/Common-Commands]]
[[Quick-Reference/Troubleshooting]]

---
*Use Obsidian's Graph View to visualize these connections*
"""
    
    with open(vault_dir / "Topic-Map.md", 'w', encoding='utf-8') as f:
        f.write(map_content)

def main():
    """Enhance the Obsidian vault with additional features"""
    
    vault_dir = Path("amplify-obsidian-vault")
    
    print("🔧 Enhancing Obsidian vault with navigation features...")
    
    # Create enhanced navigation features
    create_learning_paths(vault_dir)
    create_quick_reference(vault_dir)  
    create_topic_map(vault_dir)
    
    print("✅ Vault enhancement complete!")
    print("\n🧠 **Enhanced Features Added:**")
    print("📚 Learning-Paths/ - Structured learning sequences")
    print("⚡ Quick-Reference/ - Commands and troubleshooting")  
    print("🗺️ Topic-Map.md - Visual connections for graph view")
    
    print(f"\n🚀 **Ready for Obsidian!**")
    print(f"Open '{vault_dir}' in Obsidian to start exploring")

if __name__ == "__main__":
    main()