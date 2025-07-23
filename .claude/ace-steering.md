# /ace-steering - Intelligent Implementation Guidance

## Overview
The `/ace-steering` command provides intelligent, context-aware guidance during implementation phases. It analyzes your project state, suggests next steps, identifies potential issues, and steers development toward optimal outcomes based on ACE-Flow best practices.

## Usage
```bash
# Get current guidance and next steps
/ace-steering

# Get guidance for specific phase
/ace-steering --phase=genesis
/ace-steering --phase=research
/ace-steering --phase=implementation

# Get guidance for specific domain
/ace-steering --domain=auth
/ace-steering --domain=data-modeling
/ace-steering --domain=deployment

# Interactive steering mode
/ace-steering --interactive

# Generate steering report
/ace-steering --report --format=markdown
```

## Steering Intelligence

### Context-Aware Analysis
```
🎯 ACE-Steering Analysis
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Project: recipe-sharing-app
Pattern: social_platform
Phase: Implementation (67% complete)
Quality Score: 8.2/10

Current Focus: Real-time messaging system
Next Recommended: User notification system
Risk Level: Medium (infrastructure complexity)

💡 Smart Recommendations:
1. Prioritize WebSocket optimization before scaling
2. Consider implementing message queuing (SQS)
3. Add connection pooling for better performance
4. Plan for offline message synchronization
```

### Phase-Specific Guidance

#### Genesis Phase Steering
```
🌟 Genesis Phase Guidance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Current Status: Requirements gathering complete
Architecture: 73% defined
Specifications: In progress

🎯 Next Steps:
1. Finalize data model relationships
2. Define API endpoints and operations
3. Create component hierarchy diagram
4. Validate technical feasibility

⚠️ Potential Issues:
- Real-time features may require additional AWS services
- Complex social features need careful auth planning
- Image storage needs CDN consideration

🔄 Recommended Actions:
- Run `/ace-research real-time social_platform`
- Validate auth requirements with `/ace-validate --check=auth`
- Consider scalability implications early
```

#### Research Phase Steering
```
🔬 Research Phase Guidance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Research Depth: 85% (42 pages analyzed)
Knowledge Gaps: 2 critical, 5 minor
Pattern Confidence: High

📚 Research Summary:
✅ Authentication patterns well-researched
✅ Real-time messaging patterns found
⚠️  File upload optimization needs more research
❌ Push notification setup incomplete

🎯 Recommended Research:
1. `/ace-research file-upload optimization`
2. `/ace-research push-notifications mobile`
3. Deep dive into WebSocket scaling patterns

📈 Implementation Readiness: 78%
🚀 Ready to proceed with implementation
```

#### Implementation Phase Steering
```
🚀 Implementation Phase Guidance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Infrastructure: 92% deployed
Backend: 78% complete
Frontend: 65% complete
Testing: 45% complete

🎯 Current Priority Queue:
1. Complete user profile management
2. Implement recipe sharing workflow
3. Add image upload functionality
4. Build notification system
5. Create admin dashboard

⚠️ Blockers Detected:
- S3 bucket CORS not configured (affects image upload)
- WebSocket connection limits need adjustment
- Database indexes missing for search queries

🔧 Quick Fixes Available:
- Run `/ace-fix cors-setup`
- Execute `/ace-validate --check=performance`
- Add database indexes with provided script
```

## Smart Hook Integration

### Automated Steering Triggers
```yaml
# ACE-Flow automatically triggers steering at key moments
triggers:
  - event: "schema_change"
    action: "analyze_impact"
    guidance: "data_modeling"
  
  - event: "deployment_error"
    action: "suggest_fixes"
    guidance: "infrastructure"
  
  - event: "test_failure"
    action: "debug_guidance"
    guidance: "quality_assurance"
  
  - event: "performance_issue"
    action: "optimization_tips"
    guidance: "performance"
```

### Proactive Guidance
```
🤖 Proactive Steering Alert
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Pattern: High database query count detected
Impact: Performance degradation likely
Confidence: 85%

💡 Steering Recommendation:
Your app is making 47 database queries per page load.
Consider implementing:
1. GraphQL query optimization
2. Data batching strategies
3. Cached query results

🔧 Auto-fix Available:
Run `/ace-optimize --queries` to implement batching

📊 Expected Improvement:
- 70% reduction in query count
- 45% faster page load times
- Better user experience
```

