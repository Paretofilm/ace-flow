# Claude Opus Quality Review Prompt for ACE-Flow

**Comprehensive quality assessment prompt for Claude Opus to thoroughly review the ACE-Flow system and ensure all components work as expected.**

---

## 🎯 **Review Context**

You are conducting a comprehensive quality review of **ACE-Flow** - an intelligent workflow system for AWS Amplify Gen 2 development that provides automated project creation, research-driven implementation, and self-learning capabilities.

### **System Purpose**
ACE-Flow eliminates the common problem of AI generating outdated Amplify Gen 1 code by maintaining a curated local documentation library and using research-driven development patterns. It provides 5 core commands for complete project lifecycle management.

### **Critical Success Criteria**
- **100% Amplify Gen 2 compliance** - No Gen 1 patterns anywhere in the system
- **Documentation accuracy** - All examples use current framework versions
- **Command consistency** - All ACE-Flow commands work as documented
- **Production readiness** - All patterns and integrations are production-ready
- **User experience excellence** - Clear, tested end-to-end workflows

## 📚 **System Architecture Overview**

### **Core Components**
1. **Local Documentation Library** (`docs/` directory)
   - AWS Amplify Gen 2 documentation (getting-started, data-modeling, authentication)
   - Next.js 14+ App Router documentation (app-router, data-fetching)
   - Architecture patterns (social-platform, e-commerce, content-management, dashboard-analytics, simple-crud)
   - Integration guides (Stripe, SendGrid, etc.)

2. **ACE-Flow Commands** (`.claude/` directory)
   - `/ace-genesis` - Intelligent project creation
   - `/ace-research` - Documentation research with local docs integration
   - `/ace-implement` - Infrastructure-aware implementation
   - `/ace-adopt` - Safe migration of existing projects
   - `/ace-learn` - Self-learning from implementations
   - `/update-docs` - Documentation maintenance
   - `/ace-review` - Quality assurance (this command)

3. **Supporting Systems**
   - Documentation versioning and tracking
   - Quality standards and validation
   - Source attribution and legal compliance

## 🔍 **Detailed Review Areas**

### **1. CRITICAL: Amplify Gen 1 vs Gen 2 Compliance**

**Primary Objective**: Ensure 100% of code examples use current Amplify Gen 2 patterns.

#### **What to Look For (MUST FIX if found):**

**❌ Amplify Gen 1 Patterns (OUTDATED - should NOT appear anywhere):**
```typescript
// WRONG - Gen 1 patterns
import { API, graphqlOperation } from 'aws-amplify';
import { createTodo } from './graphql/mutations';

const newTodo = await API.graphql(graphqlOperation(createTodo, { input: todoData }));

// WRONG - Old auth patterns
import { Auth } from 'aws-amplify';
await Auth.signIn(username, password);

// WRONG - Old storage patterns  
import { Storage } from 'aws-amplify';
await Storage.put('key', file);
```

**✅ Amplify Gen 2 Patterns (CORRECT - should be used everywhere):**
```typescript
// CORRECT - Gen 2 patterns
import { generateClient } from 'aws-amplify/data';
import type { Schema } from '@/amplify/data/resource';

const client = generateClient<Schema>();
const newTodo = await client.models.Todo.create(todoData);

// CORRECT - New auth patterns
import { signIn } from 'aws-amplify/auth';
await signIn({ username, password });

// CORRECT - New storage patterns
import { uploadData } from 'aws-amplify/storage';
await uploadData({ key: 'key', data: file });
```

#### **Specific Files to Check:**
- `docs/frameworks/amplify-gen2/*.md` - All Amplify examples
- `docs/patterns/*.md` - All architecture pattern implementations
- `docs/integrations/*.md` - All integration code examples
- `.claude/*.md` - All command documentation examples

#### **Validation Checklist:**
- [ ] All imports use specific paths (`aws-amplify/data`, `aws-amplify/auth`)
- [ ] All data operations use `client.models.Model.create/update/delete()`
- [ ] All auth operations use individual function imports
- [ ] All storage operations use new `uploadData`/`downloadData` patterns
- [ ] No `graphqlOperation` or `API.graphql` usage anywhere
- [ ] All TypeScript types properly reference `Schema` types

### **2. Documentation Accuracy and Completeness**

#### **Framework Documentation Review:**
**Location**: `docs/frameworks/`

**Check Each File For:**
- **Version alignment**: Framework versions match latest stable releases
- **Import accuracy**: All import statements use correct module paths  
- **TypeScript correctness**: Proper type definitions and interfaces
- **Code syntax**: All examples are syntactically correct
- **Best practices**: Security, performance, and maintainability guidance

