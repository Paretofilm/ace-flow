---
inclusion: conditional
fileMatchPattern: "**/ace-validate*,**/ace-spec-check*,**/ace-review*"
description: "Project-specific quality standards and compliance requirements"
lastUpdated: "2025-01-22T16:00:00Z"
version: "1.0"
---

# Quality Standards & Compliance Context

## Project Quality Philosophy

### Quality Mission
- **Quality Vision**: [Project-specific quality goals and standards]
- **Quality Principles**: [Core principles guiding quality decisions]
- **Quality Ownership**: [How quality responsibility is distributed]
- **Quality Measurement**: [How we measure and track quality]

### Quality Standards Framework
- **Code Quality**: [Standards for code maintainability and readability]
- **Architecture Quality**: [Standards for system design and architecture]
- **User Experience Quality**: [Standards for user-facing functionality]
- **Performance Quality**: [Standards for system performance and scalability]
- **Security Quality**: [Standards for system security and data protection]

## Specification Compliance Standards

### Compliance Thresholds
- **Production Deployment**: 95% compliance minimum (higher than default due to [business reason])
- **Staging Deployment**: 90% compliance minimum
- **Development Integration**: 85% compliance minimum
- **Feature Branch**: 80% compliance minimum

### Critical User Stories
- **Revenue-Critical Features**: [User stories that directly impact revenue]
- **Security-Critical Features**: [User stories involving sensitive data or operations]
- **Compliance-Critical Features**: [User stories required for regulatory compliance]
- **User-Experience-Critical Features**: [User stories essential for user satisfaction]

### Specification Change Governance
- **High-Impact Changes**: Require stakeholder approval + technical review + business validation
- **Medium-Impact Changes**: Require technical lead approval + automated testing validation
- **Low-Impact Changes**: Require peer review + specification documentation update
- **Emergency Changes**: Require post-hoc documentation and stakeholder notification

## Testing Standards & Philosophy

### Testing Philosophy for This Project
- **Test Strategy**: [Project-specific testing approach and rationale]
- **Coverage Standards**: [Code coverage and specification coverage requirements]
- **Test Types**: [Unit, integration, e2e testing standards for this project]
- **Test Data**: [Test data management approach for this domain]

### Domain-Specific Testing Requirements
- **Real-Time Features**: [How to test real-time functionality effectively]
- **Integration Testing**: [Third-party integration testing standards]
- **Performance Testing**: [Performance testing requirements and thresholds]
- **Security Testing**: [Security testing standards and requirements]
- **Accessibility Testing**: [Accessibility testing standards and compliance]

### Test-Specification Alignment Standards
- **Acceptance Criteria Coverage**: 95% minimum (all critical AC must be tested)
- **User Story Validation**: 100% (every user story must have end-to-end validation)
- **Edge Case Coverage**: 80% minimum (error conditions and boundary cases)
- **Regression Test Coverage**: 90% minimum (prevent feature regression)

## Performance Quality Standards

### Performance Benchmarks for This Project
- **Page Load Performance**: [Specific performance targets for user-facing pages]
- **API Response Performance**: [Backend API performance requirements]
- **Database Performance**: [Database query and transaction performance standards]
- **Real-Time Performance**: [Real-time feature latency and throughput requirements]
- **Mobile Performance**: [Mobile-specific performance requirements]

### Performance Testing Strategy
- **Load Testing**: [Load testing approach and thresholds]
- **Stress Testing**: [Stress testing scenarios and failure modes]
- **Performance Monitoring**: [Continuous performance monitoring standards]
- **Performance Regression**: [How to detect and address performance regressions]

## Security & Compliance Standards

### Security Requirements for This Domain
- **Data Protection Standards**: [How sensitive data must be protected]
- **Authentication Standards**: [Authentication and session management requirements]
- **Authorization Standards**: [Access control and permission management requirements]
- **Audit Standards**: [Security audit logging and monitoring requirements]

