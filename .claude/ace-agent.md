# ACE-Agent: Intelligent Agent Orchestration

**Direct control over specialized AI agents using verified AWS Amplify Gen 2 patterns and zero-hallucination code generation.**

## Usage

```bash
# Use specialized agents directly via Claude Code's /agents command
# ACE-Flow provides 5 specialized sub-agents:

# Requirements gathering with EARS notation
> Use the requirements-agent for "fitness tracking app"

# Technical architecture with verified AWS patterns  
> Use the design-agent to create architecture from requirements

# Current AWS pattern research
> Use the research-agent for "real-time subscriptions in Amplify Gen 2"

# Code implementation with zero errors
> Use the implementation-agent to build from design specs

# Validation and compliance checking
> Use the validation-agent to check implementation against requirements

# List all available agents (including ACE-Flow agents)
/agents
```

## Context7-Enhanced Agents

**All agents now use verified AWS Amplify Gen 2 patterns with zero-hallucination code generation.**

### 🎯 **Zero-Hallucination Guarantee**
- Every code example verified against official AWS documentation
- All syntax updated for 2025 Amplify Gen 2 APIs
- TypeScript-first approach with proper type definitions
- Security patterns that pass AWS Well-Architected reviews

## Available ACE-Flow Sub-Agents

### 1. **requirements-agent**
**Purpose**: Gathers user requirements and converts them into structured EARS notation for AWS Amplify Gen 2 applications.

**Capabilities**:
- Interactive user interviewing with targeted questions
- EARS notation generation using verified AWS patterns  
- Domain pattern identification (social, e-commerce, content management, etc.)
- Complete requirements with acceptance criteria
- References current verified templates

**When to Use**: 
- Starting new ACE-Flow projects
- Adding features to existing applications
- Converting user stories to technical requirements

**Example**: `> Use the requirements-agent for "recipe sharing app with social features"`

### 2. **design-agent**
**Purpose**: Creates technical architecture using current AWS Amplify Gen 2 patterns with zero-hallucination code examples.

**Capabilities**:
- Architecture pattern selection based on requirements
- Current AWS service configurations (auth, data, storage)
- Working code examples with verified 2025 syntax
- TypeScript type definitions and proper imports
- Security and authorization patterns

**When to Use**:
- Converting requirements into technical design
- Creating data models and API specifications
- Planning authentication and storage strategies

**Example**: `> Use the design-agent to create architecture from requirements`

### 3. **research-agent**
**Purpose**: Deep research into current AWS Amplify Gen 2 documentation and patterns using Context7 MCP and web tools to ensure zero-hallucination implementations.

**Capabilities**:
- Current AWS documentation research using Context7 MCP (preferred) or WebFetch/WebSearch
- Verified code example extraction (2025 syntax only)
- Pattern validation against working implementations
- Domain-specific best practice identification
- Deprecation flagging and migration guidance
- Real-time access to latest AWS service updates

**When to Use**:
- Researching specific AWS Amplify features
- Validating current syntax and best practices
- Finding solutions to implementation challenges
- Updating patterns with latest AWS changes

**Example**: `> Use the research-agent for "current file upload patterns with progress tracking"`

### 4. **implementation-agent**
**Purpose**: Implements AWS Amplify Gen 2 applications using verified patterns from design specifications with zero compilation errors.

**Capabilities**:
- Complete project structure creation
- Backend resource implementation (auth, data, storage)
- Frontend component generation with TypeScript
- Real-time feature implementation
- Error handling and testing setup

**When to Use**:
- Converting design specifications into working code
- Implementing specific features from task lists
- Creating complete project implementations
- Setting up project structure and configurations

**Example**: `> Use the implementation-agent to build the recipe app from design specs`

### 5. **validation-agent**
**Purpose**: Validates implementations against specifications and ensures compliance with AWS best practices and current syntax.

**Capabilities**:
- Specification compliance checking
- Current AWS syntax validation
- Security and authorization review
- Performance optimization verification
- Pre-deployment quality assurance

**When to Use**:
- Validating implementations against requirements
- Pre-deployment quality checks
- Troubleshooting implementation issues
- Ensuring AWS best practices compliance

**Example**: `> Use the validation-agent to check the implementation against requirements`

## Agent Orchestration

