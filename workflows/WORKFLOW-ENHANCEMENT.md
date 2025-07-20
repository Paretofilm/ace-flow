# 🔧 ACE-Flow Workflow Enhancement Guide

**How ACE-Flow intelligently enhances existing GitHub Actions workflows**

## 🧠 Smart Detection Logic

When you run `/ace-genesis`, ACE-Flow performs intelligent setup detection:

### 1. Workflow File Detection
```bash
# ACE-Flow checks for existing workflows
ls .github/workflows/*.yml 2>/dev/null
```

### 2. Decision Tree

#### Scenario A: No Workflows Found
```
No .github/workflows/*.yml files exist
↓
Guide user to run /install-github-app
↓  
Stop execution until GitHub App installed
↓
User runs /install-github-app (creates workflows)
↓
Next /ace-genesis run proceeds to enhancement
```

#### Scenario B: Workflows Exist, No ACE-Flow Integration
```
Workflow files exist but lack ACE-Flow configuration
↓
Automatically enhance existing workflows
↓
Add ACE-Flow capabilities to Claude Code steps
↓
Preserve existing functionality
↓
Proceed with ACE-Genesis conversation
```

#### Scenario C: ACE-Flow Already Integrated
```
ACE-Flow configuration detected in workflows
↓
No changes needed
↓
Proceed directly with ACE-Genesis conversation
```

## 🛠️ Workflow Enhancement Process

### Detection of ACE-Flow Integration
ACE-Flow checks for these indicators in existing workflows:

```yaml
# Looks for ACE-Flow markers in workflow files
- "ACE-Flow"
- "ace-genesis"
- "Amplified Context Engineering"
- Custom instructions containing ACE-Flow commands
```

### Enhancement Strategy

#### 1. Enhance Existing Claude Code Steps
If a workflow contains `anthropics/claude-code-action`, ACE-Flow enhances it by:

**Adding Enhanced Tools:**
```yaml
allowed_tools: |
  # Existing tools preserved
  # ACE-Flow tools added:
  Bash(npx amplify *),
  Bash(npx ampx *),
  Bash(aws *),
  WebFetch(*),
  WebSearch(*),
  Task(*),
  Glob(*),
  Grep(*)
```

**Adding ACE-Flow Custom Instructions:**
```yaml
custom_instructions: |
  # Existing instructions preserved
  # ACE-Flow configuration added:
  
  ## 🚀 ACE-Flow Commands Available:
  
  ### /ace-genesis [idea]
  Intelligent project creation with conversation and architecture decision-making
  
  ### /ace-research [project-domain] [architecture-pattern]  
  Advanced documentation research (30-100 pages)
  
  ### /ace-implement [project-name]
  Infrastructure-aware implementation with auto-fix capabilities
```

#### 2. Add Missing Steps
If workflow lacks necessary steps, ACE-Flow adds:

**AWS Configuration:**
```yaml
- name: Configure AWS credentials for ACE-Flow
  uses: aws-actions/configure-aws-credentials@v4
  with:
    aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
    aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    aws-region: ${{ secrets.AWS_REGION || 'us-east-1' }}
```

**Amplify Validation:**
```yaml
- name: Validate Amplify Configuration
  run: |
    if [ -f "amplify/backend.ts" ]; then
      echo "✅ Amplify Gen 2 configuration found"
      npx amplify configure list-commands || echo "Validation skipped"
    fi
```

#### 3. Preserve Existing Functionality
- All existing workflow steps are preserved
- Existing custom instructions are maintained
- Existing tool permissions are kept
- Only ACE-Flow enhancements are added

## 📋 Enhancement Examples

### Example 1: Basic Claude Code Workflow
**Before Enhancement:**
```yaml
- name: Run Claude Code
  uses: anthropics/claude-code-action@beta
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    claude_api_key: ${{ secrets.CLAUDE_CODE_OAUTH_TOKEN }}
    allowed_tools: "Bash(npm install),Bash(npm test)"
    custom_instructions: "Help with TypeScript development"
```

**After ACE-Flow Enhancement:**
```yaml
- name: Run Claude Code with ACE-Flow
  uses: anthropics/claude-code-action@beta
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    claude_api_key: ${{ secrets.CLAUDE_CODE_OAUTH_TOKEN }}
    allowed_tools: |
      Bash(npm install),
      Bash(npm test),
      Bash(npx amplify *),
      Bash(npx ampx *),
      Bash(aws *),
      WebFetch(*),
      Task(*)
    custom_instructions: |
      Help with TypeScript development
      
      ## 🚀 ACE-Flow Commands Available:
      ### /ace-genesis [idea] - Intelligent project creation
      ### /ace-research [domain] [pattern] - Documentation research  
      ### /ace-implement [name] - Infrastructure-aware implementation
```

### Example 2: Complex Multi-Step Workflow
**Before Enhancement:**
```yaml
name: CI/CD Pipeline
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run Tests
        run: npm test
      - name: Run Claude Code
        uses: anthropics/claude-code-action@beta
        # ... existing configuration
```

**After ACE-Flow Enhancement:**
```yaml
name: CI/CD Pipeline with ACE-Flow
on: [push, pull_request, issues, issue_comment]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run Tests
        run: npm test
      # AWS configuration added
      - name: Configure AWS credentials for ACE-Flow
        uses: aws-actions/configure-aws-credentials@v4
        # ... AWS config
      - name: Run Claude Code with ACE-Flow
        uses: anthropics/claude-code-action@beta
        # ... enhanced configuration
      # Amplify validation added
      - name: Validate Amplify Configuration
        # ... validation steps
```

## 🔍 Detection Implementation

### File Content Analysis
ACE-Flow reads existing workflow files and checks for:

1. **Trigger Events**: Adds `issues` and `issue_comment` if missing
2. **Claude Code Action**: Enhances if present, adds if missing
3. **AWS Configuration**: Adds if missing and ACE-Flow commands used
4. **Tool Permissions**: Extends existing permissions with ACE-Flow tools
5. **Custom Instructions**: Appends ACE-Flow commands to existing instructions

### Intelligent Merging
- **Non-destructive**: Never removes existing functionality
- **Additive**: Only adds new ACE-Flow capabilities
- **Compatible**: Ensures existing workflows continue to work
- **Smart**: Detects conflicts and resolves them gracefully

## 🎯 User Experience

### Seamless Integration
From the user's perspective:

1. **First Time Setup**: Guided to install GitHub App if no workflows exist
2. **Existing Projects**: Automatic enhancement without user intervention
3. **Already Enhanced**: Immediate access to ACE-Flow commands
4. **No Surprises**: Clear communication about what's being enhanced

### Feedback and Transparency
ACE-Flow provides clear feedback:
- "Enhancing existing GitHub workflow with ACE-Flow capabilities..."
- "ACE-Flow integration detected, proceeding with project creation..."
- "No workflows found, please run /install-github-app first..."

## 🚀 Benefits

### For New Projects
- Simple setup with automatic GitHub App installation guidance
- Complete workflow creation with ACE-Flow built-in

### For Existing Projects  
- Non-disruptive enhancement of existing automation
- Preserves all existing functionality while adding ACE-Flow powers
- Immediate access to intelligent project creation capabilities

### For Teams
- Consistent ACE-Flow experience across all repositories
- Easy adoption without changing existing development workflows
- Scalable approach that works with any GitHub Actions configuration

---

*This smart enhancement approach ensures ACE-Flow integrates seamlessly with any existing GitHub setup while providing powerful intelligent project creation capabilities.*