# 🎯 ACE-Flow Steering Context Guide

## Overview

ACE-Flow's Kiro-style steering system provides persistent, project-specific context that makes every interaction smarter and more efficient. This guide explains how to use, maintain, and optimize steering context for maximum development productivity.

## What is Steering Context?

Steering context is persistent knowledge stored in markdown files that:
- **Accumulates learnings** from every project interaction
- **Provides consistent context** across all ACE-Flow commands
- **Improves decision-making** through institutional knowledge
- **Reduces repetitive explanations** and context switching
- **Enables pattern reuse** across similar projects

## Quick Start

### Installation
Steering context is automatically set up when you install ACE-Flow:

```bash
# For new projects (steering templates included)
git clone https://github.com/Paretofilm/ace-flow.git my-project
cd my-project
bash scripts/install-ace-flow.sh

# For existing projects (adds steering to your project)
git submodule add https://github.com/Paretofilm/ace-flow.git .ace-flow
bash .ace-flow/scripts/install-ace-flow.sh
```

### Basic Usage
```bash
# View all steering files and their status
/ace-steering

# Create a new steering file
/ace-steering --create [type]

# Edit an existing steering file
/ace-steering --edit [filename]

# Check steering health and effectiveness
/ace-steering --analytics
```

## Steering File Types

### 🔬 Research Context (`research-methodology.md`)
**When it's used**: During `/ace-research` and research-heavy operations
**What it contains**:
- Research priorities and methodology
- Proven research patterns for your domain
- High-value documentation sources
- Research efficiency improvements discovered

**Example content**:
```markdown
## Current Research Focus
- **Primary**: Real-time synchronization patterns (CRITICAL)
- **Secondary**: Offline-first architecture (HIGH)
- **Deferred**: Advanced analytics features (LOW)

## Research Patterns That Work
- Start with official AWS Amplify Gen 2 docs (always current)
- Social platform projects: Focus on AppSync subscriptions first
- E-commerce projects: Stripe integration patterns are well-documented
```

### 🏗️ Architecture Context (`architecture-decisions.md`)
**When it's used**: During `/ace-genesis` and architectural decisions
**What it contains**:
- Architectural decisions and rationale
- Technology stack choices and constraints
- Performance characteristics observed
- Scaling decisions and trade-offs

**Example content**:
```markdown
## Architecture Decision Records

### ADR-003: Real-time Features
- **Decision**: Use AWS AppSync subscriptions over WebSockets
- **Rationale**: Better integration with Amplify, automatic scaling
- **Performance**: Handles 100 concurrent connections well
- **Limitation**: Consider alternatives above 500 concurrent users
```

### 💼 Domain Knowledge (`domain-expertise.md`)
**When it's used**: During domain-specific operations across all commands
**What it contains**:
- Business domain understanding
- User behavior patterns observed
- Industry-specific requirements
- Regulatory and compliance considerations

**Example content**:
```markdown
## Social Fitness Domain Insights
- **User Behavior**: Users check progress 3-5x daily
- **Peak Usage**: 6-8 AM and 5-7 PM (workout times)
- **Critical Feature**: Offline workout logging (gym has poor signal)
- **Social Engagement**: Friends list drives 40% more app usage
```

### ⚡ Technical Context (`technical-context.md`)
**When it's used**: During `/ace-implement` and technical implementation
**What it contains**:
- Framework-specific patterns and optimizations
- Performance tuning discoveries
- Integration approaches that work
- Configuration patterns that succeed

**Example content**:
```markdown
## Amplify Gen 2 Patterns That Work
- **Auth**: Cognito groups perform better than custom attributes
- **Data**: GSI on userId+createdAt optimizes social feeds
- **Storage**: Direct S3 uploads + CloudFront for media performance
- **Functions**: Keep Lambda functions under 128MB for cost optimization
```

### 🧪 Quality Standards (`quality-standards.md`)
**When it's used**: During `/ace-validate` and `/ace-spec-check`
**What it contains**:
- Project-specific quality thresholds
- Testing strategies and standards
- Compliance requirements
- Performance benchmarks

