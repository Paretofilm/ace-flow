# ACE-Flow Submodule Setup Guide

This guide explains how to use ACE-Flow as a git submodule in your projects, enabling easy updates and contribution back to the ACE-Flow ecosystem.

## Why Use ACE-Flow as a Submodule?

### Benefits
1. **Clean Separation**: Keep ACE-Flow system separate from your project code
2. **Easy Updates**: Pull latest ACE-Flow improvements with simple git commands
3. **Contribute Back**: Share your improvements with the ACE-Flow community
4. **Version Control**: Lock to specific ACE-Flow versions for stability
5. **Learning Integration**: ACE-Flow's self-learning can flow back to benefit everyone

### Traditional Approach vs Submodule Approach

**Traditional (Copy)**:
```bash
git clone https://github.com/Paretofilm/ace-flow.git my-app
rm -rf .git  # Loses connection to ACE-Flow
```

**Submodule (Recommended)**:
```bash
mkdir my-app && cd my-app
git init
git submodule add https://github.com/YourUsername/ace-flow.git .ace-flow
```

## Step-by-Step Setup

### 1. Fork ACE-Flow (Recommended)

First, fork the ACE-Flow repository on GitHub to your account. This allows you to:
- Track your improvements
- Submit pull requests
- Maintain your customizations

```bash
# Go to https://github.com/Paretofilm/ace-flow
# Click "Fork" button
# This creates https://github.com/YourUsername/ace-flow
```

### 2. Create Your Project with ACE-Flow Submodule

```bash
# Create new project directory
mkdir my-awesome-app
cd my-awesome-app

# Initialize git
git init

# Add ACE-Flow as a submodule (use your fork)
git submodule add https://github.com/YourUsername/ace-flow.git .ace-flow

# Initialize the submodule
git submodule update --init --recursive
```

### 3. Install ACE-Flow Command Aliases

Run the installation script to create convenient aliases:

```bash
# Make the script executable
chmod +x .ace-flow/scripts/install-ace-flow-aliases.sh

# Run installation
bash .ace-flow/scripts/install-ace-flow-aliases.sh
```

This creates:
```
.claude/
├── ace-genesis.md    → ../.ace-flow/.claude/ace-genesis.md
├── ace-research.md   → ../.ace-flow/.claude/ace-research.md
├── ace-implement.md  → ../.ace-flow/.claude/ace-implement.md
├── ag.md            → ace-genesis.md (short alias)
├── ar.md            → ace-research.md
└── ai.md            → ace-implement.md
```

### 4. Initialize Your AWS Amplify Project

```bash
# Create Amplify Gen 2 project
npm create amplify@latest

# Follow the prompts to set up your project
```

### 5. Start Using ACE-Flow

With aliases installed, use short commands:

```bash
# Start your project with ACE-Flow
/ag "I want to build a fitness tracking app"

# Research phase (automatic or manual)
/ar fitness_app social_platform

# Implementation
/ai my_fitness_app

# Check status
/as
```

## Working with the Submodule

### Updating ACE-Flow

```bash
# Navigate to submodule
cd .ace-flow

# Fetch latest changes
git fetch origin

# Checkout specific version or latest
git checkout main
git pull origin main

# Return to project root
cd ..

# Update submodule reference in your project
git add .ace-flow
git commit -m "Updated ACE-Flow to latest version"

# Refresh command aliases
/ace-flow-install --update
```

### Contributing Improvements Back

When ACE-Flow learns something new in your project:

```bash
# Navigate to submodule
cd .ace-flow

# Create feature branch
git checkout -b improve-social-auth-handling

# Make your improvements
# ... edit files ...

# Commit changes
git add .
git commit -m "feat: Improved social authentication error handling"

# Push to your fork
git push origin improve-social-auth-handling

# Create pull request to original ACE-Flow
gh pr create --repo Paretofilm/ace-flow \
  --title "Improved social auth handling" \
  --body "Discovered better pattern while building fitness app"

# Return to project
cd ..
```

