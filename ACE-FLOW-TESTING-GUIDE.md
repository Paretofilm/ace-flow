# ACE-Flow Testing Guide

## 🚨 CRITICAL: Testing Must Use Submodule Architecture

**DO NOT** test ACE-Flow commands directly in the ace-flow repository. This will not work because:
1. Commands need to be installed as aliases via the installation script
2. The system is designed to work as a submodule in user projects
3. Direct execution bypasses the entire alias resolution system

## ✅ Correct Testing Procedure

### Step 1: Create Test Project OUTSIDE ACE-Flow

```bash
# Navigate OUTSIDE the ace-flow repository
cd ~/projects  # or any directory outside ace-flow
mkdir my-test-app
cd my-test-app
git init
```

### Step 2: Add ACE-Flow as Submodule

```bash
# For testing with main repository
git submodule add https://github.com/Paretofilm/ace-flow.git .ace-flow

# Or use your fork
git submodule add https://github.com/YourUsername/ace-flow.git .ace-flow
```

### Step 3: Install Command Aliases

```bash
# Make installation script executable
chmod +x .ace-flow/scripts/install-ace-flow-aliases.sh

# Run installation
bash .ace-flow/scripts/install-ace-flow-aliases.sh
```

This creates the following structure:
```
my-test-app/
├── .ace-flow/              # ACE-Flow submodule
│   └── .claude/           # Original commands
├── .claude/               # Your command aliases (created by installer)
│   ├── ace-genesis.md → ../.ace-flow/.claude/ace-genesis.md
│   ├── ace.md → ../.ace-flow/.claude/ace.md
│   ├── ag.md             # Short alias
│   └── ...
└── .gitmodules           # Submodule configuration
```

### Step 4: Test Commands

Now you can test ACE-Flow commands:

```bash
# Test natural language interface
/ace "create a recipe sharing app"

# Test genesis command
/ag "I want to build a recipe app"

# Test short aliases
/ar  # Research
/ai  # Implement
/as  # Status
```

## 🧪 Testing Scenarios

### 1. New Project Test
```bash
cd ~/test-directory
mkdir new-app-test
cd new-app-test
git init
git submodule add <ace-flow-url> .ace-flow
bash .ace-flow/scripts/install-ace-flow-aliases.sh
/ace "create a todo app with authentication"
```

### 2. Existing Project Adoption Test
```bash
cd ~/existing-project
git submodule add <ace-flow-url> .ace-flow
bash .ace-flow/scripts/install-ace-flow-aliases.sh
/aa  # Adopt existing project
```

### 3. Command Alias Test
```bash
# After installation, verify all aliases work
/ag   # Should work
/ace  # Should work if Kiro enhancement is installed
/aag  # Agent control (if available)
```

### 4. Update Test
```bash
cd .ace-flow
git pull origin main
cd ..
bash .ace-flow/scripts/install-ace-flow-aliases.sh --update
```

## 🚫 Common Mistakes to Avoid

### Mistake 1: Testing in ACE-Flow Directory
```bash
# WRONG - Don't do this
cd ace-flow
/ace "test"  # Won't work!
```

### Mistake 2: Forgetting Installation Script
```bash
# WRONG - Missing installation step
git submodule add <url> .ace-flow
/ag "test"  # Won't work without installation!
```

### Mistake 3: Using Wrong Command Path
```bash
# WRONG
/.ace-flow/.claude/ace-genesis.md  # Don't reference submodule directly

# RIGHT
/ag  # Use installed alias
```

## 📋 Testing Checklist

Before testing any ACE-Flow functionality:

- [ ] Created test directory OUTSIDE ace-flow repo
- [ ] Initialized git in test directory
- [ ] Added ACE-Flow as submodule
- [ ] Ran installation script
- [ ] Verified `.claude/` directory exists with aliases
- [ ] Checked that aliases are symlinks (on Unix/Mac) or copies (on Windows)

## 🔍 Debugging Test Issues

### Issue: "Command not found"
**Solution**: Check if installation script was run and `.claude/` exists

### Issue: "No such file or directory"
**Solution**: Ensure you're in the project root, not in `.ace-flow/`

### Issue: Commands seem outdated
**Solution**: Update submodule and re-run installation:
```bash
cd .ace-flow && git pull && cd ..
bash .ace-flow/scripts/install-ace-flow-aliases.sh --update
```

### Issue: Aliases not working on Windows
**Solution**: Installation script creates copies instead of symlinks on Windows. Ensure script detected OS correctly.

## 🎯 Testing the Kiro-Enhanced System

To test the new Kiro-enhanced natural language interface:

1. Check if `/ace` command exists after installation
2. Test natural language input: `/ace "build a social media app"`
3. Verify agent orchestration works
4. Check if steering files are loaded correctly

## 📊 Expected Test Results

### Successful Test:
- All aliases created in `.claude/`
- Commands respond when invoked
- Natural language interface understands intent
- Agents execute in correct sequence
- Files are created in the project (not in .ace-flow)

### Failed Test Indicators:
- "Command not found" errors
- Files created in wrong location
- Aliases pointing to non-existent files
- Agent orchestration failures

## 🔄 Continuous Testing

For ongoing ACE-Flow development:

1. **Always test changes** in a separate project using submodule
2. **Document new commands** in the installation script
3. **Update this guide** when testing procedures change
4. **Create test cases** for new functionality

## 💡 Testing Memory

To ensure you don't repeat testing mistakes:

1. **Before ANY test**: Ask yourself "Am I in a project with ACE-Flow as a submodule?"
2. **Check installation**: Run `ls -la .claude/` to verify aliases exist
3. **Read this guide**: When in doubt, refer back to this document

---

Remember: ACE-Flow is a development tool that enhances other projects. It must be tested in the context of those projects, not in isolation.