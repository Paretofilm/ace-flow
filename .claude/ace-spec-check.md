# 📊 ACE-Flow Specification Compliance Checker with Steering Context

## Purpose
**ace-spec-check** provides comprehensive analysis of how well your current implementation matches the original project specifications generated during the genesis phase. Enhanced with steering context, this command implements Kiro-style accountability by tracking specification drift, applying project-specific quality standards, and ensuring requirements remain aligned with actual functionality using proven patterns.

## Core Functionality

### Specification Compliance Analysis
```bash
/ace-spec-check                    # Basic compliance check
/ace-spec-check --detailed         # Detailed analysis with deviation breakdown
/ace-spec-check --fix-drift        # Interactive mode to update specs or code
/ace-spec-check --report           # Generate accountability report
/ace-spec-check --tests            # Check test-specification alignment
/ace-spec-check --with-steering     # Enhanced with steering context
```

## 🎯 Steering Context Integration

### Active Steering Files
ace-spec-check automatically loads relevant steering context for enhanced compliance checking:

```
🎯 Active Steering Context:
  • Quality standards and thresholds (conditional)
  • Specification compliance history (conditional)
  • Implementation learnings and patterns (conditional)
  Total: 3 steering files loaded

📊 Compliance Intelligence: Project-specific standards applied
```

### How Steering Enhances Compliance Checking

1. **Project-Specific Quality Thresholds**
   - Uses `quality-standards.md` for custom compliance levels
   - Applies domain-specific quality requirements
   - Enforces project-established testing standards

2. **Historical Compliance Context**
   - Leverages past compliance patterns and decisions
   - Applies lessons learned from previous drift resolutions
   - Uses proven approaches for specification management

3. **Implementation Pattern Awareness**
   - Recognizes established implementation patterns
   - Validates against documented architectural decisions
   - Applies context-specific validation rules

### Automatic Learning Capture
Compliance insights are captured back to steering:

```yaml
steering_updates:
  quality-standards.md:
    - Compliance threshold refinements
    - New validation patterns
    - Testing standard improvements
    
  implementation-learnings.md:
    - Specification drift patterns observed
    - Successful resolution approaches
    - Anti-patterns to avoid
    
  domain-expertise.md:
    - Business rule validation insights
    - User story interpretation refinements
    - Acceptance criteria evolution
```

## Command Processing

### Phase 1: Load Original Specifications
```yaml
specification_sources:
  genesis_specs: ".ace-flow/specs/genesis-requirements.json"
  user_stories: ".ace-flow/specs/user-stories.json"
  acceptance_criteria: ".ace-flow/specs/acceptance-criteria.json"
  technical_specs: ".ace-flow/specs/technical-architecture.json"
  implementation_plan: ".ace-flow/specs/implementation-roadmap.json"
```

### Phase 2: Analyze Current Implementation
```yaml
analysis_targets:
  code_structure:
    - "src/**/*.{js,ts,jsx,tsx}"
    - "amplify/**/*.{js,ts,json}"
    - "pages/**/*.{js,ts,jsx,tsx}"
    
  functionality_mapping:
    - API endpoints vs specified features
    - UI components vs user story requirements
    - Data models vs specification schemas
    - Authentication vs security requirements
    - Integration points vs external service specs
    
  test_coverage:
    - Unit tests vs acceptance criteria
    - Integration tests vs user story validation
    - E2E tests vs workflow specifications
```

### Phase 3: Compliance Scoring
```yaml
compliance_metrics:
  overall_score: "0-100% based on requirement fulfillment"
  
  category_scores:
    user_stories: "Percentage of user stories fully implemented"
    acceptance_criteria: "Acceptance criteria met vs total"
    technical_architecture: "Planned architecture vs actual structure"
    security_requirements: "Security specs implemented"
    performance_requirements: "Performance criteria met"
    
  deviation_types:
    missing_features: "Specified but not implemented"
    extra_features: "Implemented but not specified"
    modified_behavior: "Different from original specification"
    incomplete_implementation: "Partially implemented features"
```

## Output Formats