### Locking to Specific Version

For production stability:

```bash
cd .ace-flow
git checkout v1.2.0  # or specific commit hash
cd ..
git add .ace-flow
git commit -m "Lock ACE-Flow to v1.2.0"
```

## Project Structure with Submodule

```
my-awesome-app/
├── .ace-flow/                 # ACE-Flow submodule (don't edit directly)
│   ├── .claude/              # ACE-Flow commands
│   ├── commands/             # Command implementations
│   ├── genesis/              # Project creation system
│   └── workflows/            # ACE methodology
├── .claude/                   # Your command aliases (created by installer)
│   ├── ace-genesis.md        # Links to submodule
│   ├── ag.md                 # Short alias
│   └── [your-custom].md      # Your project-specific commands
├── amplify/                   # AWS Amplify backend
├── src/                       # Your application code
├── .gitmodules               # Submodule configuration
└── package.json              # Your project dependencies
```

## Learning Flow Integration

### How Learning Flows Back

1. **Local Learning**: ACE-Flow improves within your project
2. **Capture in Submodule**: Changes are made in `.ace-flow/`
3. **Feature Branch**: Create branch for your improvements
4. **Pull Request**: Submit PR to share with community
5. **Community Benefit**: Everyone gets your improvements

### Example Learning Scenario

```bash
# ACE-Flow encounters new AWS rate limit pattern
# It learns and updates its implementation approach

cd .ace-flow
git checkout -b fix-dynamodb-rate-limits

# ACE-Flow has updated files in .learning/
git add .learning/solutions/dynamodb-rate-limits.md
git add .claude/ace-implement.md

git commit -m "fix: Handle DynamoDB rate limits in high-traffic scenarios"
git push origin fix-dynamodb-rate-limits

# Create PR with learning details
gh pr create --repo Paretofilm/ace-flow
```

## Best Practices

### DO:
- Fork ACE-Flow before using as submodule
- Keep submodule updated regularly
- Contribute meaningful improvements back
- Use the alias installer for convenience
- Document your learning experiences

### DON'T:
- Edit files directly in `.ace-flow/` without branching
- Commit sensitive project data to ACE-Flow
- Skip the installation script
- Forget to update aliases after submodule updates

## Troubleshooting

### Submodule Not Initialized
```bash
git submodule update --init --recursive
```

### Aliases Not Working
```bash
# Re-run installation
bash .ace-flow/scripts/install-ace-flow-aliases.sh --update
```

### Can't Push to Submodule
```bash
# Make sure you're using your fork
cd .ace-flow
git remote -v  # Should show your fork
git remote set-url origin https://github.com/YourUsername/ace-flow.git
```

### Merge Conflicts in Submodule
```bash
cd .ace-flow
git checkout main
git pull origin main
# Resolve conflicts
git add .
git commit
cd ..
```

## Advanced Usage

### Multiple ACE-Flow Versions

Manage different ACE-Flow versions across projects:

```bash
# In project A (stable)
cd project-a/.ace-flow
git checkout v1.0.0

# In project B (latest)
cd project-b/.ace-flow
git checkout main
```

### Custom Learning Aggregation

For teams managing multiple projects:

```bash
# Create learning aggregation script
cat > aggregate-learnings.sh << 'EOF'
#!/bin/bash
# Collect learnings from all projects
for project in */; do
  if [ -d "$project/.ace-flow/.learning" ]; then
    cp -r "$project/.ace-flow/.learning/"* ./aggregated-learning/
  fi
done
EOF
```

## Conclusion

Using ACE-Flow as a submodule provides the perfect balance between:
- **Stability**: Lock versions for production
- **Innovation**: Easy updates to latest features
- **Contribution**: Share improvements with community
- **Convenience**: Short command aliases

Start with:
```bash
git submodule add https://github.com/YourUsername/ace-flow.git .ace-flow
bash .ace-flow/scripts/install-ace-flow-aliases.sh
/ag "Your amazing idea"
```

Happy building with ACE-Flow!