### Compliance Requirements
- **Regulatory Compliance**: [Industry-specific regulatory requirements]
- **Data Privacy Compliance**: [GDPR, CCPA, and other privacy requirements]
- **Security Compliance**: [Security framework compliance requirements]
- **Business Compliance**: [Internal business policy compliance requirements]

### Security Testing Standards
- **Vulnerability Scanning**: [Automated vulnerability scanning requirements]
- **Penetration Testing**: [Manual security testing requirements]
- **Security Code Review**: [Security-focused code review standards]
- **Dependency Security**: [Third-party dependency security validation]

## Code Quality Standards

### Code Style & Standards
- **Coding Standards**: [Language-specific coding standards and style guides]
- **Documentation Standards**: [Code documentation and commenting requirements]
- **Code Review Standards**: [Code review process and quality gates]
- **Refactoring Standards**: [When and how to refactor code]

### Architecture Quality Standards
- **Design Principles**: [Architectural design principles for this project]
- **Pattern Compliance**: [Adherence to chosen architectural patterns]
- **Dependency Management**: [How to manage and validate dependencies]
- **Technical Debt Management**: [How to identify and address technical debt]

### Maintainability Standards
- **Code Complexity**: [Cyclomatic complexity and other complexity metrics]
- **Code Duplication**: [Standards for code reuse and DRY principle]
- **Naming Standards**: [Variable, function, and class naming standards]
- **Error Handling**: [Error handling and exception management standards]

## Quality Assurance Process

### Quality Gates
- **Pre-Commit Quality Gates**: [Quality checks before code commit]
- **Pre-Deploy Quality Gates**: [Quality validation before deployment]
- **Post-Deploy Quality Gates**: [Quality monitoring after deployment]
- **Release Quality Gates**: [Quality validation for production releases]

### Quality Metrics & Monitoring
- **Quality Metrics Dashboard**: [Key quality metrics to track continuously]
- **Quality Trend Analysis**: [How to track quality trends over time]
- **Quality Alerts**: [When and how to alert on quality issues]
- **Quality Reporting**: [Quality reporting to stakeholders]

### Continuous Quality Improvement
- **Quality Retrospectives**: [How to learn from quality issues]
- **Process Improvement**: [How to improve quality processes over time]
- **Tool Evaluation**: [How to evaluate and adopt quality tools]
- **Training & Development**: [How to improve team quality capabilities]

## Project-Specific Quality Context

### Current Quality Status
- **Overall Quality Score**: [Current project quality assessment]
- **Quality Trends**: [Recent quality trend analysis]
- **Active Quality Issues**: [Current quality issues requiring attention]
- **Quality Improvement Initiatives**: [Active quality improvement efforts]

### Quality Challenges & Solutions
- **Domain-Specific Challenges**: [Quality challenges specific to our domain]
- **Technical Quality Challenges**: [Technical quality issues discovered]
- **Process Quality Challenges**: [Quality process issues and improvements]
- **Team Quality Challenges**: [Team-related quality issues and development]

### Quality Learning & Evolution
- **Quality Lessons Learned**: [Key quality insights gained during development]
- **Quality Process Evolution**: [How our quality processes have evolved]
- **Quality Tool Evolution**: [How our quality tooling has evolved]
- **Quality Standards Evolution**: [How our quality standards have evolved]

## Stakeholder Quality Requirements

### Business Quality Requirements
- **Business Stakeholder Expectations**: [Quality expectations from business stakeholders]
- **User Quality Requirements**: [Quality requirements from user perspective]
- **Technical Stakeholder Requirements**: [Quality requirements from technical stakeholders]
- **Compliance Stakeholder Requirements**: [Quality requirements from compliance perspective]

### Quality Communication Standards
- **Quality Reporting**: [How to report quality status to stakeholders]
- **Quality Issue Escalation**: [When and how to escalate quality issues]
- **Quality Success Communication**: [How to communicate quality successes]
- **Quality Risk Communication**: [How to communicate quality risks]

---

*This quality context evolves with every quality gate, review, and improvement initiative, building institutional knowledge about what quality means for this specific project and domain.*