### Basic Compliance Report
```markdown
# 📊 Specification Compliance Report

**Generated**: 2025-01-22 14:30:00  
**Project**: fitness-tracking-app  
**Genesis Date**: 2025-01-15 09:15:00  

## Overall Compliance Score: 87% ⚠️

### Compliance by Category:
- **User Stories**: 92% ✅ (23/25 fully implemented)
- **Acceptance Criteria**: 85% ⚠️ (34/40 criteria met)
- **Technical Architecture**: 90% ✅ (API structure matches specs)
- **Security Requirements**: 95% ✅ (All auth features implemented)
- **Performance Requirements**: 70% ❌ (Missing real-time updates)

## Critical Deviations Found:
⚠️ **Missing Feature**: Real-time workout sharing (User Story #12)
⚠️ **Modified Behavior**: Login flow differs from specification
⚠️ **Extra Feature**: Added premium subscription (not in original specs)

## Recommendations:
1. Implement missing real-time features
2. Update specifications to reflect premium subscription addition
3. Align login flow with original UX specifications
```

### Detailed Deviation Analysis
```yaml
deviation_analysis:
  missing_features:
    - feature_id: "US-012"
      title: "Real-time workout sharing"
      priority: "high"
      acceptance_criteria: 
        - "Users can share workouts in real-time"
        - "Friends receive instant notifications"
        - "Workout data syncs across devices"
      current_status: "Not implemented"
      impact: "Core social functionality missing"
      
  modified_behaviors:
    - feature_id: "US-003" 
      title: "User authentication"
      original_spec: "Email/password with social login options"
      current_implementation: "Email/password only"
      deviation_reason: "Social login complexity"
      approval_status: "Pending review"
      
  extra_features:
    - feature_id: "EXTRA-001"
      title: "Premium subscription system"
      description: "Added Stripe-based subscription tiers"
      justification: "Business requirement post-genesis"
      spec_update_needed: true
```

### Test Alignment Report
```yaml
test_compliance:
  total_acceptance_criteria: 40
  criteria_with_tests: 32
  test_coverage_percentage: 80%
  
  missing_test_coverage:
    - criteria_id: "AC-012-01"
      description: "Real-time notifications work offline"
      user_story: "As a user, I want offline notification sync"
      test_needed: "Integration test for offline sync"
      
    - criteria_id: "AC-015-03"
      description: "Data export includes all workout metrics"
      user_story: "As a user, I want comprehensive data export"
      test_needed: "E2E test for export functionality"
      
  test_without_criteria:
    - test_file: "premium-subscription.test.js"
      description: "Tests added feature not in original specs"
      action_needed: "Update specifications or remove tests"
```

## Interactive Compliance Management

### Fix Drift Mode
```bash
$ /ace-spec-check --fix-drift

🔍 Found 3 specification deviations. Let's address them:

❌ MISSING FEATURE: Real-time workout sharing (User Story #12)
   Options:
   [1] Implement missing feature
   [2] Remove from specifications (mark as deferred)  
   [3] Update specifications with new timeline
   
   Choice: 1
   
✅ Added to implementation backlog with priority: HIGH

⚠️  EXTRA FEATURE: Premium subscription system
   This feature wasn't in original specifications.
   Options:
   [1] Update specifications to include this feature
   [2] Remove feature from codebase
   [3] Create separate specification document
   
   Choice: 1
   
✅ Updating specifications to include premium subscription...

🔄 MODIFIED BEHAVIOR: Login flow differs from specs
   Original spec: Email/password with social login
   Current code: Email/password only
   Options:
   [1] Implement social login as specified
   [2] Update specifications to match current implementation
   [3] Create hybrid approach
   
   Choice: 2
   
✅ Updated specifications to reflect email/password-only authentication
```

## Integration with ACE-Flow Commands

### Enhanced ace-status Integration
```bash
# Show compliance in status
$ /ace-status --compliance

📊 Project Status with Specification Compliance

## Implementation Progress: 78% ✅
- Backend: 85% complete
- Frontend: 70% complete  
- Testing: 65% complete

## Specification Compliance: 87% ⚠️
- 3 deviations requiring attention
- Last compliance check: 2 hours ago
- Trend: Improving (+5% since last week)

⚠️ Action Required:
- Review missing real-time features
- Update specs for premium subscription
- Align login implementation
```