**Specific Files to Review:**
- `amplify-gen2/getting-started.md` - Basic setup and project initialization
- `amplify-gen2/data-modeling.md` - GraphQL schema and data operations
- `amplify-gen2/authentication.md` - User authentication and authorization
- `nextjs/app-router.md` - Next.js 14+ App Router patterns
- `nextjs/data-fetching.md` - Server/client data fetching strategies

#### **Architecture Pattern Review:**
**Location**: `docs/patterns/`

**For Each Pattern, Verify:**
- **Implementation completeness**: Full data models, UI components, API functions
- **Real-world applicability**: Patterns work in actual development scenarios
- **Security implementation**: Proper authorization rules and data protection
- **Performance optimization**: Efficient queries, caching, real-time features
- **Integration points**: Correct third-party service configurations

**Critical Patterns to Review:**
- `social-platform.md` - User interactions, real-time features, media handling
- `simple-crud.md` - Basic data management patterns
- Additional patterns (e-commerce, content-management, dashboard-analytics) if present

#### **Integration Guide Review:**
**Location**: `docs/integrations/`

**For Each Integration, Validate:**
- **API compatibility**: Services use current API versions
- **Setup completeness**: All environment variables and configuration documented
- **Error handling**: Comprehensive error management and fallback strategies
- **Security implementation**: API keys, webhooks, data protection best practices
- **Testing guidance**: Clear validation and testing procedures

**Key Integrations to Review:**
- `stripe.md` - Payment processing, webhooks, subscription management
- `sendgrid.md` - Email delivery, templates, delivery tracking
- Additional integrations if present

### **3. Command System Validation**

#### **ACE-Flow Commands Review:**
**Location**: `.claude/`

**For Each Command File, Check:**
- **Documentation completeness**: Full usage examples and explanations
- **Syntax consistency**: Uniform command patterns across all docs
- **Keyword accuracy**: All referenced patterns and features properly defined
- **Example validity**: All usage examples work as documented
- **Integration logic**: Commands properly reference local documentation

**Commands to Review:**
- `ace-genesis.md` - Project creation workflow
- `ace-research.md` - Local docs integration and gap analysis
- `ace-implement.md` - Context-aware implementation
- `ace-adopt.md` - Existing project migration
- `ace-learn.md` - Self-learning capabilities
- `update-docs.md` - Documentation maintenance
- `ace-review.md` - Quality assurance (this system)

#### **Command Consistency Checks:**
- [ ] All commands use consistent syntax patterns
- [ ] App name detection/omission works as described
- [ ] Keyword definitions match usage across all files
- [ ] Local documentation integration properly explained
- [ ] Error handling and help systems documented

### **4. User Experience Flow Validation**

#### **End-to-End Workflow Review:**
**Test These User Journeys:**

1. **New User Journey:**
   - Initial app creation with `/ace-genesis`
   - Feature research with `/ace-research`
   - Implementation with `/ace-implement`
   - Learning capture with `/ace-learn`

2. **Feature Addition Journey:**
   - Adding features to existing app
   - Using local docs for foundation
   - Extending architecture patterns
   - Integration with third-party services

3. **Documentation Maintenance:**
   - Running `/update-docs` for freshness
   - Quality validation with `/ace-review`
   - Continuous improvement workflow

#### **UX Validation Points:**
- [ ] Clear progression from one step to the next
- [ ] Consistent terminology and concepts
- [ ] Appropriate complexity levels for different user types
- [ ] Error recovery and troubleshooting guidance
- [ ] Success indicators and completion criteria

### **5. Technical Infrastructure Validation**

#### **Documentation Management System:**
**Location**: `docs/meta/`, `scripts/`

**Check:**
- **Version tracking**: `doc-versions.md` properly tracks framework versions
- **Update history**: `update-history.md` maintains comprehensive changelog
- **Quality standards**: `quality-standards.md` defines clear criteria
- **Source tracking**: `source-tracking.md` provides proper attribution
- **Automation scripts**: `update-docs.sh` implements described functionality

#### **Coverage and Quality Metrics:**
**Review**: `docs/meta/coverage-matrix.md`

**Validate:**
- [ ] Accurate coverage percentages for each area
- [ ] Realistic timelines and effort estimates
- [ ] Proper priority classification
- [ ] Quality score calculations make sense
- [ ] Gap analysis identifies real issues

## 📋 **Comprehensive Review Checklist**

