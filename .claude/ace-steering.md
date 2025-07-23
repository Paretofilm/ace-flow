# 🎯 ACE-Flow Steering Management Command

## Purpose
**ace-steering** manages the Kiro-style steering files that provide persistent, project-specific context to enhance ACE-Flow's research, documentation, and implementation capabilities.

## Core Functionality

### Steering File Management
```bash
/ace-steering                          # List all steering files and status
/ace-steering --create [type]          # Create new steering file from template
/ace-steering --edit [file]            # Edit existing steering file
/ace-steering --validate               # Validate all steering files
/ace-steering --sync                   # Synchronize steering context
/ace-steering --analytics              # Show steering usage analytics
```

## Command Processing

### Phase 1: Steering Context Discovery
```yaml
steering_discovery:
  scan_directories:
    - "steering/"
    - ".kiro/steering/"
    - "docs/steering/"
    
  identify_files:
    - research-methodology.md
    - architecture-decisions.md
    - domain-expertise.md
    - quality-standards.md
    - documentation-style.md
    - technical-context.md
    - implementation-learnings.md
    - compliance-requirements.md
    
  analyze_inclusion_modes:
    - always: "Files included in every interaction"
    - conditional: "Files included based on file patterns"
    - manual: "Files included when explicitly referenced"
```

### Phase 2: Steering File Status Assessment
```yaml
status_assessment:
  file_health:
    - last_updated: "Freshness of steering content"
    - inclusion_mode: "How the file is activated"
    - usage_frequency: "How often the file provides context"
    - content_completeness: "How much project-specific content exists"
    
  context_coverage:
    - research_coverage: "Research methodology and priorities"
    - architecture_coverage: "Architectural decisions and context"
    - quality_coverage: "Quality standards and compliance"
    - domain_coverage: "Business and domain knowledge"
```

## Output Formats

### Steering Files Overview
```markdown
# 🎯 ACE-Flow Steering Context Overview

**Last Updated**: 2025-01-22 16:30:00  
**Total Steering Files**: 8  
**Context Coverage**: 95% ✅  

## Steering Files Status

### Core Context Files ✅
├── research-methodology.md (Always included)
│   └── Last updated: 2025-01-22 | Usage: High | Completeness: 85%
├── architecture-decisions.md (Always included)
│   └── Last updated: 2025-01-22 | Usage: High | Completeness: 80%
└── domain-expertise.md (Conditional: ace-genesis, ace-research)
    └── Last updated: 2025-01-22 | Usage: Medium | Completeness: 75%

### Quality & Compliance Files ✅
├── quality-standards.md (Conditional: ace-validate, ace-spec-check)
│   └── Last updated: 2025-01-22 | Usage: Medium | Completeness: 90%
├── compliance-requirements.md (Conditional: compliance, security)
│   └── Last updated: 2025-01-22 | Usage: Low | Completeness: 70%

### Development Context Files ✅
├── technical-context.md (Conditional: ace-implement, src/*)
│   └── Last updated: 2025-01-22 | Usage: High | Completeness: 80%
├── implementation-learnings.md (Conditional: ace-implement, src/*)
│   └── Last updated: 2025-01-22 | Usage: Medium | Completeness: 70%
└── documentation-style.md (Conditional: docs/*, *.md)
    └── Last updated: 2025-01-22 | Usage: Medium | Completeness: 85%

## Context Inclusion Analysis
- **Always Included**: 2 files (research-methodology, architecture-decisions)
- **Conditionally Included**: 6 files (based on file patterns and context)
- **Manually Referenced**: 0 files (none configured for manual inclusion)

## Steering Effectiveness Metrics
- **Research Enhancement**: 85% (steering significantly improves research efficiency)
- **Implementation Guidance**: 90% (strong technical context for implementation)
- **Quality Assurance**: 95% (comprehensive quality and compliance context)
- **Documentation Intelligence**: 80% (good documentation context and standards)

## Recommendations:
1. 🔄 Update domain-expertise.md with recent project learnings
2. 📊 Add more project-specific content to technical-context.md
3. 📈 Consider adding user-behavior-insights.md for UX context
4. 🎯 Review and update research priorities in research-methodology.md
```

