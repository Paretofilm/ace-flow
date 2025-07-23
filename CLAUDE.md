# CLAUDE.md - ACE-Flow Enhanced

This file provides guidance to Claude Code when working with ACE-Flow enhanced projects.

## 🚀 ACE-Flow Integration

This project uses **ACE-Flow (Amplified Context Engineering)** - an intelligent workflow system for AWS Amplify Gen 2 development.

### Available Commands

#### Primary ACE-Flow Commands (with aliases)
- **`/ace-genesis [idea]`** or **`/ag`** - Intelligent project creation through conversation
- **`/ace-research [domain] [pattern]`** or **`/ar`** - Advanced documentation research (30-100 pages)
- **`/ace-implement [project-name]`** or **`/ai`** - Infrastructure-aware implementation
- **`/ace-adopt [description]`** or **`/aa`** - Safe migration of existing projects
- **`/ace-status`** or **`/as`** - Real-time progress tracking with visual indicators
- **`/ace-help [command]`** or **`/ah`** - Comprehensive command documentation
- **`/ace-validate`** or **`/av`** - Pre-implementation validation checks
- **`/ace-rollback`** or **`/arb`** - Safe recovery and restore system
- **`/ace-cost`** or **`/ac`** - AWS resource cost estimation
- **`/ace-flow-install`** - Install or update command aliases

#### Using ACE-Flow as a Submodule

For better version control and contribution workflow:

```bash
# Add ACE-Flow as a submodule
git submodule add https://github.com/YourFork/ace-flow.git .ace-flow

# Install command aliases for easy access
bash .ace-flow/scripts/install-ace-flow-aliases.sh

# Now use short commands from .claude/
/ag "your app idea"
/ar domain pattern
/ai project-name

# Update ACE-Flow and refresh aliases
cd .ace-flow && git pull origin main && cd ..
/ace-flow-install --update
```

See [SUBMODULE_SETUP.md](./ace-system/SUBMODULE_SETUP.md) for detailed instructions.

#### Architecture Patterns Supported
- **social_platform**: User groups, real-time feeds, media handling
- **e_commerce**: Multi-vendor auth, payments, inventory management
- **content_management**: Publishing workflows, rich editing, SEO
- **dashboard_analytics**: Real-time data, visualizations, complex queries
- **simple_crud**: Basic forms, data management, simple relationships

## 🏗️ Development Guidelines

### Infrastructure Awareness
- AWS Amplify Gen 2 deployments take 2-5 minutes depending on complexity
- Schema changes trigger automatic type regeneration (30-60 seconds)
- Always wait for infrastructure ready before frontend development
- Use `npx amplify sandbox` for development environment

### Research-Driven Development
- **Documentation First**: Always research current official documentation (30-100 pages)
- **Pattern Extraction**: Use proven patterns from official sources only
- **Gotcha Prevention**: Identify and avoid common pitfalls through research
- **Validation Loops**: Test implementations against real AWS infrastructure

### Quality Standards
- **First-Run Success**: >95% of implementations work immediately
- **Production Ready**: Include testing, security, performance optimization
- **Real AWS Integration**: Work with actual cloud infrastructure, not mocks
- **Auto-Fix Capability**: Resolve 85%+ of common issues using smart hooks and research knowledge
- **Enhanced Error Handling**: Error codes with direct solution links
- **Visual Progress Tracking**: Rich progress indicators with specification tracking
- **Smart Automation**: Event-driven hooks for AWS Amplify workflows
- **Cost Transparency**: Pre-deployment cost estimation for all resources
- **Safe Recovery**: Comprehensive rollback system with checkpoints

### Implementation Approach
1. Follow complete ACE-Flow workflow: Genesis → Research → Implementation
2. **Structured Specifications**: Auto-generate 3-phase specs (Requirements → Design → Implementation)
3. Use research-driven development (official documentation only)
4. **Smart Hook Integration**: Automated AWS Amplify workflow triggers
5. Implement with infrastructure timing awareness
6. Validate against real AWS services
7. Ensure production-ready code with comprehensive testing

## 🔧 Project-Specific Configuration

<!-- 
NOTE: This section should be customized for your specific project.
Add project-specific guidelines, constraints, and requirements below.
-->

### Project Type
<!-- Auto-populated by ACE-Flow commands -->
**Architecture Pattern**: Not yet determined (run `/ace-genesis` or `/ace-adopt`)

