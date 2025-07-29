# ACE-Flow Steering Files

Steering files provide persistent context and guidance to ACE-Flow agents, ensuring consistent patterns and team conventions across your project.

## Directory Structure

```
.ace-flow/steering/
├── always/          # Loaded automatically for every interaction
├── conditional/     # Loaded based on context matching
└── manual/          # Loaded only when explicitly requested
```

## Inclusion Types

### Always (Core Context)
Files in `always/` are loaded for every ACE-Flow interaction. Use sparingly for essential context:
- Team conventions and standards
- Core AWS patterns and preferences
- Security requirements
- Critical project constraints

### Conditional (Smart Loading)
Files in `conditional/` are loaded when their patterns match the current context:
- Authentication patterns (when working with auth)
- Data modeling conventions (when working with database)
- UI/UX guidelines (when working with frontend)
- API standards (when working with backend)

### Manual (On-Demand)
Files in `manual/` are loaded only when explicitly requested with `#steering:filename`:
- Advanced patterns
- Specialized configurations
- Migration guides
- Legacy system knowledge

## Steering File Format

Each steering file should include YAML frontmatter:

```yaml
---
name: authentication-patterns
description: Standard authentication patterns for our application
version: 1.0.0
inclusion: conditional
patterns:
  - "**/auth/**"
  - "**/login/**"
  - "**/signup/**"
keywords:
  - authentication
  - cognito
  - login
  - user management
---

# Content goes here...
```

## Best Practices

1. **Keep files focused** - One topic per steering file
2. **Use clear naming** - `auth-patterns.md` not `auth.md`
3. **Version your patterns** - Track changes over time
4. **Include examples** - Show correct usage
5. **Document decisions** - Explain why, not just what

## Creating Steering Files

### From ACE-Flow
```bash
/ace "create steering file for our API conventions"
```

### From Successful Implementations
```bash
/ace "capture this pattern as steering for future use"
```

### Manually
Create a markdown file in the appropriate directory with proper frontmatter.

## Examples

See the template files in each directory:
- `always/team-conventions.md` - Team standards
- `conditional/auth-patterns.md` - Authentication patterns
- `manual/migration-guide.md` - Legacy system knowledge

## Loading Priority

1. Always files (alphabetical order)
2. Conditional files (if patterns match)
3. Manual files (if requested)
4. Project-specific overrides

## Integration with Agents

All ACE-Flow agents automatically:
- Load relevant steering files
- Apply patterns and conventions
- Validate against steering rules
- Suggest steering updates when patterns emerge

---

Steering files are the memory of your project, capturing decisions and patterns that ensure consistency and quality across all development.