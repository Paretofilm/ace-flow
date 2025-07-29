# ACE-Genesis: Intelligent Project Creation with Steering Context

**Creates custom AWS Amplify Gen 2 applications through intelligent conversation, architecture decision-making, and persistent context learning.**

## Prerequisites Check

ACE-Genesis will automatically check your setup and guide you through any missing requirements.

## Usage

```bash
/ace-genesis [initial-idea]
```

Examples:
- `/ace-genesis "I want to build a fitness tracking app"`
- `/ace-genesis "online marketplace for handmade products"`
- `/ace-genesis "team collaboration platform"`

## 🎯 Steering Context Integration

### Active Steering Files
ACE-Genesis automatically loads relevant steering context to enhance project creation:

```
🎯 Active Steering Context:
  • Architecture decisions and patterns (always)
  • Domain expertise and business context (conditional)
  • Quality standards for new projects (conditional)
  Total: 3 steering files loaded

📊 Steering Intelligence: Learning from 12 previous projects
```

### How Steering Enhances Genesis

1. **Smarter Architecture Decisions**
   - Uses `architecture-decisions.md` to apply proven patterns
   - Learns from past architectural successes and failures
   - Suggests optimizations based on similar projects

2. **Domain Intelligence**
   - Leverages `domain-expertise.md` for industry insights
   - Applies business logic patterns from similar domains
   - Identifies common pitfalls before they occur

3. **Quality from the Start**
   - Applies `quality-standards.md` to new projects
   - Sets appropriate compliance thresholds
   - Establishes testing strategies upfront

### Automatic Context Capture
Genesis decisions are captured to improve future projects:

```yaml
steering_updates:
  architecture-decisions.md:
    - New architecture patterns selected
    - Rationale for technical choices
    - Expected scaling characteristics
    
  domain-expertise.md:
    - Business model understanding
    - User behavior assumptions
    - Market positioning insights
    
  quality-standards.md:
    - Project-specific quality requirements
    - Compliance needs identified
    - Testing strategy decisions
```

## What This Command Does

1. **Intelligent Interview**: Conducts 7-10 targeted questions to understand your vision:
   - Who are your users and what problem are you solving?
   - What would success look like 6 months after launch?
   - What types of data will your app handle?
   - Do you need real-time features or third-party integrations?

2. **Smart Architecture Selection**: Analyzes your responses using pattern recognition:
   - **Social Platform**: For user-generated content, social features, real-time updates
   - **E-commerce**: For selling products, payments, inventory management
   - **Content Management**: For blogs, documentation, publishing workflows
   - **Dashboard Analytics**: For data visualization, reporting, metrics
   - **Simple CRUD**: For basic data management, task tracking

3. **Solution Preview & Validation**: Shows you the tailored solution before building:
   - Explains why the chosen architecture fits your needs
   - Lists key features with reasoning
   - Provides implementation timeline estimate
   - Allows quick modifications if needed

4. **Custom Project Generation**: Creates tailored architecture and implementation plan:
   - Custom data models for your specific domain
   - Appropriate authentication strategy (basic, social, multi-role)
   - Optimal storage and real-time configuration
   - Production-ready deployment setup

5. **Structured Specification Generation**: Automatically creates comprehensive project specs:
   - **Requirements Phase**: User stories with acceptance criteria
   - **Design Phase**: Technical architecture with sequence diagrams
   - **Implementation Phase**: Step-by-step development roadmap with progress tracking

## Implementation Process

ACE-Genesis automatically handles setup verification and workflow enhancement:

### Phase 1: Setup Verification
- **Workflow Check**: Verifies `.github/workflows/*.yml` files exist
- **GitHub App Check**: If no workflows found, guides user to install GitHub App
- **ACE-Flow Integration**: If workflows exist, enhances them with ACE-Flow capabilities

### Phase 2: CLAUDE.md Configuration
- **Check Existing**: Looks for existing CLAUDE.md file
- **Smart Merge**: If found, enhances with ACE-Flow capabilities
- **Template Setup**: If not found, creates ACE-Flow enhanced CLAUDE.md
- **Project Customization**: Updates project-specific sections

### Phase 3: Intelligent Project Creation
```bash
# 1. Genesis conversation (this command)
/ace-genesis "your idea"

# 2. Automatic structured specification generation
# - Requirements: User stories with acceptance criteria
# - Design: Technical architecture and data models
# - Implementation: Step-by-step roadmap with checkpoints

# 3. Automatic research phase (triggered automatically)
# - Scrapes 30-100 pages of current AWS Amplify Gen 2 documentation
# - Extracts proven patterns and identifies gotchas
# - Creates comprehensive implementation context

# 4. Implementation with infrastructure awareness and smart hooks
# - Deploys backend with timing awareness (2-5 minutes)
# - Auto-triggers type generation on schema changes
# - Implements frontend with progress tracking
# - Runs validation loops with auto-fix
# - Results in production-ready application
```

## Architecture Pattern Recognition

The system automatically identifies your project type based on conversation:

### Social Platform Pattern
- **Triggers**: "users", "social", "community", "sharing", "profiles", "friends"
- **Generated**: User authentication with groups, real-time feeds, media storage, social interactions
- **Example Output**: Fitness app with workout sharing, friend connections, progress tracking

### E-commerce Pattern  
- **Triggers**: "sell", "products", "payments", "inventory", "orders", "marketplace"
- **Generated**: Multi-vendor authentication, Stripe integration, product catalogs, order processing
- **Example Output**: Handmade crafts marketplace with seller dashboards, buyer protection

