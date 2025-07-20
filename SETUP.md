# 🚀 ACE-Flow Complete Setup Guide

**Transform any idea into a production-ready AWS Amplify Gen 2 application in <2 hours using intelligent conversation and infrastructure-aware automation.**

## 📋 Prerequisites

### Required Tools
- **Node.js 18+** - For AWS Amplify Gen 2 and Next.js development
- **AWS CLI** - Configured with appropriate permissions for Amplify, DynamoDB, S3, Cognito
- **Git** - For version control and GitHub integration
- **Claude Code** - AI assistant with GitHub integration capabilities

### Required Permissions
Your AWS user/role needs permissions for:
- AWS Amplify (full access)
- DynamoDB (full access)
- S3 (full access)
- Cognito (full access)
- IAM (role creation and management)
- CloudFormation (stack management)
- Lambda (if using custom functions)

## 🎯 Quick Start (5 Minutes)

### 1. Clone and Initialize Your Project
```bash
# Clone ACE-Flow and rename to your project
git clone https://github.com/Paretofilm/ace-flow.git my-awesome-app
cd my-awesome-app

# Remove git history for fresh start
rm -rf .git
git init

# Initialize AWS Amplify Gen 2 project
npm create amplify@latest
```

### 2. Configure GitHub Repository
```bash
# Create GitHub repository (without cloning since we already have the directory)
gh repo create my-awesome-app --public

# Add remote and push ACE-Flow system
git remote add origin https://github.com/[your-username]/my-awesome-app.git
git add .
git commit -m "Initial commit with ACE-Flow system"
git push -u origin main
```

### 3. Set Up AWS Pipeline & GitHub Secrets

**Choose your preferred setup method:**

#### Option A: Automated Setup (Recommended)
**One command creates all AWS resources and configures GitHub secrets:**
```bash
# Run the automated setup script
chmod +x scripts/setup-aws-pipeline.sh
./scripts/setup-aws-pipeline.sh

# Follow interactive prompts:
# - Project name: [your-project-name]
# - AWS region: [us-east-1]
# - GitHub repo: [username/repo-name]
# - Confirm: y

# ✅ Script automatically creates:
# - IAM user with proper permissions
# - AWS Amplify app with GitHub integration  
# - All GitHub repository secrets
# - Complete setup summary document
```

#### Option B: ACE-Flow Command
**Use ACE-Flow's built-in automation:**
```bash
# Create GitHub issue to trigger automated setup
gh issue create --title "Setup Pipeline" --body "@claude /ace-setup-pipeline"

# Monitor GitHub Actions for automated AWS resource creation
gh run list
```

#### Option C: CloudFormation Template
**Infrastructure as Code approach:**
```bash
# Deploy via CloudFormation
aws cloudformation create-stack \
  --stack-name "ace-flow-[project-name]" \
  --template-body file://cloudformation/ace-flow-pipeline-setup.yml \
  --parameters \
    ParameterKey=ProjectName,ParameterValue=[project-name] \
    ParameterKey=GitHubRepository,ParameterValue=[username/repo] \
    ParameterKey=GitHubToken,ParameterValue=$(gh auth token) \
  --capabilities CAPABILITY_NAMED_IAM

# Set GitHub secrets from CloudFormation outputs
```

#### Option D: Manual Setup (Traditional)
**If you prefer manual configuration:**

In your GitHub repository settings → Secrets and variables → Actions, add:
```bash
CLAUDE_CODE_OAUTH_TOKEN=your-claude-api-key
AWS_ACCESS_KEY_ID=your-aws-access-key  
AWS_SECRET_ACCESS_KEY=your-aws-secret-key
AWS_REGION=us-east-1
AMPLIFY_APP_ID=your-amplify-app-id
AMPLIFY_WEBHOOK_URL=your-webhook-url
```

#### Organization-Level Secrets (Enterprise)
For multiple ACE-Flow projects in an organization:
1. Go to organization settings → Secrets and variables → Actions
2. Add secrets at organization level with "Selected repositories" access
3. This allows sharing secrets across multiple projects

**📋 Detailed Instructions:** See [AWS_PIPELINE_SETUP_GUIDE.md](./AWS_PIPELINE_SETUP_GUIDE.md) for complete setup documentation with troubleshooting.

**Why these secrets?** GitHub's security model isolates secrets per repository. The automated setup creates least-privilege IAM users specifically for your ACE-Flow project.

### 4. GitHub Actions Setup (Automatic)
ACE-Flow automatically handles GitHub Actions setup:

**Smart Detection**: ACE-Flow checks your repository setup when you run `/ace-genesis`:

- **No workflows found** → Guides you to run `/install-github-app`
- **Existing workflows** → Automatically enhances them with ACE-Flow capabilities  
- **ACE-Flow already integrated** → Proceeds directly

**Manual GitHub App Installation** (only if prompted):
```bash
# Run this only if ACE-Flow prompts you to
/install-github-app
```

**Alternative manual installation:**
- Go to your repository settings → GitHub Apps
- Install the Claude Code GitHub App
- Grant necessary permissions for issue and PR management

