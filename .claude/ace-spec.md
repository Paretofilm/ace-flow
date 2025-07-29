# ACE-Spec: 3-Phase Kiro Workflow for AWS Amplify Gen 2

**Specification-driven development using the proven Kiro methodology with natural language interaction and intelligent agent orchestration.**

## Overview

The `/ace-spec` command implements Kiro's 3-phase workflow for structured development:
1. **Requirements Phase** - EARS notation with clear, testable specifications
2. **Design Phase** - Technical architecture with AWS service selection
3. **Implementation Phase** - Parallel agent execution with validated code

## Usage

```bash
# Natural language entry (delegates from /ace)
/ace spec "your app idea"

# Direct command usage
/ace-spec [phase] [action] [options]

# Start new specification workflow
/ace-spec new "recipe sharing platform"

# Execute specific phase
/ace-spec requirements generate
/ace-spec design create
/ace-spec implement start

# Review and validate
/ace-spec review           # Full progress overview
/ace-spec validate         # Compliance check
```

## 3-Phase Kiro Workflow

### Phase 1: Requirements Engineering

**Purpose**: Transform natural language ideas into clear, testable specifications using EARS notation.

**Agent**: Requirements Agent
**Input**: Natural language description of desired application
**Output**: `specs/requirements.md` with structured user stories

```bash
# Example: Starting requirements phase
/ace-spec requirements generate "recipe sharing app with social features"

# Output structure:
specs/
├── requirements.md      # EARS notation requirements
├── user-stories.md     # Detailed user journeys
└── acceptance-tests.md # Testable criteria
```

### Phase 2: Design Architecture

**Purpose**: Create technical architecture based on requirements, selecting appropriate AWS services.

**Agent**: Design Agent
**Input**: Requirements from Phase 1
**Output**: `specs/design.md` with architecture decisions

```bash
# Example: Design phase
/ace-spec design create

# Output includes:
- System architecture diagram
- AWS service selection rationale
- Data model design
- API specifications
- Security architecture
```

### Phase 3: Implementation

**Purpose**: Generate working code through parallel agent execution.

**Agents**: Multiple specialized implementation agents
**Input**: Requirements + Design specifications
**Output**: Complete, working application code

```bash
# Example: Implementation phase
/ace-spec implement start

# Parallel agent execution:
├── Frontend Agent     → UI components, pages
├── Backend Agent      → APIs, business logic
├── Infrastructure Agent → AWS CDK, resources
└── Testing Agent      → Unit/integration tests
```

## Steering File Integration

The spec workflow automatically integrates with steering files:

```yaml
.ace-flow/
└── steering/
    ├── always/          # Loaded for every phase
    │   ├── aws-patterns.md
    │   └── team-conventions.md
    ├── conditional/     # Loaded based on context
    │   ├── auth-patterns.md (when: authentication)
    │   └── data-patterns.md (when: database)
    └── manual/          # Loaded on request
        └── advanced-patterns.md
```

## Natural Language Flow

The spec workflow is designed for natural language interaction:

### From Idea to Implementation

```bash
# Developer describes their idea
/ace "I want to build a recipe sharing platform where users can upload photos, 
     share recipes, and comment in real-time"

# System detects specification intent and delegates to spec workflow
Orchestrator: Detected complex application request. Starting specification workflow...

# Phase 1: Requirements automatically generated
Requirements Agent: Analyzing your request...
✅ Generated 15 EARS requirements
✅ Created 8 user stories  
✅ Defined acceptance criteria

# Phase 2: Design created based on requirements
Design Agent: Creating architecture...
✅ Selected AWS services: Amplify, Cognito, DynamoDB, S3
✅ Designed data models with relationships
✅ Created API specifications

# Phase 3: Implementation with parallel agents
Implementation Orchestration:
├── Frontend Agent:    Creating React components...
├── Backend Agent:     Setting up GraphQL API...
├── Infrastructure:    Configuring AWS resources...
└── Testing Agent:     Generating test suites...

✅ Complete application ready for deployment
```

### Example: Requirements Phase Output

```markdown
# requirements.md

## Recipe Sharing Requirements

### User Registration
WHEN a new user wants to join the platform
THE SYSTEM SHALL provide email-based registration
SO THAT users can create authenticated accounts

### Recipe Creation  
WHEN an authenticated user creates a recipe
THE SYSTEM SHALL store recipe data with:
- Title (required)
- Description
- Ingredients list
- Instructions
- Cooking time
- Photo upload capability
SO THAT users can share complete recipe information

### Social Features
WHEN a user views a recipe
THE SYSTEM SHALL display real-time comments
AND allow authenticated users to add comments
SO THAT users can engage with recipe creators

### Authorization
THE SYSTEM SHALL ensure:
- Only recipe owners can edit/delete their recipes
- All authenticated users can read recipes
- Only authenticated users can comment
SO THAT content remains secure and controlled
```

### Example: Design Phase Output