### Parallel Execution

```bash
# Run multiple agents concurrently
/ace-agent parallel frontend:task-5 backend:task-6 test:unit

# Output shows parallel progress
┌─ Frontend Agent ─────────────┐ ┌─ Backend Agent ──────────────┐
│ ▓▓▓▓▓▓▓▓▓▓░░░░░ 67% │ │ ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ 95% │
│ Building RecipeCard... │ │ Finalizing schema... │
└──────────────────────────────┘ └──────────────────────────────┘
┌─ Test Agent ─────────────────┐
│ ▓▓▓▓░░░░░░░░░░░░ 25% │
│ Writing unit tests... │
└──────────────────────────────┘
```

### Agent Communication

Agents can communicate through shared context:

```yaml
agent_communication:
  shared_context:
    - Project specifications
    - Implementation state
    - Discovered patterns
    - Error logs
    
  message_passing:
    - Backend → Frontend: "Schema updated"
    - Validation → Implementation: "Fix required"
    - Research → Design: "Pattern found"
```

### Smart Agent Selection

The system automatically suggests appropriate agents:

```bash
$ /ace-agent
🤖 Based on your project state, I recommend:

1. validation-agent - You have uncommitted changes
2. test-agent - New components need tests
3. deployment-agent - All tests passing, ready to deploy

Select agent (1-3) or type agent name: 
```

## Advanced Features

### Agent Hooks

Configure agents to run automatically:

```yaml
# .ace-flow/agent-hooks.yml
hooks:
  on_schema_change:
    agents:
      - backend-agent --update-resolvers
      - frontend-agent --regenerate-types
      
  on_test_failure:
    agents:
      - validation-agent --diagnose
      - test-agent --fix
      
  on_pr_created:
    agents:
      - validation-agent --strict
      - security-research-agent
```

### Custom Agent Configuration

```yaml
# .ace-flow/agents/custom-review-agent.yml
name: custom-review-agent
description: "Project-specific code review"
tools:
  - read
  - grep
  - validate
prompts:
  system: |
    You are a code reviewer specialized in our team's standards.
    Focus on: performance, security, and maintainability.
  task: |
    Review the changes and ensure they meet our standards:
    - No console.log statements
    - All functions have JSDoc comments
    - Security best practices followed
```

### Agent Composition

Combine agents for complex workflows:

```bash
# Define a composite workflow
/ace-agent compose feature-complete
  - requirements-agent --story="user authentication"
  - design-agent --optimize-for=security
  - parallel:
    - backend-agent --implement
    - frontend-agent --implement
  - integration-agent --connect
  - test-agent --full-suite
  - validation-agent --strict

# Execute the composition
/ace-agent run feature-complete
```

## Benefits

### Over Current System
- **Parallel execution** instead of sequential
- **Specialized expertise** per agent
- **Better error recovery** through isolation
- **Clearer progress tracking** per agent

### For Developers
- **Choose your control level** - automatic or manual
- **Composable workflows** - mix and match agents
- **Transparent operation** - see what each agent does
- **Extensible system** - add custom agents

## Examples

### Quick Implementation
```bash
# Let agents handle everything
/ace-agent auto-implement --from=task-5
# Agents work in parallel where possible
```

### Targeted Research
```bash
# Deep dive into specific topic
/ace-agent research "real-time subscriptions" "social_platform"
# Returns comprehensive analysis with code examples
```

### Quality Assurance
```bash
# Full quality check
/ace-agent validate --strict --fix
# Runs multiple validation passes and fixes issues
```

### Custom Workflow
```bash
# Your team's specific process
/ace-agent compose our-deploy-process
/ace-agent run our-deploy-process
```

## Integration with ace-spec

The agent system integrates seamlessly with specifications:

1. **Specs drive agents** - Agents read requirements.md, design.md, tasks.md
2. **Agents update specs** - Progress reflected in real-time
3. **Validation against specs** - Ensures implementation matches requirements
4. **Automatic agent selection** - Based on current spec phase

## Next Steps

1. Use `/ace-agent list` to see all available agents
2. Try `/ace-agent research` for learning patterns
3. Use `/ace-agent validate` to check your code
4. Explore parallel execution for faster development

The agent system provides fine-grained control when you need it, while staying out of the way when you don't.