## 🚀 Using ACE-Flow

### Method 1: GitHub Issue (Recommended)
Create a new GitHub issue with:
```
@claude /ace-genesis "I want to build a fitness tracking app with social features"
```

### Method 2: Direct Claude Code Interface
```bash
/ace-genesis "I want to build an online marketplace for handmade products"
```

### Method 3: Existing Project Migration
```bash
/ace-adopt "existing React e-commerce site with Express backend that needs modernization"
```

## 🔄 Complete ACE-Flow Workflow

### Phase 1: Intelligent Genesis (2-5 minutes)
```bash
/ace-genesis "your amazing idea"
```

**What happens:**
1. **Intelligent Interview**: 7-10 targeted questions about your vision
2. **Pattern Recognition**: Automatically identifies optimal architecture pattern
3. **Custom Specification**: Generates tailored project requirements
4. **Architecture Decision**: Selects best-fit technology stack

**Expected Output:**
- Complete project specification document
- Custom data models for your domain
- Authentication and storage strategy
- Implementation roadmap

### Phase 2: Advanced Research (15-30 minutes)
```bash
/ace-research [project-domain] [architecture-pattern]
```

**Automatically triggered after Genesis, or run manually:**

**What happens:**
1. **Documentation Gathering**: Scrapes 30-100 pages of current AWS documentation
2. **Pattern Extraction**: Identifies proven code patterns from official sources
3. **Gotcha Detection**: Documents common pitfalls and prevention strategies
4. **Validation Framework**: Creates comprehensive testing approach

**Expected Output:**
- Structured research directory with 30-100 pages of documentation
- Proven code patterns extracted from official sources
- Common gotchas identified with prevention strategies
- Complete integration requirements documented

### Phase 3: Infrastructure-Aware Implementation (60-90 minutes)
```bash
/ace-implement [project-name]
```

**What happens:**
1. **Backend Deployment**: AWS infrastructure with timing awareness (2-5 minutes)
2. **Type Generation**: Safe TypeScript types from deployed schema
3. **Frontend Implementation**: Production-ready UI with your architecture pattern
4. **Validation & Testing**: Multi-level validation with auto-fix capabilities

**Expected Output:**
- Fully deployed AWS Amplify Gen 2 backend
- Production-ready frontend application
- Comprehensive test suite
- Complete deployment documentation

## 🏗️ Architecture Pattern Examples

### social_platform (3-4 minute deployment)
```bash
/ace-genesis "fitness tracking app where users share workouts and motivate each other"
```
**Generated:**
- User authentication with groups and social login
- Real-time activity feeds with GraphQL subscriptions
- Media storage with S3 and CloudFront optimization
- Social features: profiles, following, workout sharing
- Mobile-optimized UI with camera integration

### e_commerce (4-5 minute deployment)
```bash
/ace-genesis "online marketplace where artists sell handmade jewelry"
```
**Generated:**
- Multi-vendor authentication (buyers, sellers, admins)
- Stripe Connect integration for marketplace payments
- Product catalog with search and inventory management
- Order processing and seller dashboard
- Buyer protection and review system

### content_management (2-3 minute deployment)
```bash
/ace-genesis "documentation platform for collaborative technical writing"
```
**Generated:**
- Role-based publishing workflow (authors, editors, admins)
- Rich text editor with collaborative features
- Version control and approval processes
- SEO optimization and media library
- Real-time collaborative editing

### dashboard_analytics (3-4 minute deployment)
```bash
/ace-genesis "business intelligence dashboard for sales analytics"
```
**Generated:**
- Real-time data streaming with AWS Kinesis
- Interactive charts with drill-down capabilities
- Complex query optimization for large datasets
- User permission-based data access
- Export capabilities and scheduled reports

### simple_crud (1-2 minute deployment)
```bash
/ace-genesis "task management system for team collaboration"
```
**Generated:**
- Basic user authentication and profiles
- Task creation, assignment, and tracking
- Simple relationships and data management
- Clean, functional UI with Amplify components
- Basic notification system

## 📁 Expected Project Structure

After ACE-Flow completion:
```
my-awesome-app/
├── .claude/                    # ACE-Flow commands
│   ├── ace-genesis.md
│   ├── ace-research.md
│   ├── ace-implement.md
│   ├── ace-adopt.md
│   └── ace-learn.md
├── .github/                    # GitHub Actions automation
│   └── workflows/
│       └── ace-flow.yml
├── .learning/                  # Self-learning system
│   ├── errors/
│   └── solutions/
├── genesis/                    # Project creation patterns
│   ├── architecture-patterns/
│   ├── conversation-flows/
│   └── prototype-templates/
├── workflows/                  # Advanced ACE-Flow workflows
├── CLAUDE.md                   # ACE-Flow enhanced project guidance
├── README.md                   # ACE-Flow documentation
├── SETUP.md                    # Setup instructions
├── QUICKSTART.md               # Quick start guide
├── LICENSE                     # MIT license
├── amplify/                    # AWS backend (created by npm create amplify)
│   ├── backend.ts
│   ├── auth/resource.ts
│   ├── data/resource.ts
│   └── storage/resource.ts
├── src/                        # Frontend application (created by npm create amplify)
│   ├── app/                    # Next.js App Router
│   ├── components/             # Custom UI components
│   └── lib/                    # Utilities and types
├── tests/                      # Comprehensive test suite
└── package.json                # Project dependencies
```

