# 📦 Deprecated ACE-Flow Commands

These commands have been deprecated in favor of the refined Kiro-enhanced workflow that prioritizes natural language interaction and developer productivity.

## Why These Commands Were Deprecated

The new ACE-Flow system focuses on:
- **Natural language first** - Most interactions through chat interface
- **Unified workflows** - Fewer, more powerful commands
- **Smart automation** - Hooks and steering handle repetitive tasks
- **Parallel execution** - Agents work simultaneously in background

## Deprecated Commands and Their Replacements

### `/ace-genesis` → `/ace spec`
- Genesis functionality is now part of the unified spec workflow
- Use `/ace spec "your app idea"` to start a new project

### `/ace-implement` → `/ace spec` (implementation phase)
- Implementation is now Phase 3 of the spec workflow
- Agents handle implementation automatically based on specs

### `/ace-status` → `/ace spec` (built-in tracking)
- Status tracking is now integrated into the spec workflow
- Real-time progress visualization shows current state

### `/ace-spec-check` → Automated validation
- Specification validation happens automatically
- Hooks ensure continuous compliance

### `/ace-research` → Research agent (automatic)
- Research happens transparently when needed
- Use `#mcp:firecrawl` for manual research needs

### `/ace-learn` → Steering files
- Learning capture moved to steering files
- Create `.ace-flow/steering/` files for persistent knowledge

### `/ace-errors` → Hook automation
- Error handling is automated through hooks
- File save hooks validate and fix common issues

### `/ace-aliases` → Not needed
- Natural language interface eliminates need for aliases
- Core commands are already concise

### `/ace-scrape` → MCP tools
- Web scraping handled by Firecrawl MCP
- Use `#mcp:firecrawl` in chat for scraping needs

## Migration Guide

If you were using these commands, here's how to adapt:

1. **Starting new projects**: Use `/ace spec "project idea"`
2. **Implementation**: Let the spec workflow handle it
3. **Status checks**: View progress in spec interface
4. **Research**: Happens automatically or use `#mcp:firecrawl`
5. **Learning**: Add to steering files
6. **Error handling**: Automated through hooks

## Still Need These Commands?

These commands are preserved here for reference. If you have a specific use case that requires them, you can still access them with their full path:

```bash
/deprecated/ace-genesis
```

However, we strongly recommend adapting to the new workflow for better productivity.