### Detailed Steering File Analysis
```bash
$ /ace-steering --analyze research-methodology.md

📊 Steering File Analysis: research-methodology.md
===============================================

## File Metadata
- **Inclusion Mode**: Conditional (ace-research*, research/*)
- **Last Updated**: 2025-01-22T16:00:00Z
- **Version**: 1.0
- **File Size**: 3.2KB
- **Content Sections**: 8

## Usage Analytics (Last 30 Days)
- **Times Included**: 15 interactions
- **Context Effectiveness**: 85% (AI found context useful)
- **Research Efficiency Improvement**: +40% faster research
- **Research Quality Improvement**: +25% more relevant results

## Content Completeness Assessment
### Fully Populated Sections ✅
- Research Priorities Framework (100%)
- Research Quality Standards (100%)
- Research Output Standards (100%)

### Partially Populated Sections ⚠️
- Project-Specific Research Insights (60% - needs more project learnings)
- Research Efficiency Improvements (40% - needs more documented patterns)
- Current Research Focus (30% - needs regular updates)

### Empty Sections ❌
- Accumulated Domain Knowledge (10% - placeholder content only)
- Research Questions to Resolve (5% - minimal content)

## Recommendations for Improvement
1. **High Priority**: Add project-specific research insights from recent sessions
2. **Medium Priority**: Document effective research patterns discovered
3. **Low Priority**: Update current research focus areas regularly

## Integration Analysis
- **Commands Using This File**: ace-research, ace-genesis (research phase)
- **Trigger Patterns**: Matches 12 different file patterns
- **Context Relevance Score**: 92% (very relevant when included)
- **AI Context Utilization**: 88% (AI actively uses this context)

## Next Actions
- Schedule monthly review and update
- Add recent research learnings
- Update research priorities based on project evolution
```

### Steering File Creation Wizard
```bash
$ /ace-steering --create user-behavior

🎯 Creating New Steering File: user-behavior-insights.md
====================================================

## Template Selection
Available templates:
[1] Domain Knowledge Template
[2] Technical Context Template  
[3] Quality Standards Template
[4] Custom Template

Selection: 4 (Custom)

## Inclusion Mode Configuration
How should this steering file be included?

[1] Always - Include in every interaction
[2] Conditional - Include based on file patterns
[3] Manual - Include only when explicitly referenced

Selection: 2 (Conditional)

## File Pattern Configuration
Enter file patterns that should trigger inclusion (comma-separated):
> **/ux/*, **/user/*, **/behavior/*, **/analytics/*, ace-genesis*

## Content Initialization
Initialize with project-specific content? [y/N]: y

Analyzing project context for user behavior insights...
✅ Found user story patterns in specifications
✅ Identified UX-related implementation decisions
✅ Discovered user feedback patterns in documentation

## File Generation
✅ Created: steering/user-behavior-insights.md
✅ Configured inclusion mode: conditional
✅ Added file patterns: **/ux/*, **/user/*, **/behavior/*, **/analytics/*, ace-genesis*
✅ Populated with project-specific context
✅ Added to steering file registry

## Next Steps
1. Review and customize the generated content
2. Add project-specific user behavior insights
3. Set up regular update schedule
4. Test inclusion with relevant commands

File created successfully! Use '/ace-steering --edit user-behavior-insights' to customize.
```

## Steering File Templates

### Research Enhancement Template
```markdown
---
inclusion: conditional
fileMatchPattern: "**/ace-research*,**/research/*"
description: "Research methodology and context for this project"
---

# [Project] Research Context

## Research Methodology
- Research priorities and focus areas
- Proven research patterns for this domain
- Research quality standards and validation

## Domain-Specific Research Needs
- Critical knowledge areas for this project
- Integration research requirements
- Performance and scalability research needs

## Research Learning Evolution
- Accumulated research insights
- Effective research patterns discovered
- Research bottlenecks and solutions
```

### Implementation Context Template
```markdown
---
inclusion: conditional
fileMatchPattern: "**/ace-implement*,**/src/*,**/tests/*"
description: "Implementation context and proven patterns"
---

# [Project] Implementation Context

## Technology Stack Context
- Framework-specific knowledge
- Integration patterns that work
- Performance optimization insights

## Implementation Patterns
- Proven code patterns for this project
- Architecture decisions and rationale
- Error handling and edge case management

## Development Workflow
- Effective development practices
- Quality assurance integration
- Team collaboration patterns
```

## Interactive Steering Management