**Example content**:
```markdown
## Project Quality Thresholds
- **Specification Compliance**: 95% minimum (revenue-critical app)
- **Test Coverage**: 90% for critical features, 80% for others
- **Performance**: <2s page load at 90th percentile
- **Accessibility**: WCAG 2.1 AA compliance (legal requirement)
```

## How Steering Enhances Each Command

### `/ace-genesis` - Smarter Project Creation
**Steering files loaded**: architecture-decisions.md, domain-expertise.md, quality-standards.md

**Enhancements**:
- Applies lessons from previous similar projects
- Suggests optimizations based on domain knowledge
- Sets appropriate quality standards from the start
- Avoids architectural mistakes documented in past projects

**Example**: When creating a social platform, steering remembers that real-time features need offline-first design and suggests this architecture upfront.

### `/ace-research` - More Efficient Research
**Steering files loaded**: research-methodology.md, domain-expertise.md, technical-context.md

**Enhancements**:
- Skips already-researched topics (40-45% time savings)
- Prioritizes research based on past learnings
- Applies domain-specific research strategies
- Builds on existing technical knowledge

**Example**: For a fitness app, steering knows to prioritize offline functionality research and skip basic authentication patterns.

### `/ace-implement` - Better Implementation
**Steering files loaded**: technical-context.md, implementation-learnings.md, architecture-decisions.md

**Enhancements**:
- Uses proven code patterns (35-45% speed increase)
- Applies performance optimizations from past projects
- Follows established architectural decisions
- Avoids implementation anti-patterns

**Example**: Applies database optimization patterns discovered in previous projects, resulting in 2x faster queries.

### `/ace-validate` - Contextual Validation
**Steering files loaded**: quality-standards.md, compliance-requirements.md, technical-context.md

**Enhancements**:
- Applies project-specific quality thresholds
- Uses domain-appropriate compliance checks
- Validates against established technical constraints
- Enforces lessons learned from past validation issues

**Example**: Automatically applies GDPR compliance checks for EU-targeted apps based on domain context.

### `/ace-spec-check` - Intelligent Compliance
**Steering files loaded**: quality-standards.md, implementation-learnings.md, domain-expertise.md

**Enhancements**:
- Uses project-specific compliance thresholds
- Applies historical specification patterns
- Recognizes domain-appropriate specification drift
- Suggests resolutions based on past successful approaches

**Example**: Recognizes that payment features often require specification updates and suggests appropriate compliance approaches.

## Best Practices

### 1. Keep Steering Current
```bash
# Review steering health monthly
/ace-steering --analytics

# Update outdated files
/ace-steering --validate
```

**Signs steering needs updating**:
- Files not updated in 2+ weeks during active development
- Low effectiveness scores in analytics
- Repeated manual context explanations

### 2. Capture Learnings Immediately
Document insights when they're fresh:

```markdown
## Implementation Learnings - Week 3
- **Discovery**: React Suspense causes issues with Amplify Auth
- **Solution**: Use useEffect with loading states instead
- **Performance Impact**: 300ms faster initial load
- **When to apply**: All authentication flows
```

### 3. Use Specific, Actionable Content
❌ **Vague**: "Authentication is important"
✅ **Specific**: "Use Cognito groups for social features - custom attributes cause 2x slower queries"

❌ **Generic**: "Test your code"
✅ **Actionable**: "Real-time features require testing with 10+ concurrent users - single user tests miss sync issues"

### 4. Organize by Context and Usage
Structure steering files for easy consumption:

```markdown
## Immediate Context (Always Read First)
- Current architecture constraints
- Active performance requirements
- Critical business rules

## Detailed Context (Reference When Needed)
- Historical decisions and rationale
- Alternative approaches considered
- Future considerations and planning
```

### 5. Regular Steering Maintenance
```bash
# Monthly steering review
/ace-steering --health-check

# Quarterly steering optimization
/ace-steering --optimize

# Project completion steering summary
/ace-steering --project-summary
```

