# 🚀 ACE-Flow AWS Pipeline Setup Guide

**Complete AWS Amplify Gen 2 + GitHub Actions automation in <5 minutes with 3 simple options.**

---

## 📋 Prerequisites (2 minutes)

### Required Tools
```bash
# 1. Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip && sudo ./aws/install

# 2. Install GitHub CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update && sudo apt install gh

# 3. Verify Node.js 18+
node --version  # Should show v18.x.x or higher
```

### Authentication Setup
```bash
# 1. Configure AWS credentials
aws configure
# Enter: Access Key ID, Secret Access Key, Region (us-east-1), Output format (json)

# 2. Authenticate with GitHub
gh auth login
# Choose: GitHub.com, HTTPS, Yes (Git credential helper), Login with web browser

# 3. Verify authentication
aws sts get-caller-identity  # Should show your AWS account
gh auth status              # Should show authenticated
```

---

## ⚡ Setup Options (Choose One)

## **Option 1: Automated Script (Recommended)**
*Fastest and most reliable - handles everything automatically*

```bash
# 1. Clone ACE-Flow and navigate to your project
git clone https://github.com/Paretofilm/ace-flow.git my-awesome-app
cd my-awesome-app
rm -rf .git && git init

# 2. Run the automated setup script
chmod +x scripts/setup-aws-pipeline.sh
./scripts/setup-aws-pipeline.sh

# 3. Follow the interactive prompts
# - Project name: [my-awesome-app]
# - AWS region: [us-east-1]
# - GitHub repo: [username/my-awesome-app]
# - Confirm: y

# 4. Wait 3-4 minutes for automation to complete
# ✅ Script creates all AWS resources and configures GitHub secrets

# 5. Push to GitHub and start building!
git remote add origin https://github.com/[username]/my-awesome-app.git
git add . && git commit -m "Initial ACE-Flow setup"
git push -u origin main

# 🎉 Ready! Create GitHub issue: @claude /ace-genesis "your idea"
```

---

## **Option 2: ACE-Flow Command**
*Use ACE-Flow's built-in automation command*

```bash
# 1. Clone and setup repository
git clone https://github.com/Paretofilm/ace-flow.git my-awesome-app
cd my-awesome-app
rm -rf .git && git init
npm create amplify@latest

# 2. Create GitHub repository
gh repo create my-awesome-app --public
git remote add origin https://github.com/[username]/my-awesome-app.git
git add . && git commit -m "Initial commit"
git push -u origin main

# 3. Create GitHub issue and run ACE-Flow setup
gh issue create --title "Setup AWS Pipeline" --body "@claude /ace-setup-pipeline"

# 4. Monitor the GitHub Actions for automated setup
gh run list

# 🎉 Setup completes automatically via GitHub Actions
```

---

## **Option 3: CloudFormation Template**
*Infrastructure as Code approach for enterprise environments*

```bash
# 1. Get GitHub token
GITHUB_TOKEN=$(gh auth token)

# 2. Deploy CloudFormation stack
aws cloudformation create-stack \
  --stack-name "ace-flow-my-awesome-app" \
  --template-body file://cloudformation/ace-flow-pipeline-setup.yml \
  --parameters \
    ParameterKey=ProjectName,ParameterValue=my-awesome-app \
    ParameterKey=GitHubRepository,ParameterValue=username/my-awesome-app \
    ParameterKey=GitHubToken,ParameterValue=$GITHUB_TOKEN \
  --capabilities CAPABILITY_NAMED_IAM

# 3. Wait for stack creation (5-8 minutes)
aws cloudformation wait stack-create-complete --stack-name "ace-flow-my-awesome-app"

# 4. Get stack outputs
aws cloudformation describe-stacks \
  --stack-name "ace-flow-my-awesome-app" \
  --query 'Stacks[0].Outputs' \
  --output table

# 5. Set GitHub secrets from outputs
gh secret set AWS_ACCESS_KEY_ID --body "[AccessKeyId from outputs]"
gh secret set AWS_SECRET_ACCESS_KEY --body "[SecretAccessKey from outputs]" 
gh secret set AWS_REGION --body "us-east-1"
gh secret set AMPLIFY_APP_ID --body "[AmplifyAppId from outputs]"
gh secret set AMPLIFY_WEBHOOK_URL --body "[WebhookUrl from outputs]"

# 🎉 Ready! Create GitHub issue: @claude /ace-genesis "your idea"
```

---

## 🔍 Verification Steps

### Check AWS Resources
```bash
# Verify IAM user
aws iam get-user --user-name "ace-flow-github-actions-my-awesome-app"

# Verify Amplify app
aws amplify list-apps

# Get Amplify app details
AMPLIFY_APP_ID=[your-app-id]
aws amplify get-app --app-id $AMPLIFY_APP_ID
```

### Check GitHub Configuration
```bash
# Verify secrets are set
gh secret list

# Should show:
# AWS_ACCESS_KEY_ID        ✓
# AWS_SECRET_ACCESS_KEY    ✓
# AWS_REGION              ✓
# AMPLIFY_APP_ID          ✓
# AMPLIFY_WEBHOOK_URL     ✓
```

