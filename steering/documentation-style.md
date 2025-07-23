---
inclusion: conditional
fileMatchPattern: "**/docs/*,**/README*,**/CHANGELOG*,**/*.md"
description: "Documentation standards and style guide for this project"
lastUpdated: "2025-01-22T16:00:00Z"
version: "1.0"
---

# Documentation Style & Standards

## Documentation Philosophy

### Documentation Mission
- **Purpose**: [Why documentation is important for this project]
- **Audience**: [Primary and secondary audiences for our documentation]
- **Principles**: [Core principles guiding documentation decisions]
- **Success Metrics**: [How we measure documentation effectiveness]

### Documentation Types & Purposes
- **User Documentation**: [For end users of the application]
- **Developer Documentation**: [For developers working on the project]
- **API Documentation**: [For API consumers and integrators]
- **Architecture Documentation**: [For system design and architecture decisions]
- **Process Documentation**: [For development and operational processes]

## Style Guide & Standards

### Writing Style
- **Tone**: [Professional, friendly, conversational, etc.]
- **Voice**: [Active voice preferred, clear and direct]
- **Perspective**: [Second person for instructions, third person for descriptions]
- **Tense**: [Present tense for current state, future tense for planned features]

### Language Standards
- **Clarity**: [Use simple, clear language; avoid jargon unless necessary]
- **Conciseness**: [Be concise but complete; avoid redundancy]
- **Consistency**: [Use consistent terminology and phrasing]
- **Accessibility**: [Write for diverse audiences and reading levels]

### Formatting Standards
- **Headings**: [Hierarchical heading structure with meaningful titles]
- **Lists**: [When to use bullets vs. numbers vs. definition lists]
- **Code Blocks**: [Language specification and formatting standards]
- **Links**: [How to structure and format internal and external links]
- **Images**: [Alt text, sizing, and placement standards]

## Document Structure Standards

### Standard Document Template
```markdown
# Document Title
[Brief description of what this document covers]

## Overview
[High-level summary for quick understanding]

## [Main Content Sections]
[Organized by logical flow and user needs]

## Examples
[Practical examples where applicable]

## Related Resources
[Links to related documentation and resources]

---
*Last Updated: [Date] | Version: [Version]*
```

### Section Organization Principles
- **Logical Flow**: [Organize information in the order users need it]
- **Progressive Disclosure**: [Start with overview, then dive into details]
- **Scannable Structure**: [Use headings, bullets, and whitespace effectively]
- **Cross-References**: [Link between related sections and documents]

## Domain-Specific Documentation Standards

### Technical Documentation
- **Code Examples**: [Always include working, tested code examples]
- **Configuration**: [Show complete configuration files with explanations]
- **Troubleshooting**: [Include common issues and solutions]
- **Prerequisites**: [Clearly state requirements and assumptions]

### API Documentation
- **Endpoints**: [Complete endpoint documentation with examples]
- **Parameters**: [Type, required/optional, validation rules]
- **Responses**: [Success and error response examples]
- **Authentication**: [Clear authentication requirements and examples]

### Process Documentation
- **Step-by-Step Procedures**: [Clear, actionable procedures]
- **Decision Trees**: [When multiple paths are possible]
- **Checklists**: [For quality gates and validation steps]
- **Roles and Responsibilities**: [Who does what in each process]

## Content Quality Standards

### Accuracy Standards
- **Technical Accuracy**: [All code examples must be tested and working]
- **Information Currency**: [Documentation must be kept up-to-date]
- **Completeness**: [Cover all necessary information for the intended audience]
- **Consistency**: [Information must be consistent across all documentation]

### User Experience Standards
- **Findability**: [Users must be able to find relevant information quickly]
- **Usability**: [Information must be actionable and easy to follow]
- **Accessibility**: [Documentation must be accessible to diverse audiences]
- **Context**: [Provide sufficient context for understanding]

### Maintenance Standards
- **Review Cycle**: [Regular review and update schedule]
- **Version Control**: [How to track and manage documentation versions]
- **Change Process**: [How to propose and implement documentation changes]
- **Quality Assurance**: [How to validate documentation quality]

## Project-Specific Documentation Requirements

### Required Documentation Types
- **Setup Documentation**: [How to set up development environment]
- **Architecture Documentation**: [System architecture and design decisions]
- **API Documentation**: [Complete API reference and guides]
- **Deployment Documentation**: [How to deploy and operate the system]
- **Troubleshooting Documentation**: [Common issues and solutions]

### Domain-Specific Documentation Needs
- **Business Process Documentation**: [Key business processes and workflows]
- **Compliance Documentation**: [Regulatory and compliance requirements]
- **Integration Documentation**: [Third-party integration guides and references]
- **User Guide Documentation**: [End-user functionality and workflows]

### Documentation Architecture
```
docs/
├── README.md                    # Project overview and quick start
├── getting-started/             # Setup and initial configuration
├── architecture/                # System design and architecture
├── api/                        # API documentation and references
├── guides/                     # Step-by-step guides and tutorials
├── reference/                  # Reference materials and specifications
├── troubleshooting/            # Common issues and solutions
└── contributing/               # Contribution guidelines and processes
```

## Documentation Tools & Processes

### Documentation Toolchain
- **Primary Tools**: [Main documentation tools and platforms]
- **Secondary Tools**: [Supporting tools for specialized content]
- **Integration Tools**: [Tools that integrate with development workflow]
- **Publishing Tools**: [How documentation is built and published]

### Documentation Workflow
- **Creation Process**: [How new documentation is created and approved]
- **Review Process**: [How documentation changes are reviewed]
- **Publication Process**: [How documentation is published and deployed]
- **Maintenance Process**: [How documentation is kept current]

### Quality Assurance Process
- **Peer Review**: [How documentation is reviewed by team members]
- **Technical Review**: [How technical accuracy is validated]
- **User Testing**: [How documentation usability is validated]
- **Continuous Improvement**: [How documentation quality is improved over time]

## Documentation Metrics & Success

### Documentation Metrics
- **Coverage**: [What percentage of features/APIs are documented]
- **Currency**: [How up-to-date documentation is]
- **Usage**: [How frequently documentation is accessed]
- **Effectiveness**: [How well documentation serves user needs]

### Success Indicators
- **User Success**: [Users can accomplish their goals using documentation]
- **Developer Productivity**: [Documentation speeds up development]
- **Support Reduction**: [Good documentation reduces support requests]
- **Onboarding Effectiveness**: [New team members can get up to speed quickly]

## Documentation Evolution & Learning

### Documentation Lessons Learned
- **What Works**: [Documentation approaches that have been effective]
- **What Doesn't Work**: [Documentation approaches that haven't worked well]
- **User Feedback**: [Common feedback about documentation]
- **Improvement Opportunities**: [Areas where documentation can be improved]

### Documentation Standards Evolution
- **Standards Changes**: [How documentation standards have evolved]
- **Tool Evolution**: [How documentation tools have evolved]
- **Process Evolution**: [How documentation processes have evolved]
- **Quality Evolution**: [How documentation quality has improved]

---

*This documentation style guide evolves with each documentation effort, capturing institutional knowledge about what documentation approaches work best for this project and team.*