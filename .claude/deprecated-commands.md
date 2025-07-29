# Deprecated ACE-Flow Commands

**These commands have been replaced by the simplified Context7-enhanced workflow.**

## ❌ **Deprecated Commands**

### Replaced by `/ace new` (ace-spec new)
- **`/ace-genesis`** → Use `/ace new "your idea"` instead
- **`/ag`** → Use `/ace new` instead

### Replaced by `/ace review` (ace-spec review)
- **`/ace-status`** → Use `/ace review` instead  
- **`/as`** → Use `/ace review` instead

### Replaced by `/ace implement` (ace-spec implement)
- **`/ace-implement`** → Use `/ace implement` instead
- **`/ai`** → Use `/ace implement` instead

### Replaced by `/ace-agent research`
- **`/ace-research`** → Use `/ace-agent research [topic]` instead
- **`/ar`** → Use `/aag research` instead

### Replaced by `/ace validate` (ace-spec validate)
- **`/ace-validate`** → Use `/ace validate` instead
- **`/av`** → Use `/ace validate` instead

## ✅ **Current Simplified Commands**

### Primary Workflow (90% of usage)
```bash
/ace new "your app idea"     # Specification-driven project creation
/ace review                  # Progress and compliance monitoring  
/ace implement              # Parallel agent implementation
/ace validate               # Specification compliance checking
```

### Agent Control (when needed)
```bash
/aag research "topic"       # Deep research into AWS patterns
/aag validate --strict      # Comprehensive quality checks
/aag parallel frontend backend  # Multiple concurrent agents
```

### Legacy Support (still available)
```bash
/ace-adopt                  # Migrate existing projects
/ace-cost                   # AWS cost estimation
/ace-rollback              # Recovery operations
/ace-help                  # Documentation access
```

## 🔄 **Migration Guide**

### Old Workflow → New Workflow
```bash
# OLD: Complex multi-step process
/ace-genesis "fitness app"      # ❌ Deprecated
/ace-research auth social       # ❌ Deprecated  
/ace-implement fitness-tracker  # ❌ Deprecated
/ace-status                     # ❌ Deprecated
/ace-validate                   # ❌ Deprecated

# NEW: Simplified workflow  
/ace new "fitness app"          # ✅ Creates specs + research + plan
/ace implement                  # ✅ Parallel agents build everything
/ace review                     # ✅ Shows progress + compliance
```

### Command Mapping
| Old Command | New Equivalent | Enhancement |
|-------------|----------------|-------------|
| `/ace-genesis` | `/ace new` | + EARS notation + verified AWS syntax |
| `/ace-research` | `/aag research` | + Context7 enhanced patterns |
| `/ace-implement` | `/ace implement` | + Parallel agents + real-time progress |
| `/ace-status` | `/ace review` | + Specification compliance tracking |
| `/ace-validate` | `/ace validate` | + Zero-hallucination validation |

## 📊 **Benefits of New Commands**

### Simplified Learning
- **3 main commands** instead of 16
- **Natural language** works everywhere
- **Progressive disclosure** - complexity only when needed

### Enhanced Capabilities  
- **Zero hallucinations** - all examples verified
- **Current AWS syntax** - updated for 2025
- **Parallel execution** - 3x faster implementation
- **Specification compliance** - built-in quality

### Better Developer Experience
```bash
# One command does it all:
/ace new "recipe sharing app with real-time comments"

# Automatically generates:
# ✅ Verified AWS Amplify Gen 2 architecture
# ✅ EARS notation requirements  
# ✅ Working TypeScript code
# ✅ Parallel implementation plan
# ✅ Continuous compliance monitoring
```

## 🗑️ **Cleanup Recommendation**

These files can be safely removed once migration is complete:
- `ace-genesis.md` (replaced by ace-spec new)
- `ace-research.md` (replaced by ace-agent research)  
- `ace-implement.md` (replaced by ace-spec implement)
- Old aliases: `ag.md`, `ar.md`, `ai.md` (update to point to new commands)

## 🚀 **Next Steps**

1. **Start using new commands**: `/ace new "your idea"`
2. **Update team documentation** with new workflow
3. **Update CI/CD scripts** to use new command syntax
4. **Train team** on simplified 3-command workflow

The enhanced ACE-Flow provides the same powerful capabilities with dramatically improved usability and accuracy.