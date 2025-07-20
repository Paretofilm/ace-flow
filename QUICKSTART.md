# ⚡ ACE-Flow Quick Start

**Get from idea to production-ready AWS Amplify Gen 2 application in <2 hours.**

## 🚀 2-Minute Setup

```bash
# 1. Clone and initialize your project
git clone https://github.com/Paretofilm/ace-flow.git my-project
cd my-project
rm -rf .git && git init
npm create amplify@latest

# 2. Set up GitHub repository
gh repo create my-project --public
git remote add origin https://github.com/[your-username]/my-project.git
git add . && git commit -m "Initial commit with ACE-Flow"
git push -u origin main

# 3. Automated AWS pipeline setup (one command!)
chmod +x scripts/setup-aws-pipeline.sh
./scripts/setup-aws-pipeline.sh
# Follow prompts: project name, AWS region, confirm setup
# ✅ Script automatically creates all AWS resources and GitHub secrets

# 4. Start building immediately!
# Create GitHub issue with: @claude /ace-genesis "your amazing idea"
```

### Alternative: Manual Setup
If you prefer manual configuration:
```bash
# Set GitHub secrets manually (in repository settings → Secrets and variables → Actions)
CLAUDE_CODE_OAUTH_TOKEN=your-claude-api-key
AWS_ACCESS_KEY_ID=your-aws-access-key
AWS_SECRET_ACCESS_KEY=your-aws-secret-key
AWS_REGION=us-east-1
AMPLIFY_APP_ID=your-amplify-app-id
AMPLIFY_WEBHOOK_URL=your-webhook-url

# See AWS_PIPELINE_SETUP_GUIDE.md for detailed manual setup instructions
```

## 💡 Example Projects (Copy & Paste)

### Social Fitness App
```
@claude /ace-genesis "fitness tracking app where users share workouts and motivate each other through social features"
```
**Result**: User profiles, workout logging, social feeds, real-time updates, mobile-optimized UI

### E-commerce Marketplace  
```
@claude /ace-genesis "online marketplace where local artists can sell handmade jewelry and crafts"
```
**Result**: Multi-vendor platform, Stripe payments, product catalogs, seller dashboards

### Content Hub
```
@claude /ace-genesis "documentation platform where engineering teams collaboratively write technical docs"
```
**Result**: Rich text editor, publishing workflows, version control, team collaboration

### Analytics Dashboard
```
@claude /ace-genesis "business intelligence dashboard for sales team to track performance metrics"
```
**Result**: Real-time data visualization, interactive charts, performance analytics

### Task Manager
```
@claude /ace-genesis "team task management system with assignments and progress tracking"
```
**Result**: Task creation, user assignments, progress tracking, team collaboration

### Existing Project Migration
```
@claude /ace-adopt "e_commerce site with React frontend and Node.js API that needs modernization"
```
**Result**: Safe migration with tests, branch isolation, incremental updates, rollback capabilities

## 🔄 ACE-Flow Process Options

> 📊 **[Visual Workflow Guide](./docs/ACE-FLOW-VISUAL-GUIDE.md)** - See the complete command flow visualization

### New Projects: 3-Step Process

#### 1. 🧠 Genesis (2-5 minutes)
**Command**: `/ace-genesis "your idea"`
- Intelligent interview (7-10 questions)
- Pattern recognition (social_platform, e_commerce, content_management, dashboard_analytics, simple_crud)
- Custom architecture specification

#### 2. 🔬 Research (15-30 minutes, automatic)
**Command**: `/ace-research project-domain pattern` (auto-triggered)
- Scrapes 30-100 pages of AWS documentation
- Extracts proven patterns and gotchas
- Creates implementation context

#### 3. 🚀 Implementation (60-90 minutes)
**Command**: `/ace-implement project-name` (auto-triggered)
- Deploys AWS backend (2-5 minutes)
- Implements frontend with your pattern
- Production-ready with tests and security

### Existing Projects: Safe Migration

#### 🔄 Adoption (30-120 minutes)
**Command**: `/ace-adopt "existing project description"`
- Creates safe adoption branch with backups
- Generates comprehensive test suite
- Incremental migration with validation
- Zero-downtime upgrade with rollback capabilities

## 📈 Success Metrics

- **>95% Success Rate**: Works on first try
- **<2 Hours Total**: From idea to deployed app
- **Production Ready**: Testing, security, performance included
- **Real AWS**: Works with actual cloud infrastructure

## 🆘 Quick Troubleshooting

**Setup script failed?**
- Run: `./scripts/setup-aws-pipeline.sh` again (safe to retry)
- Check: `aws sts get-caller-identity` and `gh auth status`
- See: [AWS_PIPELINE_SETUP_GUIDE.md](./AWS_PIPELINE_SETUP_GUIDE.md) for detailed troubleshooting

**ACE-Flow commands not working?**
- ACE-Flow will automatically detect missing setup and guide you
- If prompted, run `/ace-setup-pipeline` for automated AWS setup
- Check that GitHub issue includes `@claude` mention

**GitHub App not responding?**
- Run automated setup: `./scripts/setup-aws-pipeline.sh`
- Or manually: `/install-github-app` in Claude Code interface
- Check repository settings → GitHub Apps → Claude Code installed

**AWS permissions issues?**
- Test: `aws sts get-caller-identity`
- Rerun: `./scripts/setup-aws-pipeline.sh` to recreate IAM user
- Needs: Amplify, DynamoDB, S3, Cognito, IAM access

**Build failures?**
- Check Node.js 18+: `node --version`
- Reinstall: `rm -rf node_modules && npm install`
- Verify: `gh secret list` shows all 5 secrets configured

## 📚 Learn More

- [AWS Pipeline Setup Guide](./AWS_PIPELINE_SETUP_GUIDE.md) - Automated AWS configuration  
- [Complete Setup Guide](./SETUP.md) - Detailed setup instructions
- [Methodology Overview](./README.md) - Full ACE-Flow documentation
- [Architecture Patterns](./genesis/architecture-patterns/pattern-library.md) - Available patterns

---

## 🎯 Start Now

Create a GitHub issue in your repository:
```
@claude /ace-genesis "I want to build [describe your amazing idea]"
```

*From idea to production in <2 hours with ACE-Flow.*