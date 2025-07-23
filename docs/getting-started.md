# Getting Started with ACE-Flow

ACE-Flow (Amplified Context Engineering) is a next-generation AI workflow system for building production-ready AWS Amplify Gen 2 applications.

## Prerequisites

- Node.js 18+ installed
- AWS CLI configured with appropriate permissions
- Basic understanding of AWS Amplify concepts

## Quick Installation

```bash
# Clone or add as submodule
git submodule add https://github.com/paretofilm/ace-flow.git .ace-flow

# Install command aliases
bash .ace-flow/scripts/install-ace-flow-aliases.sh
```

## Your First Project

```bash
# Start intelligent project creation
/ace-genesis "I want to build a social fitness app"

# ACE-Flow will:
# 1. Interview you about your vision (7-10 questions)
# 2. Research 30-100 pages of AWS documentation  
# 3. Generate custom architecture and implementation
# 4. Deploy production-ready application in <2 hours
```

## Core Commands

- `/ace-genesis [idea]` - Create new project through conversation
- `/ace-research [domain] [pattern]` - Research documentation (30-100 pages)
- `/ace-implement [project-name]` - Infrastructure-aware implementation
- `/ace-adopt [description]` - Migrate existing projects safely

## Next Steps

- [View Examples](examples.md)
- [Choose an Architecture Pattern](patterns/)
- [Advanced Configuration](advanced/)