### Test the Pipeline
```bash
# Create test GitHub issue
gh issue create --title "Test ACE-Flow" --body "@claude /ace-genesis \"simple task management app\""

# Monitor GitHub Actions
gh run list
gh run view [run-id] --log
```

---

## 📊 Setup Verification Checklist

| Component | Check Command | Expected Result |
|-----------|---------------|-----------------|
| **AWS CLI** | `aws --version` | `aws-cli/2.x.x` |
| **GitHub CLI** | `gh --version` | `gh version 2.x.x` |
| **AWS Auth** | `aws sts get-caller-identity` | Your account details |
| **GitHub Auth** | `gh auth status` | `✓ Logged in to github.com` |
| **IAM User** | `aws iam get-user --user-name ace-flow-github-actions-[project]` | User details |
| **Amplify App** | `aws amplify list-apps` | Your app in list |
| **GitHub Secrets** | `gh secret list` | 5 secrets configured |
| **Repository** | `git remote -v` | GitHub origin URL |

---

## 🛠️ Troubleshooting

### Common Issues and Solutions

#### **AWS CLI Not Found**
```bash
# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip && sudo ./aws/install
aws --version  # Verify installation
```

#### **AWS Credentials Invalid**
```bash
# Reconfigure AWS credentials
aws configure
# Enter valid Access Key ID and Secret Access Key

# Test access
aws sts get-caller-identity
```

#### **GitHub CLI Authentication Failed**
```bash
# Login to GitHub CLI
gh auth login
# Follow prompts for web authentication

# Verify authentication
gh auth status
```

#### **IAM Permissions Error**
```bash
# Check IAM user permissions
aws iam list-attached-user-policies --user-name ace-flow-github-actions-[project]

# Should include: AmplifyBackendDeployFullAccess
```

#### **Amplify App Creation Failed**
```bash
# Check if app name already exists
aws amplify list-apps --query 'apps[?name==`my-awesome-app`]'

# Use unique name if conflict
./scripts/setup-aws-pipeline.sh  # Will auto-append timestamp
```

#### **GitHub Secrets Not Set**
```bash
# Manual secret setup
gh secret set AWS_ACCESS_KEY_ID
gh secret set AWS_SECRET_ACCESS_KEY  
gh secret set AWS_REGION
gh secret set AMPLIFY_APP_ID
gh secret set AMPLIFY_WEBHOOK_URL

# Verify all secrets
gh secret list
```

#### **Pipeline Fails on First Run**
```bash
# Check GitHub Actions logs
gh run list
gh run view [run-id] --log

# Common fixes:
# 1. Wait for AWS resources to propagate (2-3 minutes)
# 2. Verify all GitHub secrets are set correctly
# 3. Check IAM permissions in AWS Console
```

### Manual Recovery
```bash
# If setup fails, clean up and retry:
aws cloudformation delete-stack --stack-name "ace-flow-[project]"
aws iam delete-access-key --user-name "ace-flow-github-actions-[project]" --access-key-id [key-id]
aws iam delete-user --user-name "ace-flow-github-actions-[project]"
aws amplify delete-app --app-id [app-id]

# Then retry setup
./scripts/setup-aws-pipeline.sh
```

---

## 🎯 What You Get After Setup

### **AWS Resources Created**
- ✅ **IAM User**: `ace-flow-github-actions-[project]` with least-privilege permissions
- ✅ **Amplify App**: Connected to your GitHub repository
- ✅ **Amplify Branch**: Main branch with auto-build disabled
- ✅ **Webhook**: For triggering frontend builds from GitHub Actions

### **GitHub Configuration**
- ✅ **Secrets**: All AWS credentials and app IDs configured
- ✅ **Workflow**: Enhanced with Amplify deployment capabilities
- ✅ **Repository**: Connected to AWS Amplify for automatic deployments

### **ACE-Flow Ready**
- ✅ **Commands Available**: `/ace-genesis`, `/ace-research`, `/ace-implement`, `/ace-adopt`
- ✅ **Full Pipeline**: Backend deployment + frontend hosting automated
- ✅ **Production Ready**: Security, testing, and monitoring included

---

## 🚀 Next Steps

### **Start Building Immediately**
```bash
# Create GitHub issue with ACE-Flow command
gh issue create --title "Build My App" --body "@claude /ace-genesis \"[describe your amazing idea]\""

# Examples:
gh issue create --title "Fitness App" --body "@claude /ace-genesis \"fitness tracking app where users share workouts and motivate each other\""

gh issue create --title "Marketplace" --body "@claude /ace-genesis \"online marketplace for local artists to sell handmade products\""
```

### **Monitor Progress**
- **GitHub Actions**: `https://github.com/[username]/[repo]/actions`
- **AWS Amplify Console**: `https://console.aws.amazon.com/amplify/home`
- **Your App URL**: `https://[app-id].amplifyapp.com`

### **Learn More**
- [ACE-Flow Documentation](./README.md)
- [QUICKSTART Guide](./QUICKSTART.md)
- [Architecture Patterns](./genesis/architecture-patterns/pattern-library.md)

---

**🎉 You're now ready to build production-ready AWS Amplify Gen 2 applications with ACE-Flow in <2 hours!**

*From idea to deployed application with professional CI/CD, security, and monitoring - all automated.*