```markdown
# design.md

## Recipe Sharing Platform Architecture

### AWS Services Selection
- **Authentication**: AWS Cognito (email-based)
- **API**: AWS AppSync (GraphQL)
- **Database**: DynamoDB (serverless)
- **Storage**: S3 (recipe images)
- **Hosting**: Amplify Hosting
- **Real-time**: AppSync Subscriptions

### Data Model Design
- Recipe (owner-based access)
  - Comments (1:many relationship)
  - Images (S3 references)
- User Profile (extended from Cognito)
- Real-time subscriptions for comments

### Security Architecture
- Row-level security on all data models
- S3 bucket policies for image access
- API throttling and request validation
```

### Example: Implementation Phase

During implementation, multiple agents work in parallel:

```bash
$ /ace-spec implement start

🚀 Launching Implementation Agents...

Frontend Agent     [████████░░] 80%
├── ✅ Created RecipeList component
├── ✅ Created RecipeForm with image upload
├── ✅ Implemented real-time comments
└── 🔄 Adding responsive design

Backend Agent      [██████████] 100%
├── ✅ Configured Amplify auth
├── ✅ Created GraphQL schema
├── ✅ Set up storage rules
└── ✅ Implemented subscriptions

Infrastructure     [█████████░] 90%
├── ✅ Deployed Cognito user pool
├── ✅ Created DynamoDB tables
├── ✅ Configured S3 bucket
└── 🔄 Setting up CDN

Testing Agent      [████░░░░░░] 40%
├── ✅ Unit tests for components
├── 🔄 Integration tests
└── ⏳ E2E test scenarios

Overall Progress: 77% Complete
Time Elapsed: 8 minutes
```

## Progress Visualization

The spec workflow provides real-time progress tracking:
```bash
$ /ace-spec review

📊 Specification Progress Dashboard

┌─────────────────────────────────────────┐
│ Recipe Sharing Platform                 │
│ Status: Implementation Phase            │
│ Started: 10 minutes ago                 │
└─────────────────────────────────────────┘

📋 Requirements Phase      ✅ Complete
   └── 15 EARS requirements defined
   └── 8 user stories created
   └── Acceptance criteria established

🏗️  Design Phase           ✅ Complete  
   └── AWS services selected
   └── Data models designed
   └── Security architecture defined

🚀 Implementation Phase    🔄 In Progress (77%)
   ├── Frontend:      [████████░░] 80%
   ├── Backend:       [██████████] 100%
   ├── Infrastructure:[█████████░] 90%
   └── Testing:       [████░░░░░░] 40%

📝 Next Steps:
   1. Complete responsive design (Frontend)
   2. Finish CDN configuration (Infrastructure)
   3. Complete integration tests (Testing)

⏱️  Estimated completion: 5-7 minutes
```

## Agent Orchestration

The spec workflow coordinates specialized agents for each phase:

### Requirements Agent
- **Purpose**: Transform ideas into EARS notation
- **Tools**: Steering templates, pattern matching
- **Output**: Clear, testable requirements

### Design Agent  
- **Purpose**: Create technical architecture
- **Tools**: AWS service catalog, best practices
- **Output**: Complete system design

### Implementation Agents
- **Frontend Agent**: UI components and interactions
- **Backend Agent**: APIs and business logic
- **Infrastructure Agent**: AWS resources and configuration
- **Testing Agent**: Automated test generation
## Workflow Benefits

### Clear Phases
- **Requirements First**: No ambiguity about what to build
- **Design Before Code**: Architecture decisions made upfront
- **Parallel Implementation**: Multiple agents work simultaneously

### Natural Language
- Describe your app idea in plain English
- System understands intent and complexity
- Automatic delegation to appropriate workflow

### Quality Built-In
- EARS notation ensures testable requirements
- AWS best practices enforced by design
- Validation at every phase
- Type-safe code generation

## Integration with Natural Language

The spec workflow seamlessly integrates with the `/ace` natural language interface:

```bash
# Natural language requests automatically use spec workflow when appropriate
/ace "build a complete e-commerce platform"
# → Delegates to /ace-spec new

/ace "add payment processing to my app"
# → May trigger spec workflow if complex

/ace "fix the bug in auth"
# → Quick fix, no spec needed
```

## Examples by Complexity

### Simple Feature (Vibe Mode)
```bash
/ace "add a contact form"
# Direct implementation, no spec needed
```

### Medium Feature (Mini-Spec)
```bash
/ace "add user profiles with avatars"
# Quick requirements → design → implement
```

### Complex Application (Full Spec)
```bash
/ace spec "social media platform with real-time features"
# Complete 3-phase workflow with all agents
```

## Continuous Improvement

The spec workflow learns and improves:
- Steering files capture patterns
- Successful implementations become templates
- Team conventions automatically applied
- AWS best practices continuously updated

---

**The `/ace-spec` command brings structure to creativity, ensuring your ideas become production-ready applications through the proven 3-phase Kiro workflow.**