## Examples

### Basic Project Steering
```bash
# Get general guidance for current project
/ace-steering

🎯 ACE-Steering Analysis
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Project: task-manager
Pattern: simple_crud
Phase: Implementation
Progress: 34%

Next Actions:
1. Complete task creation form validation
2. Implement task status update functionality  
3. Add user authentication flow
4. Create task filtering system

Estimated Time to MVP: 2.5 hours
```

### Domain-Specific Steering
```bash
# Get authentication-specific guidance
/ace-steering --domain=auth

🔐 Authentication Steering
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Current Status: Basic login implemented
Security Level: 6/10

Recommendations:
1. Enable MFA for production users
2. Add password strength requirements
3. Implement session timeout
4. Add email verification flow

Security Gaps:
- No rate limiting on login attempts
- Missing CSRF protection
- Session tokens not properly secured

Quick Fixes:
- Run `/ace-validate --check=security`
- Apply suggested auth improvements
- Test with `/ace-test auth-flow`
```

### Interactive Steering Mode
```bash
# Start interactive steering session
/ace-steering --interactive

🎯 Interactive ACE-Steering Session
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

I notice you're building a social platform. Let me guide you through the next steps:

Current Progress: Real-time messaging (78% complete)

Question 1: Are you planning to support group chats?
[Y/n]: Y

Great! Group chats will require:
- Message broadcasting optimization
- Participant management system
- Typing indicators for multiple users

Question 2: What's your target concurrent user count?
[100/1000/10000]: 1000

For 1000 concurrent users, I recommend:
- WebSocket connection pooling
- Message queue implementation (SQS)
- Horizontal scaling preparation

Shall I add these optimizations to your implementation plan?
[Y/n]: Y

✅ Updated implementation plan with:
   - WebSocket optimization tasks
   - SQS integration steps
   - Scaling preparation checklist

Next: Implement user presence system
Command: `/ace-implement user-presence`
```

### Phase-Specific Examples
```bash
# Genesis phase steering
/ace-steering --phase=genesis

🌟 Genesis Phase Steering
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Project Concept: E-commerce marketplace
Pattern Match: 85% e_commerce

Specification Completeness:
- User Stories: 67% complete
- Data Models: 23% complete  
- UI Wireframes: 12% complete
- Technical Requirements: 45% complete

Priority Actions:
1. Complete data model definitions
2. Define payment integration requirements
3. Specify multi-vendor workflow
4. Plan inventory management system

Blockers:
- Payment provider not selected
- Shipping calculation method undefined
- Multi-vendor commission structure unclear

Recommendations:
- Research payment options: `/ace-research payments e_commerce`
- Define vendor onboarding flow
- Specify product catalog structure
```

### Crisis Steering Examples
```bash
# When things go wrong
/ace-steering --crisis

🚨 Crisis Mode Steering
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Status: CRITICAL - Deployment failed

Issue: CloudFormation stack rollback
Impact: Production system offline
Duration: 23 minutes

Immediate Actions:
1. Execute emergency rollback: `/ace-rollback --emergency`
2. Restore from last known good state
3. Implement hotfix deployment

Root Cause Analysis:
- Schema migration caused data conflicts
- Insufficient testing of breaking changes
- Missing rollback strategy

Prevention Plan:
- Implement blue-green deployments
- Add schema migration testing
- Create rollback procedures document

Recovery ETA: 8 minutes (with rollback)
Alternative: 45 minutes (full redeploy)

Recommendation: Execute rollback immediately
Command: `/ace-rollback --to="pre-schema-change"`
```

### Performance Steering
```bash
# Performance-focused guidance
/ace-steering --domain=performance

⚡ Performance Steering
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Current Performance Score: 6.2/10

Detected Issues:
- API response time: 2.3s (target: <500ms)
- Database queries: 23 per request (excessive)
- Bundle size: 2.1MB (large for mobile)
- Image optimization: Not implemented

Optimization Plan:
1. Implement GraphQL query batching
2. Add database indexes for common queries
3. Enable image compression and WebP format
4. Implement code splitting for bundles

Expected Improvements:
- 65% faster API responses
- 40% smaller bundle size
- Better mobile performance
- Improved SEO scores

Quick Wins:
- Enable Amplify caching: 15 minutes
- Optimize images: 30 minutes
- Add database indexes: 20 minutes

Total implementation time: ~2 hours
Performance gain: +3.2 points (9.4/10 target)
```

