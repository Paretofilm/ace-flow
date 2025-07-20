# ACE-Research: Advanced Documentation Research

**Systematically gathers 30-100 pages of current AWS Amplify Gen 2 documentation before implementation.**

## Usage

```bash
/ace-research [project-domain] [architecture-pattern]
```

Examples:
- `/ace-research social-fitness-app social_platform`
- `/ace-research craft-marketplace e_commerce` 
- `/ace-research content-hub content_management`

## What This Command Does

### 1. Domain Analysis
Analyzes the project requirements and architecture pattern to identify critical documentation needs:
- Core AWS Amplify Gen 2 framework requirements
- Architecture-specific integration patterns  
- Third-party service documentation needs
- Security and performance considerations

### 2. Systematic Documentation Gathering
Automatically scrapes and processes:
- **Core Framework Docs** (15-25 pages): Amplify Gen 2, Next.js, React essentials
- **Architecture-Specific Docs** (10-20 pages): Pattern-specific integration guides
- **Integration Docs** (5-15 pages): Third-party services (Stripe, social auth, etc.)
- **Best Practices** (5-10 pages): Security, performance, testing strategies

### 3. Intelligent Processing
- **Pattern Extraction**: Identifies reusable code patterns from official documentation
- **Gotcha Detection**: Finds common pitfalls and prevention strategies
- **Integration Mapping**: Maps all required service integration points
- **Validation Framework**: Creates testing and validation requirements

## Research Scope by Architecture Pattern

### Social Platform Research Package
Automatically gathers documentation for:
- AWS Cognito user groups and social authentication patterns
- Real-time GraphQL subscriptions and live data updates
- S3 media storage with CloudFront CDN optimization
- Social data modeling with relationship management
- Push notifications using AWS SNS integration

### E-commerce Research Package  
Systematically researches:
- Stripe Connect marketplace integration patterns
- Multi-vendor authentication and role management
- Order processing and inventory management workflows
- Payment security compliance and best practices
- AWS Lambda functions for complex business logic

### Content Management Research Package
Comprehensively covers:
- Rich content storage and retrieval optimization
- Publishing workflow automation and approval processes
- SEO optimization techniques with Next.js
- Media library management and asset optimization
- Content versioning and collaborative editing patterns

### Dashboard Analytics Research Package
Thoroughly investigates:
- Real-time data streaming with AWS Kinesis
- Data visualization libraries and performance optimization
- Complex query optimization for large datasets
- Analytics data modeling and aggregation strategies
- Interactive chart integration and user experience patterns

## Research Output Organization

Creates structured research in project directory:
```
research/[project-name]/
├── 00-research-summary.md         # Executive summary of findings
├── core-frameworks/
│   ├── amplify-gen2-essentials.md  # Core Amplify Gen 2 patterns
│   ├── nextjs-app-router.md        # Next.js App Router specifics
│   └── amplify-ui-components.md    # UI component library patterns
├── architecture-specific/
│   ├── [pattern]-integration.md    # Architecture-specific patterns
│   ├── [pattern]-data-models.md    # Data modeling approaches
│   └── [pattern]-gotchas.md        # Pattern-specific warnings
├── integrations/
│   ├── authentication.md           # Auth implementation details
│   ├── storage.md                  # File storage best practices
│   ├── real-time.md               # Real-time feature patterns
│   └── third-party-services.md    # External service integrations
├── code-patterns/
│   ├── data-modeling.md           # GraphQL schema patterns
│   ├── frontend-components.md     # React component patterns
│   ├── api-integration.md         # API consumption best practices
│   └── deployment.md              # Deployment configurations
└── validation/
    ├── testing-strategies.md      # Comprehensive testing approaches
    ├── performance.md             # Performance optimization techniques
    └── security.md               # Security implementation guidelines
```

## Quality Validation System

### Automatic Quality Checks
- ✅ **Coverage Completeness**: All critical integration points documented
- ✅ **Pattern Availability**: Working code examples for each major feature
- ✅ **Gotcha Documentation**: Common issues identified with prevention strategies
- ✅ **Integration Requirements**: All third-party services properly documented
- ✅ **Security Guidelines**: Comprehensive security implementation guidance

### Research Volume Metrics
- **Total Documentation**: 30-100 pages of current, official documentation
- **Code Patterns**: 15-30 proven implementation patterns extracted
- **Critical Gotchas**: 5-15 common pitfalls identified and documented
- **Integration Points**: Complete mapping of all required service integrations
- **Validation Tests**: Comprehensive testing strategy for each component

## Integration with Implementation

Research output directly feeds the implementation phase:

### Code Pattern Integration
- **Proven Patterns**: All implementation uses validated patterns from official docs
- **No Hallucination**: Zero reliance on outdated or assumed knowledge
- **Current Standards**: All patterns based on latest framework versions

### Gotcha Prevention
- **Automatic Avoidance**: Known issues are prevented during implementation
- **Validation Loops**: Testing strategies based on documented failure modes
- **Best Practices**: Security and performance guidelines automatically applied

## Expected Research Timeline

- **Simple CRUD**: 15-20 minutes, 30-40 pages
- **Content Management**: 20-25 minutes, 40-60 pages  
- **Social Platform**: 25-30 minutes, 50-70 pages
- **E-commerce**: 30-35 minutes, 60-80 pages
- **Dashboard Analytics**: 30-40 minutes, 70-100 pages

## Research Success Metrics

- **Documentation Accuracy**: >98% match with current official documentation
- **Implementation Success**: >95% of patterns work without modification
- **Gotcha Prevention**: >90% of common issues avoided through research
- **Integration Success**: 100% of documented integrations work on first try

After research completion, the system automatically proceeds to infrastructure-aware implementation with full documentation context, ensuring accurate, up-to-date code generation.

*ACE-Research ensures every implementation is built on a foundation of comprehensive, current documentation knowledge, eliminating guesswork and outdated patterns.*