### **Critical Issues (Must Fix)**
- [ ] No Amplify Gen 1 patterns anywhere in the system
- [ ] All code examples use current framework versions
- [ ] All imports use correct Amplify Gen 2 module paths
- [ ] All TypeScript types properly reference Schema definitions
- [ ] No broken internal or external links

### **High Priority Issues**
- [ ] All architecture patterns are complete and production-ready
- [ ] All integration guides use current service APIs
- [ ] All ACE-Flow commands properly documented
- [ ] Local documentation integration works as described
- [ ] User experience flows are clear and tested

### **Medium Priority Issues**
- [ ] Documentation organization is logical and consistent
- [ ] Code examples include proper error handling
- [ ] Security best practices are consistently applied
- [ ] Performance considerations are documented
- [ ] Testing strategies are provided

### **Enhancement Opportunities**
- [ ] Additional examples for complex scenarios
- [ ] More detailed troubleshooting guides
- [ ] Enhanced integration with development tools
- [ ] Improved automation and validation systems

## 📊 **Expected Deliverables**

### **1. Executive Summary**
- Overall quality assessment (1-10 scale)
- Critical issues found (must be fixed immediately)
- High priority recommendations
- System readiness for production use

### **2. Detailed Findings Report**
**For Each Review Area:**
- Specific issues found with file locations and line numbers
- Severity classification (Critical/High/Medium/Low)
- Recommended fixes with implementation guidance
- Examples of correct patterns to replace incorrect ones

### **3. Amplify Gen 2 Compliance Report**
- Complete audit of Gen 1 vs Gen 2 patterns
- Specific locations of any outdated code
- Replacement code examples for any issues found
- Validation that all examples use current best practices

### **4. Action Plan**
- Prioritized list of improvements
- Estimated effort for each fix
- Suggested implementation order
- Success criteria for validation

### **5. Quality Score Breakdown**
```yaml
Quality_Assessment:
  overall_score: X/10
  
  category_scores:
    amplify_gen2_compliance: X/10
    documentation_accuracy: X/10  
    command_system: X/10
    architecture_patterns: X/10
    integrations: X/10
    user_experience: X/10
    
  critical_issues: X
  high_priority_issues: X
  medium_priority_issues: X
  
  production_readiness: "Ready/Not Ready"
  recommendation: "Ship/Fix Critical Issues/Major Revision Needed"
```

## 🎯 **Success Criteria**

**System Passes Review If:**
- ✅ Zero Amplify Gen 1 patterns found anywhere
- ✅ All code examples syntactically correct and current
- ✅ All ACE-Flow commands properly documented and consistent
- ✅ Architecture patterns complete and production-ready
- ✅ Integration guides use current APIs and best practices
- ✅ User experience flows clear and well-tested
- ✅ Overall quality score ≥ 9/10

**System Requires Major Revision If:**
- ❌ Multiple Amplify Gen 1 patterns found
- ❌ Broken or outdated code examples
- ❌ Incomplete or inconsistent command documentation
- ❌ Missing critical architecture pattern components
- ❌ Outdated integration guides
- ❌ Unclear or untested user workflows
- ❌ Overall quality score < 7/10

---

**Review Conducted By**: Claude Opus  
**Review Date**: [Current Date]  
**ACE-Flow Version**: 1.0  
**Review Scope**: Complete System Assessment
## 📊 Current System State (Sun Jul 20 18:54:00 CEST 2025)

### Repository Structure
```
SETUP.md
QUICKSTART.md
workflows/claude-md-enhancement-template.md
workflows/WORKFLOW-ENHANCEMENT.md
workflows/ace-research.md
.claude/ace-review.md
.claude/ace-implement.md
.claude/update-docs.md
.claude/ace-adopt.md
.claude/ace-learn.md
.claude/ace-genesis.md
.claude/ace-setup-pipeline.md
.claude/ace-research.md
docs/patterns/social-platform.md
docs/patterns/README.md
docs/patterns/simple-crud.md
docs/meta/source-tracking.md
docs/meta/quality-standards.md
docs/meta/update-history.md
docs/meta/README.md
...
```

### Documentation Files Count
- Framework docs:        8
- Pattern docs:        3
- Integration docs:        3
- Command docs:        8

### Recent Changes
53923d4 fix: Update SETUP.md to use npm create amplify@latest
569f7c9 feat: Initial ACE-Flow release v1.0.0

---
**Review Prompt Generated**: Sun Jul 20 18:54:00 CEST 2025
**System Version**: 53923d4