### Integration Examples
```bash
# Steering for third-party integrations
/ace-steering --domain=integrations

🔌 Integration Steering
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Current Integrations: 3 active, 2 planned

Active:
✅ Stripe payments (healthy)
✅ SendGrid emails (healthy)  
✅ S3 file storage (healthy)

Planned:
⏳ Google Analytics (research needed)
⏳ Social login (OAuth setup required)

Recommendations:
1. Prioritize social login for user acquisition
2. Implement analytics after core features
3. Consider integration health monitoring

Integration Risks:
- API rate limits not monitored
- No fallback for failed services
- Integration testing incomplete

Suggested Actions:
- Add integration monitoring
- Implement circuit breaker pattern
- Create integration test suite

Next: `/ace-research oauth-setup social-login`
```

### Multi-Project Steering
```bash
# Steering across multiple projects
/ace-steering --scope=organization

🏢 Organization-Wide Steering
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Projects: 5 active, 2 completed

Project Health:
✅ task-manager (production, stable)
✅ blog-platform (production, stable)
🟡 marketplace (development, needs attention)
🟡 analytics-dashboard (development, behind schedule)
🔴 mobile-app (blocked, critical issues)

Organization Priorities:
1. Unblock mobile-app project (OAuth issues)  
2. Accelerate analytics-dashboard delivery
3. Address marketplace scalability concerns

Resource Allocation:
- mobile-app: Needs senior developer
- analytics-dashboard: Needs designer review
- marketplace: Needs infrastructure scaling

Strategic Recommendations:
- Standardize auth across all projects
- Implement shared component library
- Create common deployment pipeline
- Establish code quality standards

Cost Optimization:
- Consolidate AWS resources: Save $340/month
- Optimize database usage: Save $120/month
- Review unused services: Potential $200/month savings
```

## Steering Algorithms

### Decision Tree Logic
```typescript
// Simplified steering decision process
interface SteeringDecision {
  analyzeContext(): ProjectContext;
  identifyPriorities(): Priority[];
  suggestActions(): Action[];
  assessRisks(): Risk[];
  generateGuidance(): Guidance;
}

class ACESteering implements SteeringDecision {
  analyzeContext() {
    return {
      phase: this.detectCurrentPhase(),
      pattern: this.identifyArchitecturePattern(),
      progress: this.calculateProgress(),
      blockers: this.findBlockers(),
      quality: this.assessQuality()
    };
  }
  
  suggestActions() {
    const context = this.analyzeContext();
    const priorities = this.identifyPriorities();
    
    return this.generateActionPlan(context, priorities);
  }
}
```

### Learning Integration
```
🧠 Steering Learning System
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Learning from:
- 1,247 successful implementations
- 89 common failure patterns  
- 567 optimization outcomes
- 234 performance improvements

Your Project Similarity:
- 87% match to successful e-commerce projects
- Similar architecture to 23 high-performing apps
- Common patterns with 156 completed projects

Confidence Level: 91%
Personalized Recommendations: Available
Success Probability: 94% (with guidance)
```

## Best Practices

### When to Use Steering
1. **Feeling Stuck**: Not sure what to do next
2. **Quality Concerns**: Worried about implementation quality
3. **Performance Issues**: App running slowly
4. **Architecture Decisions**: Choosing between approaches
5. **Crisis Situations**: When things go wrong
6. **Progress Reviews**: Regular check-ins during development

### Steering Workflow Integration
```bash
# Recommended workflow with steering
/ace-genesis "your app idea"        # Start project
/ace-steering --phase=genesis       # Get genesis guidance
/ace-research [domain] [pattern]    # Research based on steering
/ace-steering --phase=research      # Validate research completeness  
/ace-implement project-name         # Begin implementation
/ace-steering                       # Regular guidance during implementation
/ace-steering --domain=performance  # Optimize when needed
/ace-validate                       # Pre-deployment validation
```

### Steering Best Practices
1. **Regular Check-ins**: Run steering every few hours during active development
2. **Crisis Mode**: Use `--crisis` flag when encountering serious issues
3. **Domain Focus**: Use `--domain` for specific area guidance
4. **Interactive Mode**: Use `--interactive` for complex decisions
5. **Learning Mode**: Review steering reports to improve development practices

---

*ACE-Steering: Your intelligent development companion for confident, efficient implementation! 🎯*