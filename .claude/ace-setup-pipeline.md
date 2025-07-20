# ACE-Setup-Pipeline: AWS Infrastructure Automation

**Automates the complete AWS Amplify Gen 2 + GitHub Actions CI/CD pipeline setup in <5 minutes.**

## Prerequisites Check

ACE-Setup-Pipeline will automatically verify all requirements before proceeding.

## Usage

```bash
/ace-setup-pipeline [project-name]
```

Examples:
- `/ace-setup-pipeline` (uses current directory name)
- `/ace-setup-pipeline "my-fitness-app"`
- `/ace-setup-pipeline "marketplace-mvp"`

## What This Command Does

1. **Prerequisites Verification**: Checks all required tools and credentials:
   - AWS CLI installed and configured
   - GitHub CLI installed and authenticated
   - Node.js 18+ available
   - Current directory is a git repository

2. **AWS Resource Creation**: Automatically creates and configures:
   - IAM user with `AmplifyBackendDeployFullAccess` policy
   - AWS access keys for GitHub Actions
   - AWS Amplify application with GitHub integration
   - Amplify branch with auto-build disabled
   - Webhook for frontend deployments

3. **GitHub Integration**: Seamlessly configures:
   - Repository secrets (AWS credentials, app ID, webhook URL)
   - Enhanced GitHub Actions workflow
   - Branch protection and deployment settings

4. **Documentation Generation**: Creates comprehensive setup summary:
   - All created AWS resource IDs
   - Configuration details and next steps
   - Troubleshooting commands and tips

## Interactive Setup Process

### Phase 1: Project Configuration (30 seconds)
```
🚀 ACE-Flow AWS Pipeline Setup
================================

ℹ️  Checking prerequisites...
✅ All prerequisites met!

ℹ️  Gathering project information...
Project name (default: my-awesome-app): [ENTER or type name]
AWS region (default: us-east-1): [ENTER or type region]
ℹ️  Detected GitHub repository: username/my-awesome-app

Configuration:
  Project Name: my-awesome-app
  AWS Region: us-east-1
  GitHub Repo: username/my-awesome-app

Continue with this configuration? (y/N): y
```

### Phase 2: AWS Resource Creation (2-3 minutes)
```
ℹ️  Creating IAM resources...
✅ Created IAM user: ace-flow-github-actions-my-awesome-app
✅ Attached AmplifyBackendDeployFullAccess policy
✅ Access keys created successfully

ℹ️  Creating Amplify application...
✅ Created Amplify app: d1a2b3c4d5e6f7
✅ Created main branch with auto-build disabled
✅ Created webhook for frontend builds
```

### Phase 3: GitHub Configuration (1 minute)
```
ℹ️  Configuring GitHub repository secrets...
✅ GitHub secrets configured successfully

ℹ️  Updating GitHub Actions workflow...
✅ Updated GitHub Actions workflow

ℹ️  Creating setup summary...
✅ Setup summary saved to: ACE_FLOW_SETUP_SUMMARY.md
```

### Phase 4: Completion Summary
```
🎉 ACE-Flow AWS Pipeline Setup Complete!
================================

✅ All AWS resources created and configured
✅ GitHub secrets configured
✅ Amplify app ready for deployments

ℹ️  Your Amplify app URL: https://d1a2b3c4d5e6f7.amplifyapp.com
ℹ️  Setup summary: ./ACE_FLOW_SETUP_SUMMARY.md

🚀 Ready to build! Create a GitHub issue with:
   @claude /ace-genesis "your amazing idea"
```

## Implementation Details

### AWS Resources Created
```yaml
IAM_User:
  name: "ace-flow-github-actions-{project-name}"
  policies: ["AmplifyBackendDeployFullAccess"]
  access_keys: "generated for GitHub Actions"

Amplify_App:
  name: "{project-name}"
  repository: "connected to GitHub repo"
  auto_build: false  # Controlled by GitHub Actions
  webhook: "created for frontend deployments"

Branch_Configuration:
  main_branch:
    auto_build: false
    pull_request_preview: false
    deployment_type: "custom_pipeline"
```

