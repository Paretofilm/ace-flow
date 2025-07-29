# ACE-Flow Testing Memory

## 🧠 CRITICAL TESTING KNOWLEDGE

### The #1 Rule: ACE-Flow is a Submodule System

**NEVER** test ACE-Flow commands directly in the ace-flow repository itself. This fundamental misunderstanding will cause all tests to fail.

## ✅ Correct Testing Procedure (MEMORIZE THIS)

```bash
# 1. Create project OUTSIDE ace-flow
cd ~/any-directory-outside-ace-flow
mkdir test-project
cd test-project

# 2. Initialize git
git init

# 3. Add ACE-Flow as submodule
git submodule add https://github.com/Paretofilm/ace-flow.git .ace-flow

# 4. Install command aliases
bash .ace-flow/scripts/install-ace-flow-aliases.sh

# 5. NOW test commands
/ace "your test"
/ag "your app idea"
```

## 🚫 What NOT to Do

### DON'T Test in ACE-Flow Directory
```bash
# WRONG - This will never work
cd ace-flow
/ace "test"  # FAILS - No aliases installed here
```

### DON'T Skip Installation
```bash
# WRONG - Missing critical step
git submodule add <url> .ace-flow
/ace "test"  # FAILS - Aliases not installed
```

### DON'T Try Direct Execution
```bash
# WRONG - Bypasses alias system
cd .ace-flow/.claude
./ace.md  # Not how it works!
```

## 🎯 Quick Testing Checklist

Before ANY ACE-Flow test:
1. **Ask**: "Am I in a project with ACE-Flow as a submodule?"
2. **Check**: `ls -la .claude/` - Do aliases exist?
3. **Verify**: `ls -la .ace-flow/` - Is submodule present?
4. **Confirm**: `cat .gitmodules` - Is submodule registered?

## 💡 Why This Architecture?

1. **Separation**: Keeps ACE-Flow system separate from user code
2. **Updates**: Easy to update via `git submodule update`
3. **Versions**: Projects can lock to specific ACE-Flow versions
4. **Learning**: ACE-Flow improvements can be contributed back

## 🔍 Common Test Scenarios

### Testing New Commands
1. Add command to `.ace-flow/.claude/`
2. Update `install-ace-flow-aliases.sh` to include it
3. Create test project with submodule
4. Run installation script
5. Test the new command

### Testing Agent Changes
1. Modify agent in `.ace-flow/.claude/agents/`
2. Create test project with submodule
3. Install aliases
4. Invoke agent through proper command

### Testing Kiro Enhancements
1. Check if `/ace` exists in `.ace-flow/.claude/`
2. Verify installation script includes `ace:ace` mapping
3. Test in submodule project after installation

## 📝 Testing Log Template

When testing ACE-Flow:
```markdown
## Test: [Feature Name]
Date: [Date]
Location: [Path to test project - NOT ace-flow]
Submodule: ✅ Installed at .ace-flow
Aliases: ✅ Installed via script
Command: /[command] "[test input]"
Result: [What happened]
```

## 🧪 Future Testing Reminders

1. **Document submodule setup** in EVERY test log
2. **Include installation verification** in test procedures
3. **Test OUTSIDE ace-flow directory** always
4. **Update this memory** when new testing insights emerge

## 🚨 Red Flags That You're Testing Wrong

- Working in `/ace-flow/` directory
- No `.claude/` directory with aliases
- No `.gitmodules` file
- Commands returning "not found"
- Trying to run `.md` files directly

## ✨ The Golden Path

```bash
mkdir my-test && cd my-test
git init
git submodule add [ace-flow-url] .ace-flow
bash .ace-flow/scripts/install-ace-flow-aliases.sh
# NOW you can test!
```

**Remember**: ACE-Flow enhances OTHER projects. Test it IN those projects, not by itself.