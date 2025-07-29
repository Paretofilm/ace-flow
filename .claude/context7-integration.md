# Context7 Integration for ACE-Flow

**This document explains how ACE-Flow uses Context7 MCP to deliver truly zero-hallucination AWS Amplify Gen 2 code.**

## Overview

Context7 is a Model Context Protocol (MCP) server that provides real-time access to verified, up-to-date documentation for AWS Amplify and other frameworks. By integrating Context7, ACE-Flow can guarantee that all generated code examples are current and working.

## How It Works

### 1. Dynamic Documentation Fetching
Instead of hardcoded examples, ACE-Flow agents now:
- Query Context7 for the latest AWS Amplify documentation
- Retrieve verified, working code snippets
- Get current API signatures and patterns

### 2. Available Libraries
Context7 provides access to:
- `/aws-amplify/docs` - Official AWS Amplify Framework Documentation (10,422+ snippets)
- `/aws-amplify/amplify-backend` - Backend-specific patterns (283+ snippets)
- `/aws-amplify/amplify-js` - JavaScript library documentation (17,813+ snippets)
- `/aws-amplify/amplify-data` - Data layer patterns (546+ snippets)

### 3. Usage in ACE-Flow Agents

#### Research Agent
```markdown
When researching AWS Amplify patterns:
1. First resolve library ID: `mcp__context7__resolve-library-id "AWS Amplify Gen 2"`
2. Fetch documentation: `mcp__context7__get-library-docs --library="/aws-amplify/docs" --topic="auth defineAuth"`
3. Extract and validate code examples
```

#### Implementation Agent
```markdown
When generating code:
1. Query Context7 for specific pattern: `mcp__context7__get-library-docs --library="/aws-amplify/amplify-backend" --topic="defineData schema"`
2. Use the returned snippets directly
3. Ensure all imports and syntax match current documentation
```

## Benefits

### ✅ Always Current
- Documentation updates automatically when AWS releases changes
- No manual maintenance of example code
- Immediate access to new features and patterns

### ✅ Zero Hallucinations
- Every code example comes from verified sources
- No guessing or extrapolation of syntax
- Confidence in generated code

### ✅ Comprehensive Coverage
- 40,000+ verified code snippets across AWS Amplify libraries
- Covers all major features: auth, data, storage, functions
- Includes TypeScript types and proper imports

## Example Context7 Query

```typescript
// Query for current auth configuration
const authDocs = await mcp__context7__get-library-docs({
  context7CompatibleLibraryID: '/aws-amplify/amplify-backend',
  topic: 'defineAuth email social providers',
  tokens: 5000
});

// Returns verified patterns like:
export const auth = defineAuth({
  loginWith: {
    email: true,
    externalProviders: {
      google: {
        clientId: secret('GOOGLE_CLIENT_ID'),
        clientSecret: secret('GOOGLE_CLIENT_SECRET'),
      }
    }
  }
});
```

## Integration Points

### 1. EARS Templates
- Replace static examples with Context7 queries
- Generate requirements with current syntax

### 2. Design Documents
- Pull architecture patterns from Context7
- Ensure all service configurations are current

### 3. Implementation Tasks
- Every code block verified against Context7
- No outdated or imaginary APIs

## Fallback Strategy

If Context7 is temporarily unavailable:
1. Log warning about potential outdated information
2. Use WebFetch on official AWS documentation
3. Mark generated code as "requires verification"
4. Never use hardcoded examples

## Monitoring

ACE-Flow tracks:
- Context7 query success rate
- Documentation freshness
- Pattern usage frequency
- Deprecated pattern detection

## Future Enhancements

1. **Caching Layer**: Smart caching of frequently used patterns
2. **Version Detection**: Automatic project version alignment
3. **Migration Assistance**: Detect outdated patterns and suggest updates
4. **Custom Patterns**: Organization-specific pattern libraries

---

**With Context7 integration, ACE-Flow delivers on its promise of zero-hallucination development.**