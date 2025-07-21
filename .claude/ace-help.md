# /ace-help - ACE-Flow Command Help System

## Overview
The `/ace-help` command provides comprehensive documentation and examples for all ACE-Flow commands. Use it to quickly understand command usage, parameters, and best practices.

## Usage
```
/ace-help [command]
```

## Parameters
- `command` (optional): The specific ACE-Flow command to get help for. If omitted, shows general help and available commands.

## Examples

### Get general help
```
/ace-help
```

### Get help for a specific command
```
/ace-help genesis
/ace-help research
/ace-help implement
```

## Command Reference

### 🌟 `/ace-genesis` - Intelligent Project Creation
**Purpose**: Creates new AWS Amplify Gen 2 projects through intelligent conversation.

**Usage**: `/ace-genesis [initial idea]`

**Examples**:
```
/ace-genesis "I want to build a social platform for book readers"
/ace-genesis "E-commerce site for handmade crafts"
```

**Process**:
1. Engages in discovery conversation
2. Suggests architecture pattern
3. Creates project structure
4. Sets up AWS Amplify configuration

**Tips**:
- Be specific about your requirements
- Mention key features you need
- Specify target audience

---

### 🔍 `/ace-research` - Advanced Documentation Research
**Purpose**: Performs deep research on AWS Amplify patterns and best practices.

**Usage**: `/ace-research [domain] [pattern]`

**Examples**:
```
/ace-research authentication social_platform
/ace-research storage e_commerce
/ace-research api content_management
```

**Features**:
- Analyzes 30-100 pages of documentation
- Extracts proven patterns
- Identifies common pitfalls
- Provides implementation examples

---

### 🚀 `/ace-implement` - Infrastructure-Aware Implementation
**Purpose**: Implements features with full awareness of AWS infrastructure timing.

**Usage**: `/ace-implement [project-name]`

**Examples**:
```
/ace-implement my-social-app
/ace-implement craft-marketplace
```

**Capabilities**:
- Waits for infrastructure deployment
- Handles type generation
- Implements with best practices
- Includes comprehensive testing

---

### 🔄 `/ace-adopt` - Safe Project Migration
**Purpose**: Migrates existing projects to ACE-Flow methodology.

**Usage**: `/ace-adopt [description]`

**Examples**:
```
/ace-adopt "Existing React app with basic auth"
/ace-adopt "Legacy e-commerce platform"
```

**Process**:
1. Analyzes existing codebase
2. Identifies migration path
3. Preserves functionality
4. Enhances with ACE-Flow features

---

### 📊 `/ace-status` - Real-Time Progress Tracking
**Purpose**: Shows current operation status and progress.

**Usage**: `/ace-status`

**Information Displayed**:
- Current operation phase
- Infrastructure deployment status
- Type generation progress
- Estimated time remaining

---

### ✅ `/ace-review` - Quality Assurance
**Purpose**: Performs comprehensive quality checks on implementation.

**Usage**: `/ace-review`

**Checks**:
- Code quality standards
- Security best practices
- Performance optimization
- Test coverage
- Documentation completeness

---

### 🧠 `/ace-learn` - Self-Learning Intelligence
**Purpose**: Updates ACE-Flow's knowledge base with new patterns and solutions.

**Usage**: Automatically triggered by system

**Features**:
- Tracks successful patterns
- Records error resolutions
- Updates best practices
- Improves future implementations

---

### 📝 `/update-docs` - Documentation Maintenance
**Purpose**: Updates project documentation based on current implementation.

**Usage**: `/update-docs`

**Updates**:
- README.md
- API documentation
- Architecture diagrams
- Setup instructions

## Architecture Patterns

### 🌐 Social Platform
**Complexity**: High
**Features**:
- User authentication & profiles
- Real-time feeds
- Groups & communities
- Media handling
- Notifications

### 🛒 E-commerce
**Complexity**: High
**Features**:
- Multi-vendor support
- Payment processing
- Inventory management
- Order tracking
- Customer reviews

### 📄 Content Management
**Complexity**: Medium
**Features**:
- Publishing workflows
- Rich text editing
- Media library
- SEO optimization
- Version control

### 📈 Dashboard Analytics
**Complexity**: High
**Features**:
- Real-time data processing
- Complex visualizations
- Custom queries
- Export capabilities
- User permissions

### 📋 Simple CRUD
**Complexity**: Low
**Features**:
- Basic forms
- Data tables
- Simple relationships
- Search & filter
- Basic auth

## Best Practices

### 1. Start with Genesis
Always begin new projects with `/ace-genesis` to ensure proper setup and architecture selection.

### 2. Research Before Implementation
Use `/ace-research` to understand best practices before implementing complex features.

### 3. Monitor Progress
Keep `/ace-status` open in another terminal for real-time updates during long operations.

### 4. Regular Reviews
Run `/ace-review` after major implementations to ensure quality standards.

### 5. Keep Documentation Updated
Use `/update-docs` regularly to maintain accurate project documentation.

## Troubleshooting

### Common Issues

**Issue**: "Infrastructure deployment taking too long"
**Solution**: Check `/ace-status` for detailed progress. AWS deployments typically take 2-5 minutes.

**Issue**: "Type generation failed"
**Solution**: Ensure your schema is valid and run `npx amplify generate` manually if needed.

**Issue**: "Command not found"
**Solution**: Ensure you're in an ACE-Flow enabled project with proper `.claude/` directory.

## Getting More Help

For additional assistance:
1. Check the project's CLAUDE.md file
2. Review AWS Amplify Gen 2 documentation
3. Use `/ace-research` for specific topics
4. Report issues in the project repository

## Quick Command Reference

| Command | Alias | Purpose |
|---------|-------|---------|
| `/ace-genesis` | `/ag` | Create new project |
| `/ace-research` | `/ar` | Research documentation |
| `/ace-implement` | `/ai` | Implement features |
| `/ace-adopt` | `/aa` | Migrate existing project |
| `/ace-status` | `/as` | Check progress |
| `/ace-review` | `/arv` | Quality assurance |
| `/ace-help` | `/ah` | Show this help |

---

*ACE-Flow: Amplified Context Engineering for AWS Amplify Gen 2*