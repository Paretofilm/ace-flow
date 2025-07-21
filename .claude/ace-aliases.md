# ACE-Flow Command Aliases

This file defines short aliases for ACE-Flow commands to improve developer efficiency.

## Alias Mappings

| Full Command | Primary Alias | Secondary Alias | Description |
|--------------|---------------|-----------------|-------------|
| `/ace-genesis` | `/ag` | `/ace-g` | Create new project |
| `/ace-research` | `/ar` | `/ace-r` | Research documentation |
| `/ace-implement` | `/ai` | `/ace-i` | Implement features |
| `/ace-adopt` | `/aa` | `/ace-a` | Adopt existing project |
| `/ace-status` | `/as` | `/ace-s` | Check progress |
| `/ace-review` | `/arv` | `/ace-rv` | Quality review |
| `/ace-learn` | `/al` | `/ace-l` | Learning system |
| `/ace-help` | `/ah` | `/ace-h` | Help system |
| `/update-docs` | `/ud` | `/docs` | Update documentation |

## Usage Examples

### Quick Project Creation
```bash
# Full command
/ace-genesis "social platform for book lovers"

# With alias
/ag "social platform for book lovers"
```

### Fast Research
```bash
# Full command
/ace-research authentication social_platform

# With alias
/ar authentication social_platform
```

### Status Check
```bash
# Full command
/ace-status

# With alias
/as
```

## Implementation Note

When Claude Code encounters these aliases, it should automatically expand them to the full command name and execute the corresponding slash command file.

For example:
- `/ag` → executes `.claude/ace-genesis.md`
- `/ar` → executes `.claude/ace-research.md`
- `/as` → executes `.claude/ace-status.md`

## Benefits

1. **Faster Development**: Less typing for frequently used commands
2. **Muscle Memory**: Short aliases are easier to remember
3. **Consistency**: Follows common CLI patterns (git, npm, etc.)
4. **Backwards Compatible**: Full commands still work

## Adding New Aliases

To add a new alias:
1. Update this file with the new mapping
2. Ensure the alias doesn't conflict with existing commands
3. Follow the pattern: `/a[first-letter]` for primary aliases
4. Document in `/ace-help` command