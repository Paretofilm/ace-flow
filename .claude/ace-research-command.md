# /ace-research - Intelligent Research with Amplify Gen 2 Guarantee

Discover innovative solutions and best practices using the research agent with 100% AWS Amplify Gen 2 compatibility.

## Command Syntax

```bash
/ace-research [topic] [options]
```

## Core Capabilities

The research agent ensures:
- **Framework awareness** - Knows exact versions from registry
- **Gen 2 validation** - All patterns verified against purified docs
- **Multi-source research** - Firecrawl MCP + Playwright MCP fallback
- **Innovation discovery** - Finds creative solutions within constraints
- **Reliability scoring** - Rates solutions by compatibility

## Command Examples

### Basic Research Query
```bash
# Research a specific feature
/ace-research "real-time collaborative editing"

# Research with context
/ace-research "implement infinite scroll with Amplify Gen 2 data pagination"

# Research integration patterns
/ace-research "integrate Stripe payments with Amplify Gen 2 functions"
```

### Advanced Research Options
```bash
# Deep research mode (more thorough)
/ace-research "complex topic" --deep

# Target specific framework version
/ace-research "topic" --nextjs-version=14.2.16

# Include performance considerations
/ace-research "topic" --optimize-for=performance

# Focus on specific domain
/ace-research "topic" --domain=e-commerce
```

## Research Process

1. **Framework Check** - Reads `/ace-system/frameworks/README.md`
2. **Local Search** - Checks purified Amplify Gen 2 docs
3. **Web Research** - Uses Firecrawl MCP for current info
4. **Validation** - Verifies all patterns are Gen 2 compatible
5. **Scoring** - Rates solutions by reliability
6. **Documentation** - Creates implementation guide

## Example Usage

### Researching Unknown Features
```bash
# ACE-Flow Context: Research real-time collaboration
The user wants to implement real-time collaborative editing in their app, but this isn't clearly documented in the standard Amplify Gen 2 docs.

Research how to implement this feature using:
1. AWS Amplify Gen 2 data subscriptions
2. Conflict resolution strategies
3. Optimistic UI updates
4. User presence indicators

Ensure all solutions are compatible with:
- AWS Amplify 6.8.0
- Next.js 14.2.16
- React 18.2.0

Find innovative patterns that work within Gen 2 constraints.
```

### Researching Performance Optimizations
```bash
# ACE-Flow Context: Research performance patterns
Find best practices for optimizing a social media feed with:
- Thousands of posts
- Real-time updates
- Image optimization
- Infinite scroll

Research should cover:
1. Amplify Gen 2 data pagination strategies
2. Subscription optimization
3. Next.js 14 performance features
4. Caching strategies

All solutions must use Gen 2 patterns only.
```

### Researching Third-Party Integrations
```bash
# ACE-Flow Context: Research Stripe integration
Research how to integrate Stripe payments with AWS Amplify Gen 2:

1. Secure API key management
2. Webhook handling with Amplify functions
3. Payment intent creation
4. Subscription management
5. TypeScript type safety

Find patterns that:
- Use defineFunction() for serverless
- Implement proper error handling
- Follow PCI compliance
- Work with Next.js 14 App Router
```

## Output Format

The research agent creates a `research-findings.md` file with:

```markdown
# Research Findings: [Topic]

## Summary
Overview of research question and key findings

## Framework Compatibility
- Amplify: 6.8.0 ✅
- Next.js: 14.2.16 ✅
- Pattern: Gen 2 Verified ✅

## Discovered Solutions

### Solution 1: [Recommended Approach]
**Source**: Official AWS Docs
**Reliability**: High
**Compatibility**: 100%

```typescript
// Working implementation
import { defineFunction } from '@aws-amplify/backend';
// ... complete code example
```

### Solution 2: [Alternative Pattern]
[Details...]

## Implementation Guide
Step-by-step instructions with code

## Performance Considerations
- Optimization tips
- Scaling considerations

## Security Notes
- Best practices
- Common pitfalls to avoid

## References
- [Source links]
```

## Integration with Other Commands

### Pre-Implementation Research
```bash
# Research before implementing
/ace-research "websocket alternatives in Amplify Gen 2"
/ace-implement --feature="real-time-updates"
```

### Design Phase Research
```bash
# Research during design
/ace new "video streaming platform"
/ace-research "video streaming with Amplify Storage"
/ace design
```

### Validation Research
```bash
# Research for validation
/ace-research "Amplify Gen 2 security best practices"
/ace validate --security
```

## Quality Assurance

The research agent ensures quality by:

### 1. Source Verification
- Official AWS documentation priority
- Recent dates (2024-2025) preferred
- Community solutions verified
- No Gen 1 contamination

### 2. Pattern Validation
```typescript
// Every code sample is validated
validator.validateCode(discoveredCode, 'feature');
// Score must be > 70 to be included
```

### 3. Compatibility Testing
- Checks against framework registry
- Validates imports are Gen 2
- Ensures TypeScript compatibility
- Tests with current versions

### 4. Multi-Source Confirmation
- Cross-references multiple sources
- Prioritizes official documentation
- Includes practical examples
- Avoids outdated patterns

## Advanced Features

### Domain-Specific Research
```bash
# E-commerce specific patterns
/ace-research "checkout flow" --domain=e-commerce

# Social platform patterns
/ace-research "user feeds" --domain=social

# Analytics dashboard patterns
/ace-research "data visualization" --domain=dashboard
```

### Framework-Specific Research
```bash
# Next.js App Router specific
/ace-research "streaming SSR" --framework=nextjs-app-router

# React Server Components
/ace-research "RSC with Amplify" --framework=react-server
```

### Integration Research
```bash
# Research multiple integrations
/ace-research "payment processing" --integrations=stripe,paypal

# Research with constraints
/ace-research "file upload" --constraints="5GB limit,progress tracking"
```

## Troubleshooting

### Common Issues

1. **No Results Found**
   - Try broader search terms
   - Check if feature exists in Gen 2
   - Consider alternative approaches

2. **Conflicting Information**
   - Prioritize official AWS sources
   - Check dates on documentation
   - Validate with local patterns

3. **Gen 1 Contamination**
   - Agent automatically filters Gen 1
   - Report any Gen 1 patterns found
   - Use validator to double-check

## Best Practices

1. **Be Specific** - Detailed queries get better results
2. **Include Context** - Mention your use case
3. **Verify Locally** - Test discovered patterns
4. **Check Versions** - Ensure compatibility
5. **Document Findings** - Save for team reference

## Examples of Good Queries

- ✅ "How to implement real-time user presence with Amplify Gen 2 subscriptions in Next.js 14"
- ✅ "Best practices for handling large file uploads with Amplify Storage and progress tracking"
- ✅ "Implementing RBAC with Amplify Gen 2 custom authorization rules"

## Examples of Poor Queries

- ❌ "How to use Amplify" (too broad)
- ❌ "GraphQL" (not specific to Gen 2)
- ❌ "amplify add auth" (Gen 1 pattern)

The research agent is your expert guide for discovering innovative solutions while maintaining 100% AWS Amplify Gen 2 compatibility.