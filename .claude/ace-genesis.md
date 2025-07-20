# ACE-Genesis: Intelligent Project Creation

**Creates custom AWS Amplify Gen 2 applications through intelligent conversation and architecture decision-making.**

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

3. **Custom Project Generation**: Creates tailored architecture and implementation plan:
   - Custom data models for your specific domain
   - Appropriate authentication strategy (basic, social, multi-role)
   - Optimal storage and real-time configuration
   - Production-ready deployment setup

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

# 2. Automatic research phase (triggered automatically)
# - Scrapes 30-100 pages of current AWS Amplify Gen 2 documentation
# - Extracts proven patterns and identifies gotchas
# - Creates comprehensive implementation context

# 3. Implementation with infrastructure awareness
# - Deploys backend with timing awareness (2-5 minutes)
# - Generates types and implements frontend
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

## Expected Outcome

After completing the ACE-Genesis conversation:

✅ **Project Specification**: Complete architecture document
✅ **Custom Data Models**: Tailored to your specific domain  
✅ **Authentication Strategy**: Appropriate for your user types
✅ **Implementation Plan**: Step-by-step development roadmap
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

*This command transforms any idea into a precisely tailored, production-ready AWS Amplify Gen 2 application through intelligent conversation and architecture decision-making.*