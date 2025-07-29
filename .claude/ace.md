# /ace - Natural Language Development Interface

The primary command for interacting with ACE-Flow using natural language. Just describe what you want to build, fix, or understand.

## Overview

`/ace` is your intelligent development partner that understands natural language and orchestrates multiple specialized agents to deliver results quickly. It combines Kiro's conversational interface with AWS Amplify Gen 2 expertise.

## Usage

```bash
/ace [your natural language request]
```

If no request is provided, `/ace` enters interactive mode where you can have a conversation.

## Interaction Modes

### 1. **Vibe Mode** (Default) - Quick Tasks & Exploration
For immediate actions, questions, and quick iterations:

```bash
/ace "add user authentication to my app"
/ace "fix the error in the payment function" 
/ace "explain how the data model works"
/ace "optimize the image upload performance"
```

### 2. **Spec Mode** - Structured Development
For complex features requiring planning and coordination:

```bash
/ace spec "e-commerce platform with real-time inventory"
/ace spec "social media app with live chat"
```

This triggers the 3-phase Kiro workflow:
- **Requirements** (EARS notation)
- **Design** (Architecture + AWS services)
- **Implementation** (Parallel agent execution)

## Natural Language Examples

### Building Features
```bash
# Simple additions
/ace "add a contact form to my website"
/ace "create a user profile page with avatar upload"

# Complex features
/ace "implement shopping cart with Stripe payments"
/ace "build real-time notifications with WebSockets"
```

### Fixing Issues
```bash
# Debug errors
/ace "help me fix this TypeScript error"
/ace "why is my Lambda function timing out?"

# Performance
/ace "optimize my DynamoDB queries"
/ace "reduce my Next.js bundle size"
```

### Understanding Code
```bash
# Explanations
/ace "explain the authentication flow"
/ace "how does the data synchronization work?"

# Documentation
/ace "document the API endpoints"
/ace "create a README for this component"
```

### AWS Operations
```bash
# Cost optimization
/ace "analyze my AWS costs and suggest optimizations"
/ace "estimate costs for 10,000 daily users"

# Deployment
/ace "deploy to staging environment"
/ace "set up CI/CD pipeline"
```

## Context Providers

Enhance your requests with specific context using the `#` syntax:

### Code Context
- `#codebase` - Auto-discover relevant files
- `#file:auth.ts` - Reference specific file
- `#folder:components/` - Include folder contents
- `#current` - Current editor file

### Project Context  
- `#amplify` - Amplify configuration
- `#steering:patterns` - Project patterns
- `#git-diff` - Current changes

### External Context
- `#mcp:firecrawl` - Web research
- `#mcp:aws-docs` - AWS documentation
- `#url:https://...` - Specific webpage

### Examples with Context
```bash
/ace "#codebase explain the payment flow"
/ace "#file:auth.ts add password reset functionality"
/ace "#mcp:aws-docs how do I set up Cognito triggers?"
/ace "#steering:api implement a new endpoint following our patterns"
```

## Smart Intent Detection

The system automatically detects your intent:

### Information Intent → Explanations
- "How does X work?"
- "Explain Y"
- "What is Z?"

### Action Intent → Code Changes
- "Create X"
- "Fix Y"
- "Add Z"

### Debug Intent → Problem Solving
- "Error: ..."
- "Why isn't X working?"
- "Debug Y"

### Optimization Intent → Improvements
- "Make X faster"
- "Reduce costs"
- "Optimize Y"

## Agent Orchestration

Behind the scenes, `/ace` coordinates multiple specialized agents:

### Parallel Execution
When you request a feature, multiple agents work simultaneously:
- **Frontend Agent** → UI components
- **Backend Agent** → API and functions
- **Infrastructure Agent** → AWS resources
- **Testing Agent** → Test generation

### Smart Delegation
The orchestrator automatically:
- Detects which agents are needed
- Delegates tasks appropriately
- Manages dependencies
- Aggregates results

## Progress Tracking

For longer operations, see real-time progress:

```
Building Authentication System... [████████░░] 80%
├── ✅ Requirements defined (EARS notation)
├── ✅ Architecture designed 
├── ✅ Cognito configured
├── ✅ UI components created
├── 🔄 API endpoints (3/4 complete)
└── ⏳ Integration tests
```

## Advanced Usage

### Steering Integration
Your project's steering files are automatically loaded:
- Always-included patterns
- Conditionally-loaded based on context
- Manual steering with `#steering:name`

### MCP Tool Access
Access AWS MCPs directly:
```bash
/ace "#mcp:frontend generate a dashboard"
/ace "#mcp:serverless optimize my Lambda"
/ace "#mcp:cdk estimate infrastructure costs"
```

### Specification Workflow
For structured development:
```bash
/ace spec "project idea"  # Full 3-phase workflow
/ace spec --phase=design  # Jump to specific phase
/ace spec --review        # Review current specs
```

## Tips for Best Results

### Be Specific
❌ "make it better"
✅ "optimize the image loading performance on mobile devices"

### Provide Context
❌ "fix the error"
✅ "fix the TypeScript error in the payment component when processing refunds"

### Use Natural Language
❌ "crud user model"
✅ "create a user management system with profile editing"

### Leverage Context Providers
❌ "update the function"
✅ "#file:api/payment.ts update the function to handle partial refunds"

## Integration with Other Commands

While `/ace` handles most tasks, specialized commands remain available:

- `/ace validate` - Explicit validation
- `/ace test` - Run test suites
- `/ace deploy` - Deployment operations
- `/ace cost` - Detailed cost analysis

## Examples by Role

### Frontend Developer
```bash
/ace "create a responsive navbar with user menu"
/ace "implement infinite scroll for the product list"
/ace "add dark mode support"
```

### Backend Developer
```bash
/ace "create a REST API for user management"
/ace "implement rate limiting on the API"
/ace "add caching to improve response times"
```

### Full-Stack Developer
```bash
/ace "build a complete blog with comments"
/ace "implement real-time collaboration features"
/ace "create an admin dashboard"
```

### DevOps Engineer
```bash
/ace "set up monitoring and alerts"
/ace "configure auto-scaling policies"
/ace "implement blue-green deployment"
```

## Error Handling

If `/ace` doesn't understand your request:
1. It will ask clarifying questions
2. Suggest similar successful requests
3. Offer to switch to spec mode for complex tasks

## Performance

- **Response time**: 2-5 seconds for simple tasks
- **Feature delivery**: 5-15 minutes for complex features
- **Parallel execution**: 3-5x faster than sequential

---

The `/ace` command represents the future of AI-assisted development - just describe what you want in natural language and watch as intelligent agents bring your ideas to life with production-ready AWS Amplify Gen 2 code.