### Development Commands
```bash
# Quick start with ACE-Flow
/ah                    # Get help on any command
/ag "your app idea"    # Start new project with auto-spec generation
/as                    # Check progress with visual indicators
/as --specs            # View project specifications
/as --hooks            # Show smart hook activity
/av                    # Validate before deployment
/ac                    # Estimate costs

# Standard Amplify Gen 2 commands
npm install
npx amplify sandbox    # Smart hooks auto-activate
npx amplify generate   # Auto-triggered by schema hooks
npx amplify sandbox delete

# Testing and validation (with hook automation)
npm run test           # Auto-triggered by pre-deploy hooks
npm run build          # Auto-validation hooks active
npm run lint           # Auto-triggered on file save hooks
```

### Code Style and Conventions
- Follow existing project patterns and conventions
- Use TypeScript with strict mode enabled
- Implement comprehensive error handling
- Include JSDoc comments for complex logic
- Follow security best practices (never expose secrets)

### Team Guidelines
- Create feature branches for all development
- Require code review for production changes
- Document architecture decisions
- Maintain test coverage >80%

## 🚨 Important Notes

- **Never commit secrets or API keys** to the repository
- **Always test locally** before creating pull requests
- **Follow the ACE-Flow methodology** for consistent, high-quality results
- **Update this file** when project requirements or patterns change

## 🏗️ ACE-Flow Repository Structure Rules

**CRITICAL**: This is the ACE-Flow tool repository itself, not a user project.

### Repository Structure Rules
- **NEVER create `.ace-flow/` directory inside the ace-flow repo** - this creates confusing self-nesting
- **Steering files belong in `steering/` at root level** - not in `.ace-flow/steering/`
- **Commands belong in `.claude/` directory** - these are the command implementations
- **Documentation belongs in `docs/` directory** - user guides and technical docs
- **Scripts belong in `scripts/` directory** - installation and utility scripts

### When ACE-Flow is Used (Correct Structure)
```
user-app/                  (user's application)
├── src/                   (user's app code)
├── .ace-flow/            (ace-flow as submodule)
│   ├── .claude/          (command implementations)
│   ├── steering/         (steering templates)
│   ├── docs/            (documentation)
│   └── scripts/         (utility scripts)
├── .claude/             (aliases pointing to .ace-flow/.claude/)
└── package.json         (user's app)
```

### Development Reminder
When developing ace-flow itself:
- ✅ Files go in root-level directories (`steering/`, `.claude/`, `docs/`, `scripts/`)
- ❌ Do NOT create `.ace-flow/` subdirectory inside ace-flow repo
- ✅ Test commands reference correct paths (e.g., `steering/` not `.ace-flow/steering/`)
- ✅ Installation scripts should work when ace-flow is added as submodule

---

**This CLAUDE.md is enhanced with ACE-Flow capabilities. Run `/ace-genesis` or `/ace-adopt` to customize for your specific project.**
## Available ACE-Flow Commands

### Full Commands (in .claude/)
- `/ace-genesis` - Intelligent project creation through conversation
- `/ace-research` - Advanced documentation research (30-100 pages)
- `/ace-implement` - Infrastructure-aware implementation
- `/ace-adopt` - Safe migration of existing projects
- `/ace-status` - Real-time progress tracking
- `/ace-help` - Comprehensive command documentation
- `/ace-validate` - Pre-implementation validation checks
- `/ace-rollback` - Safe recovery and restore system
- `/ace-cost` - AWS resource cost estimation
- `/ace-spec-check` - Specification compliance monitoring and accountability
- `/ace-steering` - Kiro-style steering context management and analytics
- `/ace-flow-install` - Install or update command aliases

### Short Aliases (also in .claude/)
- `/ag` → `/ace-genesis`
- `/ar` → `/ace-research`
- `/ai` → `/ace-implement`
- `/aa` → `/ace-adopt`
- `/as` → `/ace-status`
- `/ah` → `/ace-help`
- `/av` → `/ace-validate`
- `/arb` → `/ace-rollback`
- `/ac` → `/ace-cost`
- `/asc` → `/ace-spec-check`
- `/ast` → `/ace-steering`

All commands are linked to the ACE-Flow system. Run `/ace-flow-install --update` after updating the ACE-Flow submodule.