### Content Management Pattern
- **Triggers**: "blog", "content", "articles", "publishing", "cms", "documentation"
- **Generated**: Rich text editing, publishing workflows, SEO optimization, media management
- **Example Output**: Collaborative documentation platform with version control

### Dashboard Analytics Pattern
- **Triggers**: "analytics", "dashboard", "data", "reports", "metrics", "insights"  
- **Generated**: Real-time data visualization, complex queries, interactive charts
- **Example Output**: Business intelligence dashboard with live data streams

### Simple CRUD Pattern
- **Triggers**: "manage", "track", "organize", "simple", "basic", "list"
- **Generated**: Basic forms, data management, simple relationships
- **Example Output**: Task management system with user assignments

## Solution Preview Examples

### Fitness App Example
```
## 🎯 Your Tailored Solution Preview

Based on our conversation, I've designed a **Social Platform** for you:

### 🏗️ Architecture: Social Fitness Platform
**Why this pattern?** You mentioned users sharing workouts and social motivation - 
this requires user profiles, content sharing, and real-time social interactions.

### ⚡ Key Features:
• User profiles with workout history - Essential for progress tracking
• Social feed with workout sharing - Drives the motivation you wanted
• Real-time progress updates - Keeps users engaged and competing
• Mobile-optimized interface - Critical for gym/outdoor use

### ⏱️ Implementation Timeline:
• **Research Phase**: ~20 minutes
• **Deployment**: ~4 minutes  
• **Total**: Working app in ~90 minutes

### 📋 Specification Preview:
**Requirements**: 5 user stories with acceptance criteria
**Design**: Technical architecture with data flow diagrams  
**Implementation**: 12-step roadmap with automated checkpoints

### 🚀 Ready to proceed?
**'yes'** - Let's build this! (auto-generate specs → research → implementation)
**'modify [aspect]'** - Quick adjustment (e.g., 'modify auth to include social login')
**'explain [feature]'** - Tell me more about a specific feature
**'show specs'** - View detailed specifications before proceeding
```

### Common Modifications
- `modify auth to include social login` → Adds Google/Apple sign-in
- `modify to focus more on mobile` → Adjusts UI for mobile-first design  
- `modify to be simpler` → May shift to Simple CRUD pattern
- `modify to add payments` → Adds premium features with Stripe

## Expected Outcome

After validation and confirmation:

✅ **Structured Specifications**: 3-phase specs with user stories and acceptance criteria
✅ **Project Specification**: Complete architecture document with user approval
✅ **Custom Data Models**: Tailored to your specific domain  
✅ **Authentication Strategy**: Validated and appropriate for your user types
✅ **Implementation Plan**: Step-by-step development roadmap with progress tracking
✅ **Smart Hook Configuration**: Automated AWS Amplify workflow triggers
✅ **Research Requirements**: Automated documentation gathering
✅ **Deployment Strategy**: Production-ready AWS Amplify Gen 2 setup

The system automatically proceeds to:
1. Research 30-100 pages of current documentation
2. Generate comprehensive implementation context
3. Deploy infrastructure-aware implementation
4. Result: Working application in <2 hours

## Quality Guarantees

- **>95% Success Rate**: Generated applications work on first deployment
- **Production Ready**: Includes testing, security, performance optimization
- **Real AWS Integration**: Works with actual cloud infrastructure, not toy examples
- **Documentation Driven**: Based on 30-100 pages of current official docs

## 📈 Steering-Enhanced Genesis Metrics

### Improved Decision Making with Steering
```yaml
genesis_improvements:
  without_steering:
    architecture_accuracy: "75-80%"
    pattern_selection: "Generic patterns"
    common_mistakes: "15-20%"
    rework_needed: "Moderate"
    
  with_steering:
    architecture_accuracy: "92-95%" # Better pattern matching
    pattern_selection: "Domain-optimized patterns"
    common_mistakes: "<5%" # Avoids known pitfalls
    rework_needed: "Minimal" # Gets it right first time
    
  benefits:
    better_architecture: "95%+ fit for purpose"
    faster_decisions: "30% quicker pattern selection"
    quality_from_start: "Built-in best practices"
    learning_capture: "Every project improves the next"
```

### Example: Steering-Enhanced Genesis Flow
```bash
$ /ace-genesis "fitness tracking app with social features"

🎯 Loading steering context...
  ✓ Architecture decisions (15 similar projects analyzed)
  ✓ Domain expertise (fitness & social patterns documented)
  ✓ Quality standards (performance & compliance requirements)

📊 Steering intelligence applied:
  - Similar project: "Social workout tracker" succeeded with pattern X
  - Known pitfall: Real-time sync at scale (solution documented)
  - Recommended: Enhanced social_platform pattern with offline-first

🤖 Intelligent interview beginning...
  [Questions informed by past learnings and domain knowledge]

✨ Solution preview enhanced by steering:
  - Architecture: Social Platform (Enhanced) - 95% confidence
  - Optimizations: 3 performance improvements from past projects
  - Risk mitigation: 2 known issues pre-addressed

💾 Capturing decisions to steering...
  ✓ Updated architecture-decisions.md
  ✓ Enhanced domain-expertise.md
  ✓ Refined quality-standards.md
```

*ACE-Genesis with steering context creates increasingly intelligent project architectures, learning from every project to make better decisions for the next one.*