### GitHub Secrets Configured
```yaml
AWS_ACCESS_KEY_ID: "IAM user access key"
AWS_SECRET_ACCESS_KEY: "IAM user secret key"
AWS_REGION: "selected AWS region"
AMPLIFY_APP_ID: "created Amplify app ID"
AMPLIFY_WEBHOOK_URL: "webhook for frontend builds"
CLAUDE_CODE_OAUTH_TOKEN: "requires manual setup"
```

### Enhanced Workflow Integration
The command automatically enhances the existing `.github/workflows/ace-flow.yml` with:
- Amplify-specific environment variables
- Backend deployment steps using `npx ampx pipeline-deploy`
- Frontend build triggering via webhook
- Proper error handling and status reporting

## Error Handling and Recovery

### Common Issues and Auto-Resolution
1. **AWS credentials not configured**: Guides user to run `aws configure`
2. **GitHub CLI not authenticated**: Prompts for `gh auth login`
3. **IAM user already exists**: Safely reuses existing user
4. **Amplify app name conflict**: Automatically appends timestamp
5. **GitHub secrets permission issues**: Provides clear error messages

### Manual Recovery Commands
```bash
# If setup fails partway through, clean up and retry:
./scripts/cleanup-aws-pipeline.sh [project-name]
/ace-setup-pipeline [project-name]

# Check setup status:
aws amplify get-app --app-id [APP_ID]
gh secret list --repo=[REPO]

# Test pipeline manually:
curl -X POST [WEBHOOK_URL] -H "Content-Type: application/json" -d '{}'
```

## Integration with ACE-Flow Commands

### Automatic Setup Detection
All ACE-Flow commands (`/ace-genesis`, `/ace-research`, `/ace-implement`, `/ace-adopt`) automatically detect if pipeline setup is needed:

```yaml
Pipeline_Check:
  if_github_secrets_missing:
    action: "Guide user to run /ace-setup-pipeline"
    message: "AWS pipeline not configured. Run '/ace-setup-pipeline' first."
    
  if_amplify_app_missing:
    action: "Auto-detect and suggest setup"
    fallback: "Provide manual setup instructions"
    
  if_workflow_not_enhanced:
    action: "Auto-enhance existing workflow"
    backup: "Create .bak file before modifications"
```

### Post-Setup Workflow
```bash
# 1. Run pipeline setup (one-time)
/ace-setup-pipeline

# 2. Start building immediately
/ace-genesis "fitness tracking app with social features"

# 3. Pipeline automatically handles:
#    - Research phase documentation gathering
#    - Backend deployment via GitHub Actions
#    - Frontend build via Amplify webhook
#    - Production-ready app in <2 hours
```

## Success Metrics and Validation

### Setup Validation
- **All AWS resources created**: IAM user, Amplify app, branch, webhook
- **GitHub integration working**: Secrets set, workflow enhanced
- **Pipeline connectivity**: Can trigger builds via webhook
- **Documentation complete**: Summary file with all details

### Performance Targets
- **Setup time**: <5 minutes total (mostly automated)
- **First deployment**: <10 minutes after setup
- **Pipeline reliability**: >95% success rate
- **Error recovery**: Clear guidance for all failure modes

## Expected Outcome

After completing `/ace-setup-pipeline`:

✅ **AWS Infrastructure**: Fully configured Amplify Gen 2 environment  
✅ **CI/CD Pipeline**: GitHub Actions with AWS integration  
✅ **Security Setup**: IAM user with least-privilege permissions  
✅ **Documentation**: Complete setup summary and troubleshooting guide  
✅ **Ready for Development**: Immediate `/ace-genesis` capability  

The system automatically proceeds to support all ACE-Flow commands with full infrastructure awareness and production-ready deployment capabilities.

## Quality Guarantees

- **>95% Success Rate**: Setup works on first attempt with proper prerequisites
- **Security First**: Least-privilege IAM policies and secure credential handling
- **Idempotent**: Safe to run multiple times without conflicts
- **Comprehensive**: Handles all aspects of AWS + GitHub integration
- **Documented**: Complete audit trail and recovery procedures

*This command transforms any repository into a production-ready ACE-Flow environment with enterprise-grade CI/CD capabilities in under 5 minutes.*