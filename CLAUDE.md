# CLAUDE.md - ACE-Flow Enhanced

This file provides guidance to Claude Code when working with ACE-Flow enhanced projects.

## 🚀 ACE-Flow Integration

This project uses **ACE-Flow (Amplified Context Engineering)** - an intelligent workflow system for AWS Amplify Gen 2 development.

### Available Commands

#### Primary ACE-Flow Commands
- **`/ace-genesis [idea]`** - Intelligent project creation through conversation
- **`/ace-research [domain] [pattern]`** - Advanced documentation research (30-100 pages)
- **`/ace-implement [project-name]`** - Infrastructure-aware implementation
- **`/ace-adopt [description]`** - Safe migration of existing projects
- **`/ace-status`** - Real-time progress tracking for long operations

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
- **Auto-Fix Capability**: Resolve 80%+ of common issues using research knowledge

### Implementation Approach
1. Follow complete ACE-Flow workflow: Genesis → Research → Implementation
2. Use research-driven development (official documentation only)
3. Implement with infrastructure timing awareness
4. Validate against real AWS services
5. Ensure production-ready code with comprehensive testing

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
# Standard Amplify Gen 2 commands
npm install
npx amplify sandbox
npx amplify generate
npx amplify sandbox delete

# Testing and validation
npm run test
npm run build
npm run lint
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

---

**This CLAUDE.md is enhanced with ACE-Flow capabilities. Run `/ace-genesis` or `/ace-adopt` to customize for your specific project.**