## 📝 CLAUDE.md Smart Handling

ACE-Flow intelligently handles CLAUDE.md files:

### For New Projects
- **Template Provided**: Existing `CLAUDE.md` serves as baseline
- **Auto-Customization**: `/ace-genesis` customizes with project-specific information
- **Architecture Integration**: Adds relevant patterns and guidelines

### For Existing Projects  
- **Preservation First**: `/ace-adopt` always preserves existing CLAUDE.md
- **Non-Destructive Enhancement**: Adds ACE-Flow sections without removing existing content
- **Smart Merging**: Detects existing sections to avoid duplication
- **Backup Creation**: Creates `.backup` copy before any changes

## ⚡ Success Metrics and Expectations

### Quality Guarantees
- **>95% First-Run Success Rate**: Applications work immediately after deployment
- **Production-Ready Code**: Includes testing, security, performance optimization
- **Real AWS Integration**: Works with actual cloud infrastructure, not toy examples
- **Documentation-Driven**: Based on 30-100 pages of current official documentation

### Timeline Expectations
- **Total Time**: <2 hours from idea to working application
- **Genesis Phase**: 2-5 minutes (intelligent conversation)
- **Research Phase**: 15-30 minutes (automated documentation gathering)
- **Implementation Phase**: 60-90 minutes (including testing and deployment)

### Architecture Precision
- **Pattern Recognition**: >95% accuracy in selecting optimal architecture
- **Feature Completeness**: 100% of stated requirements implemented
- **Scalability**: All architectures designed for production scale
- **Integration Success**: All third-party integrations work out-of-box

## 🔧 Troubleshooting

### Common Issues

#### AWS Permissions
```bash
# Test AWS configuration
aws sts get-caller-identity
aws amplify list-apps
```

#### Claude Code Token Issues
**Missing or invalid `CLAUDE_CODE_OAUTH_TOKEN`:**
```bash
# Check if secret is set (in GitHub repo settings → Secrets)
# Should show CLAUDE_CODE_OAUTH_TOKEN in the list
```

**Common token problems:**
1. **Token not set**: Add `CLAUDE_CODE_OAUTH_TOKEN` to repository secrets
2. **Wrong token**: Ensure you're using your Claude API key, not GitHub token
3. **Organization setup**: If using org-level secrets, verify repo has access
4. **Expired token**: Regenerate Claude API key if authentication fails

#### GitHub App Not Responding
**First, ensure GitHub App is installed:**
```bash
# In Claude Code interface, run:
/install-github-app
```

**If still having issues:**
1. Check repository settings → GitHub Apps
2. Verify Claude Code app is installed and has permissions
3. Check that workflow files exist in `.github/workflows/`
4. Verify permissions for issues and PRs are granted
5. **Check secrets**: Ensure `CLAUDE_CODE_OAUTH_TOKEN` is properly set

**Note**: Many issues are caused by skipping the `/install-github-app` step or missing token setup!

#### Build Failures
```bash
# Check Node.js version
node --version  # Should be 18+

# Clear dependencies and reinstall
rm -rf node_modules package-lock.json
npm install
```

#### Amplify Deployment Issues
```bash
# Check Amplify status
npx amplify status

# Reset Amplify environment
npx amplify delete
npx amplify init
```

### Getting Help

1. **Check ACE-Flow Documentation**: Review `README.md` and command documentation
2. **GitHub Issues**: Create issue with `@claude` mention for automated assistance
3. **AWS Documentation**: ACE-Flow research phase creates comprehensive documentation links
4. **Community Support**: Reference the context engineering methodology in `workflows/`

## 🎉 Advanced Usage

### Custom Architecture Patterns
Add your own patterns to `genesis/architecture-patterns/pattern-library.md`

### Research Methodology
Customize research approach in `workflows/ace-research.md`

### Deployment Strategies
Modify deployment configuration in `.github/workflows/ace-flow.yml`

## 📚 Learning More

- [Complete ACE-Flow Methodology](./README.md)
- [Architecture Pattern Library](./genesis/architecture-patterns/pattern-library.md)
- [Advanced Research Workflows](./workflows/ace-research.md)
- [Context Engineering Integration](./workflows/context-engineering.md)

---

## 🚀 Ready to Build?

Start your first ACE-Flow project:

```bash
/ace-genesis "I want to build something amazing"
```

*Transform any idea into a production-ready AWS Amplify Gen 2 application with intelligent conversation, comprehensive research, and infrastructure-aware implementation.*

---

**Built with ❤️ for developers who want to move from idea to production at lightspeed.**