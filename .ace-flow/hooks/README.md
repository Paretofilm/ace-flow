# ACE-Flow Hook Automation System

Hooks provide automated quality assurance and workflow optimization throughout the development lifecycle.

## Overview

The ACE-Flow hook system automatically:
- Validates code on save
- Fixes common issues
- Ensures compliance with specifications
- Maintains code quality
- Provides real-time feedback

## Hook Types

### 1. File Save Hooks
Triggered when files are saved in the editor.

### 2. Pre-Commit Hooks  
Run before code is committed to version control.

### 3. Deployment Hooks
Execute during and after deployment processes.

### 4. Error Recovery Hooks
Automatically detect and fix common issues.

## Configuration

Hooks are configured in `.ace-flow/hooks/config.json`:

```json
{
  "hooks": {
    "onFileSave": {
      "enabled": true,
      "patterns": {
        "**/*.ts": ["validate-typescript", "fix-imports"],
        "**/amplify/**/*.ts": ["validate-amplify-syntax"],
        "**/*.tsx": ["validate-react", "check-accessibility"]
      }
    },
    "preCommit": {
      "enabled": true,
      "commands": [
        "npm run lint:fix",
        "npm run type-check",
        "npm test -- --run"
      ]
    },
    "postDeploy": {
      "enabled": true,
      "validations": [
        "check-api-health",
        "verify-auth-flow",
        "test-real-time"
      ]
    },
    "errorRecovery": {
      "enabled": true,
      "autoFix": true,
      "patterns": [
        "import-errors",
        "type-mismatches",
        "amplify-syntax"
      ]
    }
  }
}
```

## Available Hooks

### Validation Hooks
- `validate-typescript` - TypeScript syntax and types
- `validate-amplify-syntax` - AWS Amplify Gen 2 patterns
- `validate-react` - React best practices
- `check-accessibility` - A11y compliance

### Fix Hooks
- `fix-imports` - Organize and fix import statements
- `fix-formatting` - Apply consistent formatting
- `fix-amplify-patterns` - Update to current syntax
- `fix-type-errors` - Resolve common type issues

### Quality Hooks
- `check-security` - Security vulnerability scan
- `check-performance` - Performance anti-patterns
- `check-bundle-size` - Monitor bundle growth
- `check-coverage` - Test coverage requirements

## Hook Scripts

Hooks are implemented as scripts in `.ace-flow/hooks/scripts/`:

### Example: validate-amplify-syntax.ts
```typescript
import { HookContext, HookResult } from '../types';
import { parseFile, findPatterns } from '../utils';

export async function validateAmplifySyntax(
  context: HookContext
): Promise<HookResult> {
  const { filePath, content } = context;
  const issues = [];
  
  // Check for deprecated patterns
  const deprecatedPatterns = [
    { pattern: /DataStore/g, message: 'Use generateClient instead' },
    { pattern: /Storage\.put/g, message: 'Use uploadData instead' },
    { pattern: /@auth\(rules:/g, message: 'Use .authorization() instead' },
  ];
  
  for (const { pattern, message } of deprecatedPatterns) {
    const matches = content.match(pattern);
    if (matches) {
      issues.push({
        type: 'error',
        message,
        line: getLineNumber(content, pattern),
        fix: getFixSuggestion(pattern),
      });
    }
  }
  
  return {
    valid: issues.length === 0,
    issues,
    autoFixAvailable: true,
  };
}
```

### Example: fix-imports.ts
```typescript
export async function fixImports(
  context: HookContext
): Promise<HookResult> {
  const { content } = context;
  
  // Fix Amplify imports
  let fixed = content
    .replace(
      /import \* as Amplify from ['"]aws-amplify['"]/g,
      "import { Amplify } from 'aws-amplify'"
    )
    .replace(
      /import { DataStore } from ['"]@aws-amplify\/datastore['"]/g,
      "import { generateClient } from 'aws-amplify/data'"
    );
  
  // Organize imports
  fixed = organizeImports(fixed);
  
  return {
    valid: true,
    fixedContent: fixed,
    message: 'Imports updated to current patterns',
  };
}
```

## Integration with Agents

Hooks work seamlessly with ACE-Flow agents:

### Agent Awareness
Agents are notified of hook results:
```typescript
// Implementation agent receives hook feedback
if (hookResult.issues.length > 0) {
  await handleHookIssues(hookResult.issues);
}
```

### Continuous Validation
Hooks provide real-time validation during implementation:
```typescript
// Validation agent uses hook results
const validationStatus = await runHooks('validate', {
  files: implementedFiles,
  phase: 'implementation',
});
```

## Custom Hooks

Create custom hooks for project-specific needs:

### 1. Define Hook Function
```typescript
// .ace-flow/hooks/custom/check-business-logic.ts
export async function checkBusinessLogic(
  context: HookContext
): Promise<HookResult> {
  // Custom validation logic
}
```

### 2. Register in Config
```json
{
  "hooks": {
    "onFileSave": {
      "patterns": {
        "**/business/**/*.ts": ["check-business-logic"]
      }
    }
  }
}
```

### 3. Add to Steering
Document patterns in steering files for team awareness.

## Performance Optimization

Hooks are optimized for speed:
- Async execution
- Smart caching
- Incremental validation
- Parallel processing

## Error Handling

Hooks never block development:
- Graceful failure
- Clear error messages
- Optional auto-fix
- Manual override available

## Monitoring

Track hook performance and effectiveness:
```json
{
  "metrics": {
    "totalRuns": 1523,
    "issuesFound": 234,
    "autoFixed": 189,
    "averageTime": "45ms"
  }
}
```

## Best Practices

1. **Keep hooks fast** - Target <100ms execution
2. **Make fixes safe** - Never break working code
3. **Provide context** - Clear messages and suggestions
4. **Allow overrides** - Developers can disable when needed
5. **Log actions** - Track what hooks do for debugging

## Disabling Hooks

Temporarily disable hooks when needed:
```bash
# Disable all hooks
ACE_HOOKS_DISABLED=true npm run dev

# Disable specific hook
ACE_SKIP_HOOKS=validate-typescript,fix-imports npm run dev
```

---

The hook system ensures code quality without slowing down development. Hooks are your automated quality assurance team, working silently in the background to maintain high standards.