### Steering File Health Check
```bash
$ /ace-steering --health-check

🩺 Steering Context Health Assessment
===================================

## Overall Health Score: 88% ✅

### File Freshness Assessment
✅ **research-methodology.md**: Updated 2 days ago
✅ **architecture-decisions.md**: Updated 3 days ago
⚠️ **domain-expertise.md**: Updated 1 week ago (consider update)
❌ **quality-standards.md**: Updated 3 weeks ago (needs update)

### Content Completeness
- **High Completeness** (90%+): 3 files
- **Medium Completeness** (70-89%): 3 files
- **Low Completeness** (<70%): 2 files

### Usage Pattern Analysis
- **High Usage** (>10 inclusions/week): 4 files
- **Medium Usage** (5-10 inclusions/week): 2 files
- **Low Usage** (<5 inclusions/week): 2 files

## Recommendations:
1. 🔄 Update quality-standards.md (3 weeks old)
2. 📊 Add content to low-completeness files
3. 📈 Review usage patterns for optimization
4. 🎯 Schedule regular maintenance routine

Would you like to:
[1] Update outdated files now
[2] Schedule maintenance reminders
[3] Optimize file inclusion patterns
[4] Generate content suggestions

Choice: 1

🔄 Starting guided update process for outdated files...
```

### Steering Analytics Dashboard
```bash
$ /ace-steering --analytics

📈 Steering Context Analytics Dashboard
======================================

## Usage Metrics (Last 30 Days)
- **Total Context Inclusions**: 127
- **Average Context Per Interaction**: 2.3 files
- **Context Effectiveness Rate**: 89%
- **AI Context Utilization**: 91%

## Performance Impact
- **Research Efficiency Improvement**: +42%
- **Implementation Speed Increase**: +35%
- **Documentation Quality Improvement**: +28%
- **Quality Assurance Enhancement**: +51%

## File Usage Frequency
├── research-methodology.md: 45 inclusions (35%)
├── technical-context.md: 38 inclusions (30%)
├── architecture-decisions.md: 22 inclusions (17%)
├── quality-standards.md: 15 inclusions (12%)
└── Other files: 7 inclusions (6%)

## Context Relevance Scores
- **research-methodology.md**: 94% relevance
- **technical-context.md**: 91% relevance
- **architecture-decisions.md**: 88% relevance
- **domain-expertise.md**: 85% relevance

## Steering Evolution Timeline
- **Week 1**: Basic templates created
- **Week 2**: Project-specific content added (20% increase in effectiveness)
- **Week 3**: Usage patterns optimized (15% efficiency gain)
- **Week 4**: Content maturity reached (10% quality improvement)

## ROI Analysis
- **Time Saved**: ~8 hours/week in reduced context switching
- **Quality Improvement**: 25% fewer iterations needed
- **Knowledge Retention**: 90% of project insights preserved
- **Team Alignment**: 85% improvement in consistent approaches

## Optimization Opportunities
1. **Content Enhancement**: 3 files need more project-specific content
2. **Pattern Optimization**: 2 files have low usage despite high quality
3. **Integration Improvements**: 4 commands could benefit from additional steering
4. **Automation Opportunities**: 6 steering updates could be automated
```

## Integration with ACE-Flow Commands

### Enhanced Command Integration
```yaml
command_integration:
  ace-genesis:
    steering_files:
      - research-methodology.md
      - domain-expertise.md
      - architecture-decisions.md
    enhancement: "30-40% better architectural decisions"
    
  ace-research:
    steering_files:
      - research-methodology.md
      - domain-expertise.md
      - technical-context.md
    enhancement: "40-50% more efficient research"
    
  ace-implement:
    steering_files:
      - technical-context.md
      - implementation-learnings.md
      - architecture-decisions.md
    enhancement: "35-45% faster implementation"
    
  ace-validate:
    steering_files:
      - quality-standards.md
      - compliance-requirements.md
      - technical-context.md
    enhancement: "50-60% better quality assurance"
```

---

## Best Practices

### Steering File Maintenance
1. **Regular Updates**: Update steering files weekly during active development
2. **Content Evolution**: Add learnings and insights as they're discovered
3. **Pattern Recognition**: Document patterns that work well for reuse
4. **Context Optimization**: Review and optimize file inclusion patterns monthly

### Team Collaboration
1. **Shared Ownership**: All team members contribute to steering file evolution
2. **Knowledge Capture**: Document insights immediately while they're fresh
3. **Regular Reviews**: Schedule monthly steering context review sessions
4. **Quality Standards**: Maintain high quality in steering file content

---

*The ace-steering command transforms ACE-Flow from having "good context" to having "intelligent, evolving context" that gets smarter and more valuable over time.*