### Smart Hook Integration
```yaml
smart_hooks:
  pre_deploy_compliance_check:
    trigger: "Before deployment"
    action: "Run ace-spec-check --quick"
    threshold: "85% minimum compliance"
    on_failure: "Block deployment with compliance report"
    
  post_feature_compliance:
    trigger: "After feature implementation"
    action: "Check if feature aligns with specifications"
    auto_update: "Suggest specification updates if needed"
    
  weekly_compliance_review:
    trigger: "Weekly schedule"  
    action: "Generate trending compliance report"
    stakeholder_notification: "Email compliance summary to team"
```

## Accountability Dashboard

### Compliance Trends
```yaml
compliance_history:
  - date: "2025-01-15"
    score: 100%
    note: "Initial genesis specifications"
    
  - date: "2025-01-18"
    score: 95%
    changes: "Added authentication implementation"
    deviations: 0
    
  - date: "2025-01-20"
    score: 89%
    changes: "Added premium features"
    deviations: 1
    
  - date: "2025-01-22"
    score: 87%
    changes: "Modified login flow, missing real-time features"
    deviations: 3
    
trend_analysis: "Compliance declining due to scope creep"
recommendation: "Schedule specification review session"
```

### Stakeholder Reporting
```markdown
# Weekly Specification Accountability Report

**Project**: fitness-tracking-app  
**Week Ending**: January 22, 2025  
**Team**: Frontend + Backend + Product

## Executive Summary
- **Overall Compliance**: 87% (Down 2% from last week)
- **New Features Added**: 2 (Premium subscription, Enhanced profiles)
- **Specification Updates Needed**: 3
- **Critical Missing Features**: 1 (Real-time sharing)

## Key Decisions Made:
✅ **Approved**: Premium subscription addition (business requirement)
⚠️ **Pending Review**: Login flow simplification 
❌ **Delayed**: Real-time features (technical complexity)

## Next Week Actions:
1. Update specifications for approved changes
2. Plan implementation of real-time features
3. Align team on authentication strategy

## Compliance Trend: 📉 Declining
**Cause**: Scope expansion without specification updates  
**Action**: Schedule specification review meeting
```

## File Structure for Specification Tracking

```
.ace-flow/specs/
├── genesis-requirements.json          # Original user requirements
├── user-stories.json                 # Structured user stories
├── acceptance-criteria.json           # Detailed acceptance criteria
├── technical-architecture.json       # Technical specifications
├── implementation-roadmap.json       # Development plan
├── compliance-history.json           # Historical compliance data
├── deviation-log.json                # Record of all specification changes
└── test-mapping.json                 # Test to requirement mapping
```

## Command Examples

### Quick Compliance Check
```bash
$ /ace-spec-check

📊 Quick Compliance Check: 87% ⚠️

Critical Issues:
- Missing real-time workout sharing feature
- Login flow deviates from specifications
- Premium subscription not documented in specs

Run '/ace-spec-check --detailed' for full analysis
```

### Generate Accountability Report
```bash
$ /ace-spec-check --report

✅ Generated compliance report: ./compliance-report-20250122.md
📧 Email sent to stakeholders
📊 Updated compliance dashboard
🔄 Scheduled next review for Jan 29, 2025
```

### Test-Specification Alignment
```bash
$ /ace-spec-check --tests

🧪 Test-Specification Alignment: 80% ⚠️

Missing Tests:
- Real-time sync functionality (3 acceptance criteria)
- Offline data handling (2 acceptance criteria)
- Export functionality edge cases (1 acceptance criteria)

Extra Tests:
- Premium subscription tests (feature not in original specs)

Recommendation: Add 6 missing tests, update specs for premium features
```

---

## Integration Notes

This command works seamlessly with:
- **ace-genesis**: Loads specifications from genesis phase
- **ace-status**: Shows compliance in project status
- **ace-validate**: Includes compliance in pre-deployment checks
- **ace-implement**: Validates implementation against specs
- **Smart hooks**: Automated compliance monitoring

The ace-spec-check command transforms ACE-Flow from having "good specifications" to having "true Kiro-style accountability" where specifications and implementation remain synchronized throughout the development lifecycle.