## Steering Analytics & Optimization

### Understanding Steering Effectiveness
```bash
$ /ace-steering --analytics

📈 Steering Context Analytics Dashboard
======================================

## Usage Metrics (Last 30 Days)
- Total Context Inclusions: 127
- Average Context Per Interaction: 2.3 files
- Context Effectiveness Rate: 89%
- Time Saved: ~8 hours/week

## Performance Impact
- Research Efficiency: +42%
- Implementation Speed: +35%
- Quality Improvement: +28%
- Learning Retention: 95%+
```

### Optimizing Steering Performance
1. **High Usage, High Effectiveness**: Keep these files updated and detailed
2. **High Usage, Low Effectiveness**: Refactor content for better relevance
3. **Low Usage, High Effectiveness**: Consider broadening inclusion patterns
4. **Low Usage, Low Effectiveness**: Archive or remove outdated content

### Common Steering Issues and Solutions

#### Issue: Steering Files Too Generic
**Symptoms**: Low effectiveness scores, repeated context explanations
**Solution**: Add project-specific details, remove generic advice

#### Issue: Outdated Steering Content
**Symptoms**: Contradictory advice, low relevance scores
**Solution**: Regular review and update cycles, automated staleness alerts

#### Issue: Steering Overload
**Symptoms**: Too many files loading, slow performance
**Solution**: Refine inclusion patterns, consolidate related content

## Advanced Steering Techniques

### Conditional Inclusion Patterns
```yaml
# Fine-tuned inclusion for specific contexts
---
inclusion: conditional
fileMatchPattern: "**/auth/*,**/security/*,**/ace-validate*"
---
```

### Cross-Project Steering
Share successful patterns across multiple projects:

```markdown
## Patterns Proven Across Projects
- **Social Platform Auth**: Used successfully in FitFlow, SocialCraft, TeamConnect
- **E-commerce Payments**: Validated in CraftMarket, LocalStore, ArtisanHub
- **Real-time Sync**: Optimized through PetTracker, WorkoutBuddy, LiveChat
```

### Team Steering Collaboration
```markdown
## Team Steering Ownership
- **Architecture Decisions**: Tech Lead + Senior Developers
- **Domain Expertise**: Product Manager + Business Analysts
- **Quality Standards**: QA Lead + Senior Developers
- **Implementation Learnings**: All Developers (collaborative)
```

## Troubleshooting

### Steering Not Loading
```bash
# Check steering file syntax
/ace-steering --validate

# Verify inclusion patterns
/ace-steering --debug [command-name]

# Reset steering cache
/ace-steering --clear-cache
```

### Poor Steering Performance
```bash
# Analyze steering effectiveness
/ace-steering --performance

# Optimize file inclusion patterns
/ace-steering --optimize-patterns

# Clean up outdated content
/ace-steering --cleanup
```

### Steering Conflicts
```bash
# Resolve conflicting advice
/ace-steering --resolve-conflicts

# Merge team steering updates
/ace-steering --merge-updates

# Audit steering consistency
/ace-steering --audit
```

## Getting Started Checklist

✅ **Installation Complete**: ACE-Flow installed with steering templates
✅ **Initial Setup**: Steering files customized for your project
✅ **First Use**: Run a command and observe steering context loading
✅ **Learning Capture**: Add first project-specific insights
✅ **Analytics Review**: Check effectiveness after first week
✅ **Team Alignment**: Share steering approach with team members
✅ **Maintenance Schedule**: Set up regular steering review cycles

## Support and Resources

- **Command Reference**: `/ace-steering --help`
- **Analytics Dashboard**: `/ace-steering --analytics`
- **Health Monitoring**: `/ace-steering --health-check`
- **Team Collaboration**: See [steering/README.md](../steering/) for team workflow guidance  
- **Advanced Patterns**: See [patterns/](./patterns/) for architecture pattern examples

---

*With Kiro-style steering, ACE-Flow transforms from a powerful development tool into an intelligent, self-improving system that gets smarter with every project.*