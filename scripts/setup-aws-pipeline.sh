#!/bin/bash

# 🚀 ACE-Flow AWS Pipeline Setup Automation
# Automates the complete AWS Amplify Gen 2 + GitHub Actions setup

set -e  # Exit on any error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo -e "${BLUE}🚀 ACE-Flow AWS Pipeline Setup${NC}"
echo -e "${BLUE}================================${NC}"
echo

# Function to print status
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Check prerequisites
check_prerequisites() {
    print_info "Checking prerequisites..."
    
    # Check AWS CLI
    if ! command -v aws &> /dev/null; then
        print_error "AWS CLI not found. Please install: https://aws.amazon.com/cli/"
        exit 1
    fi
    
    # Check GitHub CLI
    if ! command -v gh &> /dev/null; then
        print_error "GitHub CLI not found. Please install: https://cli.github.com/"
        exit 1
    fi
    
    # Check AWS credentials
    if ! aws sts get-caller-identity &> /dev/null; then
        print_error "AWS credentials not configured. Run: aws configure"
        exit 1
    fi
    
    # Check Node.js
    if ! command -v node &> /dev/null; then
        print_error "Node.js not found. Please install Node.js 18+: https://nodejs.org/"
        exit 1
    fi
    
    print_status "All prerequisites met!"
}

# Get project information
get_project_info() {
    print_info "Gathering project information..."
    
    # Get project name from current directory or prompt
    DEFAULT_PROJECT_NAME=$(basename "$PWD")
    read -p "Project name (default: $DEFAULT_PROJECT_NAME): " PROJECT_NAME
    PROJECT_NAME=${PROJECT_NAME:-$DEFAULT_PROJECT_NAME}
    
    # Get AWS region
    DEFAULT_REGION=$(aws configure get region)
    DEFAULT_REGION=${DEFAULT_REGION:-us-east-1}
    read -p "AWS region (default: $DEFAULT_REGION): " AWS_REGION
    AWS_REGION=${AWS_REGION:-$DEFAULT_REGION}
    
    # Get GitHub repository info
    if git remote get-url origin &> /dev/null; then
        GITHUB_REPO=$(git remote get-url origin | sed 's/.*github\.com[:/]\([^/]*\/[^/]*\)\.git$/\1/')
        print_info "Detected GitHub repository: $GITHUB_REPO"
    else
        read -p "GitHub repository (format: username/repo-name): " GITHUB_REPO
    fi
    
    echo
    print_info "Configuration:"
    echo "  Project Name: $PROJECT_NAME"
    echo "  AWS Region: $AWS_REGION"
    echo "  GitHub Repo: $GITHUB_REPO"
    echo
    
    read -p "Continue with this configuration? (y/N): " CONFIRM
    if [[ ! $CONFIRM =~ ^[Yy]$ ]]; then
        print_error "Setup cancelled"
        exit 1
    fi
}

# Create IAM user and policy
create_iam_resources() {
    print_info "Creating IAM resources..."
    
    IAM_USER_NAME="ace-flow-github-actions-${PROJECT_NAME}"
    IAM_POLICY_NAME="ace-flow-amplify-deploy-${PROJECT_NAME}"
    
    # Create IAM user
    if aws iam get-user --user-name "$IAM_USER_NAME" &> /dev/null; then
        print_warning "IAM user $IAM_USER_NAME already exists"
    else
        aws iam create-user --user-name "$IAM_USER_NAME" --tags Key=Project,Value="$PROJECT_NAME" Key=Purpose,Value=ACE-Flow
        print_status "Created IAM user: $IAM_USER_NAME"
    fi
    
    # Attach AmplifyBackendDeployFullAccess policy
    aws iam attach-user-policy --user-name "$IAM_USER_NAME" --policy-arn "arn:aws:iam::aws:policy/AmplifyBackendDeployFullAccess"
    print_status "Attached AmplifyBackendDeployFullAccess policy"
    
    # Create access keys
    print_info "Creating access keys..."
    ACCESS_KEY_OUTPUT=$(aws iam create-access-key --user-name "$IAM_USER_NAME" --output json)
    ACCESS_KEY_ID=$(echo "$ACCESS_KEY_OUTPUT" | jq -r '.AccessKey.AccessKeyId')
    SECRET_ACCESS_KEY=$(echo "$ACCESS_KEY_OUTPUT" | jq -r '.AccessKey.SecretAccessKey')
    
    print_status "Access keys created successfully"
}

# Create Amplify app
create_amplify_app() {
    print_info "Creating Amplify application..."
    
    # Create Amplify app with GitHub repository
    AMPLIFY_OUTPUT=$(aws amplify create-app \
        --name "$PROJECT_NAME" \
        --repository "https://github.com/$GITHUB_REPO" \
        --platform WEB \
        --oauth-token "$(gh auth token)" \
        --build-spec '{
            "version": 1,
            "applications": [{
                "frontend": {
                    "phases": {
                        "preBuild": {
                            "commands": [
                                "npm ci"
                            ]
                        },
                        "build": {
                            "commands": [
                                "echo \"Frontend build handled by GitHub Actions\"",
                                "echo \"amplify_outputs.json should be generated by backend deployment\""
                            ]
                        }
                    },
                    "artifacts": {
                        "baseDirectory": "dist",
                        "files": ["**/*"]
                    }
                }
            }]
        }' \
        --output json)
    
    AMPLIFY_APP_ID=$(echo "$AMPLIFY_OUTPUT" | jq -r '.app.appId')
    AMPLIFY_APP_ARN=$(echo "$AMPLIFY_OUTPUT" | jq -r '.app.appArn')
    
    print_status "Created Amplify app: $AMPLIFY_APP_ID"
    
    # Create main branch
    aws amplify create-branch \
        --app-id "$AMPLIFY_APP_ID" \
        --branch-name "main" \
        --enable-auto-build false \
        --enable-pull-request-preview false
    
    print_status "Created main branch with auto-build disabled"
    
    # Create webhook for frontend builds
    WEBHOOK_OUTPUT=$(aws amplify create-webhook \
        --app-id "$AMPLIFY_APP_ID" \
        --branch-name "main" \
        --description "ACE-Flow GitHub Actions webhook" \
        --output json)
    
    WEBHOOK_URL=$(echo "$WEBHOOK_OUTPUT" | jq -r '.webhook.webhookUrl')
    print_status "Created webhook for frontend builds"
}

