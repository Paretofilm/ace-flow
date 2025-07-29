---
name: team-conventions
description: Core team conventions and standards that apply to all code
version: 1.0.0
inclusion: always
priority: 100
---

# Team Conventions and Standards

These conventions apply to all code in this project and are automatically enforced by ACE-Flow agents.

## Code Style

### TypeScript
- **Strict mode**: Always enabled
- **Type imports**: Use `import type` for type-only imports
- **Interfaces over types**: Prefer interfaces for object shapes
- **Explicit return types**: Always declare function return types

### Naming Conventions
- **Files**: kebab-case (e.g., `user-profile.tsx`)
- **Components**: PascalCase (e.g., `UserProfile`)
- **Functions**: camelCase (e.g., `getUserData`)
- **Constants**: UPPER_SNAKE_CASE (e.g., `MAX_RETRIES`)

## AWS Amplify Patterns

### Authentication
- Always use Cognito with email-based authentication
- Implement proper error handling for auth operations
- Use Amplify UI components for auth flows

### Data Operations
- Use typed client: `generateClient<Schema>()`
- Handle errors with destructuring: `{ data, errors }`
- Implement optimistic updates for better UX

### File Storage
- Organize uploads by user: `uploads/{userId}/{filename}`
- Always include content type in upload operations
- Implement progress tracking for large files

## Security

### Never
- Commit secrets or API keys
- Store sensitive data in frontend
- Trust client-side validation alone
- Use `any` type without justification

### Always
- Validate inputs on backend
- Use row-level security
- Implement proper CORS policies
- Log security events

## Error Handling

### Pattern
```typescript
try {
  const { data, errors } = await operation();
  if (errors) {
    console.error('Operation failed:', errors);
    // Handle specific error cases
    return;
  }
  // Success path
} catch (error) {
  console.error('Unexpected error:', error);
  // Handle system errors
}
```

## Testing

### Requirements
- Minimum 80% code coverage
- Unit tests for all utilities
- Integration tests for API endpoints
- E2E tests for critical user flows

## Documentation

### Code Comments
- JSDoc for public APIs
- Inline comments for complex logic
- TODO comments with ticket references

### README Files
- Keep updated with setup instructions
- Document environment variables
- Include architecture diagrams

## Git Conventions

### Commits
- Use conventional commits format
- Keep commits atomic
- Reference ticket numbers

### Branches
- Feature branches: `feature/ticket-description`
- Bugfix branches: `fix/ticket-description`
- Always branch from `main`

## Performance

### Frontend
- Lazy load routes and components
- Implement proper memoization
- Optimize bundle size

### Backend
- Use DynamoDB best practices
- Implement caching where appropriate
- Monitor Lambda cold starts

---

These conventions ensure consistency and quality across our codebase. All ACE-Flow agents will automatically apply these patterns.