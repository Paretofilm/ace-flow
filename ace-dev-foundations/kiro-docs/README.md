# Kiro Documentation

This directory contains comprehensive documentation scraped from [kiro.dev](https://kiro.dev) to support ACE-Flow integration with Kiro's specification-driven development workflow.

## 🚀 What is Kiro?

Kiro is an agentic IDE that helps developers build features through:
- **Structured specifications** with Requirements → Design → Implementation workflow
- **EARS notation** for clear, testable requirements
- **Agent Hooks** for automated task execution
- **Steering files** for project-specific context and conventions
- **MCP (Model Context Protocol)** for external tool integration

## 📁 Documentation Structure

### Core Concepts
- **[getting-started.md](./getting-started.md)** - Overview and quick start guide
- **[chat.md](./chat.md)** - Conversational AI interface and context management
- **[steering.md](./steering.md)** - Project-specific guidance and conventions system

### Specification Workflow
- **[specs.md](./specs.md)** - Overview of Kiro's spec system
- **[specs-concepts.md](./specs-concepts.md)** - Deep dive into Requirements → Design → Implementation
- **[specs-best-practices.md](./specs-best-practices.md)** - Advanced patterns and workflows

### Automation & Integration  
- **[hooks.md](./hooks.md)** - Automated triggers for development tasks
- **[mcp.md](./mcp.md)** - Model Context Protocol for external tools
- **[guides.md](./guides.md)** - Learning resources and framework-specific guides

## 🎯 Key Kiro Concepts for ACE-Flow Integration

### 1. Three-Phase Specification Workflow
```
Idea → Requirements (EARS) → Design (Architecture) → Implementation (Tasks)
```

Each spec generates three files:
- `requirements.md` - User stories in EARS notation
- `design.md` - Technical architecture and sequence diagrams  
- `tasks.md` - Discrete, trackable implementation tasks

### 2. EARS Notation Pattern
```
WHEN [condition/event]
THE SYSTEM SHALL [expected behavior]
```

Example:
```
WHEN a user submits a form with invalid data
THE SYSTEM SHALL display validation errors next to the relevant fields
```

### 3. Steering Files for Context
- **Always included**: Core project standards (`product.md`, `tech.md`, `structure.md`)
- **Conditional**: Context loaded based on file patterns (`components/**/*.tsx`)
- **Manual**: On-demand context via `#steering-file-name`

### 4. Agent Hooks for Automation
Automated responses to IDE events:
- File saves → Code quality checks
- File creation → Template application
- File deletion → Cleanup tasks

### 5. Context Providers
Rich context integration via `#` syntax:
- `#codebase` - Automatic relevant file discovery
- `#file:filename` - Specific file reference
- `#folder:path/` - Directory context
- `#git diff` - Current changes
- `#steering:filename` - Project guidance
- `#mcp:service` - External tool access

## 🔄 ACE-Flow Integration Opportunities

### Kiro → ACE-Flow Mappings
| Kiro Concept | ACE-Flow Enhancement |
|-------------|---------------------|
| Specs workflow | `/ace new` command structure |
| EARS notation | Requirements generation templates |
| Steering files | AWS Amplify Gen 2 patterns |
| Agent Hooks | Deployment automation |
| MCP integration | AWS service connections |
| Context providers | Framework-specific contexts |

### Workflow Alignment
1. **ACE-Flow `/ace new`** ← Kiro specs creation
2. **ACE-Flow agents** ← Kiro steering + hooks automation  
3. **ACE-Flow validation** ← Kiro task tracking + MCP verification
4. **ACE-Flow review** ← Kiro execution history + context management

## 📚 Implementation Patterns

### Specification-Driven Development
```markdown
# Feature: User Authentication (example)

## Requirements (EARS notation)
WHEN a user attempts to log in with valid credentials
THE SYSTEM SHALL authenticate the user and redirect to dashboard

WHEN a user attempts to log in with invalid credentials  
THE SYSTEM SHALL display an error message and remain on login page

## Design
- AWS Amplify Gen 2 auth with `defineAuth()`
- Next.js middleware for route protection
- React hooks for auth state management

## Tasks
- [ ] Configure Amplify Auth resource
- [ ] Create login component with form validation
- [ ] Implement middleware for protected routes
- [ ] Add logout functionality
- [ ] Write authentication tests
```

### Steering File Example
```markdown
---
inclusion: always
---

# AWS Amplify Gen 2 Standards

## Authentication Patterns
- Use `defineAuth()` for auth configuration
- Implement middleware for route protection
- Use `getCurrentUser()` for server-side auth checks

## Component Patterns  
- Follow Next.js App Router conventions
- Use TypeScript with strict mode
- Implement proper error boundaries

#[[file:amplify/auth/resource.ts]]
```

## 🚀 Next Steps

1. **Study Kiro Patterns**: Review each documentation file for integration opportunities
2. **Map to ACE-Flow**: Identify how Kiro concepts enhance existing ACE-Flow commands
3. **Implement Gradually**: Start with specs workflow, then add steering and hooks
4. **Test Integration**: Validate that Kiro patterns work with AWS Amplify Gen 2

## 📖 Source

Documentation scraped from [kiro.dev](https://kiro.dev) on July 28, 2025.
Kiro is currently in public preview - features and documentation may change.

---

**Perfect for:** Developers who want to combine Kiro's specification-driven workflow with ACE-Flow's AWS Amplify Gen 2 automation for structured, high-quality development processes.