# Configure GitHub repository secrets
configure_github_secrets() {
    print_info "Configuring GitHub repository secrets..."
    
    # Set GitHub secrets
    echo "$ACCESS_KEY_ID" | gh secret set AWS_ACCESS_KEY_ID --repo="$GITHUB_REPO"
    echo "$SECRET_ACCESS_KEY" | gh secret set AWS_SECRET_ACCESS_KEY --repo="$GITHUB_REPO"
    echo "$AWS_REGION" | gh secret set AWS_REGION --repo="$GITHUB_REPO"
    echo "$AMPLIFY_APP_ID" | gh secret set AMPLIFY_APP_ID --repo="$GITHUB_REPO"
    echo "$WEBHOOK_URL" | gh secret set AMPLIFY_WEBHOOK_URL --repo="$GITHUB_REPO"
    
    print_status "GitHub secrets configured successfully"
}

# Update workflow file
update_workflow() {
    print_info "Updating GitHub Actions workflow..."
    
    # Update the ACE-Flow workflow with Amplify-specific configuration
    WORKFLOW_FILE="$PROJECT_ROOT/.github/workflows/ace-flow.yml"
    
    if [[ -f "$WORKFLOW_FILE" ]]; then
        # Add Amplify-specific environment variables
        if ! grep -q "AMPLIFY_APP_ID" "$WORKFLOW_FILE"; then
            sed -i.bak '/aws-region:/a\
          amplify-app-id: ${{ secrets.AMPLIFY_APP_ID }}\
          amplify-webhook-url: ${{ secrets.AMPLIFY_WEBHOOK_URL }}' "$WORKFLOW_FILE"
        fi
        print_status "Updated GitHub Actions workflow"
    else
        print_warning "GitHub Actions workflow file not found"
    fi
}

# Create summary file
create_summary() {
    print_info "Creating setup summary..."
    
    SUMMARY_FILE="$PROJECT_ROOT/ACE_FLOW_SETUP_SUMMARY.md"
    
    cat > "$SUMMARY_FILE" << EOF
# 🚀 ACE-Flow AWS Pipeline Setup Summary

**Project**: $PROJECT_NAME  
**Setup Date**: $(date)  
**AWS Region**: $AWS_REGION  

## 📋 Resources Created

### AWS Resources
- **IAM User**: \`$IAM_USER_NAME\`
- **Amplify App ID**: \`$AMPLIFY_APP_ID\`
- **Amplify App ARN**: \`$AMPLIFY_APP_ARN\`
- **Webhook URL**: \`$WEBHOOK_URL\`

### GitHub Configuration
- **Repository**: $GITHUB_REPO
- **Secrets Configured**: 
  - AWS_ACCESS_KEY_ID ✅
  - AWS_SECRET_ACCESS_KEY ✅
  - AWS_REGION ✅
  - AMPLIFY_APP_ID ✅
  - AMPLIFY_WEBHOOK_URL ✅

## 🎯 Next Steps

1. **Test the pipeline**: Create a GitHub issue with \`@claude /ace-genesis "your idea"\`
2. **Monitor deployments**: Check GitHub Actions and AWS Amplify Console
3. **Access your app**: https://$AMPLIFY_APP_ID.amplifyapp.com

## 🔧 Useful Commands

\`\`\`bash
# Check AWS Amplify status
aws amplify get-app --app-id $AMPLIFY_APP_ID

# View GitHub Actions runs
gh run list --repo=$GITHUB_REPO

# Trigger manual deployment
curl -X POST "$WEBHOOK_URL" -H "Content-Type: application/json" -d '{}'
\`\`\`

## 🆘 Troubleshooting

- **Pipeline fails**: Check GitHub Actions logs and IAM permissions
- **Amplify deployment issues**: Check AWS Amplify Console build logs
- **Access issues**: Verify all GitHub secrets are set correctly

---

*Generated by ACE-Flow automated setup script*
EOF

    print_status "Setup summary saved to: $SUMMARY_FILE"
}

# Main execution flow
main() {
    echo -e "${BLUE}Starting ACE-Flow AWS Pipeline Setup...${NC}"
    echo
    
    check_prerequisites
    get_project_info
    create_iam_resources
    create_amplify_app
    configure_github_secrets
    update_workflow
    create_summary
    
    echo
    echo -e "${GREEN}🎉 ACE-Flow AWS Pipeline Setup Complete!${NC}"
    echo -e "${GREEN}================================${NC}"
    echo
    print_status "All AWS resources created and configured"
    print_status "GitHub secrets configured"
    print_status "Amplify app ready for deployments"
    echo
    print_info "Your Amplify app URL: https://$AMPLIFY_APP_ID.amplifyapp.com"
    print_info "Setup summary: $(pwd)/ACE_FLOW_SETUP_SUMMARY.md"
    echo
    print_info "🚀 Ready to build! Create a GitHub issue with:"
    echo -e "${YELLOW}   @claude /ace-genesis \"your amazing idea\"${NC}"
    echo
}

# Run main function
main "$@"