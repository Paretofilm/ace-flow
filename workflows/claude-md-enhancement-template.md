# CLAUDE.md Enhancement Template

**How ACE-Flow enhances existing CLAUDE.md files without losing project-specific instructions**

## 🧠 Smart Enhancement Strategy

### Detection and Preservation
1. **Read existing CLAUDE.md** to understand current project guidelines
2. **Identify ACE-Flow sections** to avoid duplication
3. **Preserve all existing content** and team-specific instructions
4. **Add ACE-Flow sections** only where missing

### Enhancement Approach

#### If CLAUDE.md Exists
```bash
# 1. Backup existing file
cp CLAUDE.md CLAUDE.md.backup

# 2. Analyze existing content
# Look for: project guidelines, team rules, tech stack info

# 3. Add ACE-Flow sections (non-destructive)
# Only add missing sections, preserve everything else
```

#### If No CLAUDE.md
```bash
# Create from ACE-Flow template with project customization
cp ace-flow/CLAUDE.md ./CLAUDE.md
```

## 📋 ACE-Flow Sections to Add

### Section 1: ACE-Flow Integration Header
```markdown
## 🚀 ACE-Flow Integration

This project uses **ACE-Flow (Amplified Context Engineering)** for intelligent AWS Amplify Gen 2 development.

### Available Commands
- `/ace-genesis [idea]` - Intelligent project creation
- `/ace-research [domain] [pattern]` - Documentation research  
- `/ace-implement [project-name]` - Infrastructure-aware implementation
- `/ace-adopt [description]` - Safe migration of existing projects
```

### Section 2: Development Guidelines (if missing)
```markdown
## 🏗️ Development Guidelines

### Infrastructure Awareness
- AWS Amplify Gen 2 deployments take 2-5 minutes depending on complexity
- Schema changes trigger automatic type regeneration (30-60 seconds)
- Always wait for infrastructure ready before frontend development

### Research-Driven Development
- **Documentation First**: Research current official documentation (30-100 pages)
- **Pattern Extraction**: Use proven patterns from official sources
- **Gotcha Prevention**: Identify and avoid common pitfalls
```

### Section 3: Architecture Patterns (if applicable)
```markdown
### Architecture Patterns Supported
- **Social Platform**: User groups, real-time feeds, media handling
- **E-commerce**: Multi-vendor auth, payments, inventory management
- **Content Management**: Publishing workflows, rich editing, SEO
- **Dashboard Analytics**: Real-time data, visualizations, queries
- **Simple CRUD**: Basic forms, data management, relationships
```

## 🔍 Smart Merge Logic

### Content Analysis
```python
def analyze_existing_claude_md(content: str) -> dict:
    """
    Analyze existing CLAUDE.md to understand what's already there
    """
    analysis = {
        "has_ace_flow": "ace-flow" in content.lower(),
        "has_dev_guidelines": "development" in content.lower(),
        "has_commands": any(cmd in content for cmd in ["/ace-", "Commands"]),
        "has_architecture": "architecture" in content.lower(),
        "project_specific_sections": extract_custom_sections(content)
    }
    return analysis

def enhance_claude_md(existing_content: str, project_info: dict) -> str:
    """
    Non-destructively enhance CLAUDE.md with ACE-Flow capabilities
    """
    analysis = analyze_existing_claude_md(existing_content)
    
    enhanced_content = existing_content
    
    # Add missing sections only
    if not analysis["has_ace_flow"]:
        enhanced_content = add_ace_flow_header(enhanced_content)
    
    if not analysis["has_commands"]:
        enhanced_content = add_ace_flow_commands(enhanced_content)
    
    if not analysis["has_dev_guidelines"]:
        enhanced_content = add_development_guidelines(enhanced_content)
    
    # Update project-specific sections
    enhanced_content = update_project_sections(enhanced_content, project_info)
    
    return enhanced_content
```

### Preservation Rules
1. **Never remove existing content**
2. **Never modify existing team guidelines**
3. **Never change existing project-specific rules**
4. **Only add ACE-Flow sections where missing**
5. **Always preserve original formatting and structure**

## 📝 Enhancement Examples

### Example 1: Existing React Project CLAUDE.md
**Before Enhancement:**
```markdown
# CLAUDE.md

## Project Overview
This is a React e-commerce application with Express backend.

## Development Rules
- Use TypeScript strict mode
- Follow company coding standards
- Require code review for all PRs

## Tech Stack
- Frontend: React 18, TypeScript, Tailwind CSS
- Backend: Express.js, MongoDB, JWT auth
- Deployment: Heroku
```

**After ACE-Flow Enhancement:**
```markdown
# CLAUDE.md

## 🚀 ACE-Flow Integration
This project uses **ACE-Flow (Amplified Context Engineering)** for intelligent AWS Amplify Gen 2 development.

### Available Commands
- `/ace-adopt "React e-commerce with Express backend"` - Safe migration to ACE-Flow
- `/ace-research e-commerce e_commerce` - Documentation research
- `/ace-implement project-name` - Infrastructure-aware implementation

## Project Overview
This is a React e-commerce application with Express backend.

## Development Rules
- Use TypeScript strict mode
- Follow company coding standards
- Require code review for all PRs

## 🏗️ ACE-Flow Development Guidelines

### Infrastructure Awareness
- Consider migration to AWS Amplify Gen 2 for improved scalability
- Research current AWS documentation before making infrastructure changes

### Research-Driven Development
- Use `/ace-research` for comprehensive documentation gathering
- Follow proven patterns from official sources

## Tech Stack
- Frontend: React 18, TypeScript, Tailwind CSS
- Backend: Express.js, MongoDB, JWT auth
- Deployment: Heroku
- **ACE-Flow**: Available for modernization and enhancement
```

### Example 2: No Existing CLAUDE.md
**Action**: Copy ACE-Flow template and customize with project information gathered during genesis/adoption process.

## 🎯 Integration Points

### With /ace-genesis
- Creates CLAUDE.md from template
- Customizes architecture pattern section
- Adds project-specific development commands

### With /ace-adopt
- Always preserves existing CLAUDE.md
- Adds ACE-Flow sections non-destructively
- Documents migration strategy and new capabilities

### With /ace-research
- Updates documentation references
- Adds researched patterns and gotchas

### With /ace-implement
- Updates with final project structure
- Adds deployment and testing commands

## 🔧 Template Variables

### Project Information
- `{{project_name}}` - Project name from genesis/adoption
- `{{architecture_pattern}}` - Detected/selected pattern
- `{{tech_stack}}` - Current technology stack
- `{{team_guidelines}}` - Existing team rules (preserved)

### ACE-Flow Configuration
- `{{ace_flow_commands}}` - Relevant commands for this project
- `{{development_guidelines}}` - Infrastructure and research guidelines
- `{{quality_standards}}` - ACE-Flow quality expectations

---

*This smart enhancement approach ensures CLAUDE.md becomes ACE-Flow capable while preserving all existing project knowledge and team guidelines.*