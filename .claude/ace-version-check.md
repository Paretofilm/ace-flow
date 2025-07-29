# /ace-version-check - Amplify Gen 2 & Next.js Compatibility Management

Ensure your project always uses the most compatible versions of Next.js with AWS Amplify Gen 2.

## Command Syntax

```bash
/ace-version-check [options]
```

## Core Features

### 1. Compatibility Check
Verify current project versions are compatible:

```bash
# Basic compatibility check
/ace-version-check

# Check with latest versions from NPM
/ace-version-check --latest

# Generate detailed report
/ace-version-check --report
```

### 2. Automatic Updates
Update to compatible versions automatically:

```bash
# Update to recommended versions
/ace-version-check --update

# Update with yarn instead of npm
/ace-version-check --update --yarn

# Preview changes without updating
/ace-version-check --dry-run
```

### 3. Continuous Monitoring
Set up automated version checking:

```bash
# Add to pre-commit hooks
/ace-version-check --install-hooks

# CI/CD integration
/ace-version-check --ci
```

## Version Compatibility Matrix

### Current Compatibility (as of January 2025)

| AWS Amplify Gen 2 | Recommended Next.js | Min Next.js | Max Next.js | Notes |
|-------------------|-------------------|-------------|-------------|--------|
| 2.2.0+ | 14.2.16 | 14.1.4 | 14.2.x | Full App Router support |
| 2.1.0 | 14.1.4 | 14.0.0 | 14.2.x | Stable App Router |
| 2.0.0 | 14.0.4 | 13.5.0 | 14.1.x | Initial Gen 2 release |

### Feature Compatibility

- **App Router**: Full support in Next.js 14.0+
- **Server Components**: Partial support (client components for Auth UI)
- **Middleware**: Full support with Edge runtime
- **Image Optimization**: Works with Amplify Storage

## Command Examples

### Basic Compatibility Check
```bash
# ACE-Flow Context: Check version compatibility
Check if the current Next.js version in this project is compatible with AWS Amplify Gen 2.

Display:
1. Current versions of Next.js and AWS Amplify
2. Compatibility status (compatible/incompatible)
3. Recommended Next.js version for current Amplify
4. Any known issues or warnings
5. Suggested actions if incompatible

Use the version compatibility matrix to determine the best Next.js version for the installed AWS Amplify version.
```

### Auto-Update to Compatible Version
```bash
# ACE-Flow Context: Update to compatible Next.js
The project is using an incompatible version of Next.js with AWS Amplify Gen 2.

Perform the following:
1. Backup current package.json
2. Determine the recommended Next.js version for current Amplify
3. Update package.json with compatible version
4. Run npm/yarn install to update dependencies
5. Verify compatibility after update
6. Run basic tests to ensure nothing broke

Ensure the update maintains all existing functionality while improving Amplify compatibility.
```

### Generate Compatibility Report
```bash
# ACE-Flow Context: Generate version compatibility report
Create a comprehensive compatibility report for the project including:

1. **Current State**
   - Installed versions of all Amplify and Next.js packages
   - Compatibility status for each combination
   - Feature support matrix

2. **Recommendations**
   - Suggested version updates
   - Migration steps if needed
   - Timeline for updates

3. **Risk Assessment**
   - Breaking changes between versions
   - Impact on existing features
   - Testing requirements

4. **Future Planning**
   - Upcoming version releases
   - Long-term support considerations
   - Deprecation warnings

Save the report as both JSON and markdown formats.
```

## Integration with ACE-Flow Commands

### Pre-Genesis Validation
```bash
# Check compatibility before project creation
/ace-genesis social_platform
# Automatically runs version check
```

### Pre-Implementation Check
```bash
# Verify versions before implementing features
/ace-implement --feature="real-time-chat"
# Warns if versions might cause issues
```

### CI/CD Integration
```yaml
# .github/workflows/version-check.yml
- name: Check Version Compatibility
  run: npx ace-version-check --ci --fail-on-incompatible
```

## Automated Hooks

### Pre-Commit Hook
```bash
#!/bin/bash
# .git/hooks/pre-commit

# Check version compatibility
ace-version-check --quiet || {
  echo "❌ Version compatibility check failed"
  echo "Run 'ace-version-check --update' to fix"
  exit 1
}
```

### Post-Install Hook
```json
{
  "scripts": {
    "postinstall": "ace-version-check --warn-only"
  }
}
```

## Advanced Features

### Version Pinning
```json
// ace-flow.config.json
{
  "versionManagement": {
    "strategy": "compatible", // or "latest", "pinned"
    "nextjs": {
      "pin": "14.2.16",
      "allowPatch": true,
      "allowMinor": false
    },
    "amplify": {
      "minVersion": "6.8.0",
      "trackBeta": false
    }
  }
}
```

### Compatibility Testing
```bash
# Test app with different version combinations
/ace-version-check --test-matrix

# Test specific version
/ace-version-check --test-with nextjs@14.1.4
```

### Migration Assistance
```bash
# Get migration guide for version update
/ace-version-check --migration-guide

# Auto-migrate code for new versions
/ace-version-check --auto-migrate
```

## Monitoring & Alerts

### Slack Integration
```bash
# Set up version monitoring alerts
/ace-version-check --setup-alerts --slack-webhook="https://..."
```

### Email Notifications
```bash
# Weekly compatibility reports
/ace-version-check --schedule weekly --email="team@example.com"
```

## Troubleshooting

### Common Issues

1. **Peer Dependency Warnings**
   ```bash
   # Fix peer dependencies
   /ace-version-check --fix-peers
   ```

2. **Version Conflicts**
   ```bash
   # Resolve version conflicts
   /ace-version-check --resolve-conflicts
   ```

3. **Cache Issues**
   ```bash
   # Clear version cache
   /ace-version-check --clear-cache
   ```

## Best Practices

### 1. Regular Checks
Run version checks:
- Before starting new features
- After package updates
- In CI/CD pipelines
- Weekly in development

### 2. Conservative Updates
- Test thoroughly after updates
- Update in development first
- Use exact versions in production
- Keep compatibility matrix updated

### 3. Documentation
- Document version decisions
- Track compatibility issues
- Share team knowledge
- Update ACE-Flow docs

## Output Examples

### Success Output
```
✅ ACE-Flow Version Compatibility Check
=====================================

Current Versions:
├── Next.js: 14.2.16
└── AWS Amplify: 6.8.0

Status: ✅ Fully Compatible

Features Supported:
├── App Router: ✅
├── Server Components: ✅ (partial)
├── API Routes: ✅
└── Static Export: ✅

No action required. Your versions are optimal for AWS Amplify Gen 2.
```

### Warning Output
```
⚠️  ACE-Flow Version Compatibility Check
=====================================

Current Versions:
├── Next.js: 13.4.0
└── AWS Amplify: 6.8.0

Status: ⚠️  Update Recommended

Issues:
├── App Router support is experimental in Next.js 13.4
├── Some Amplify features may not work correctly
└── Security updates available in newer versions

Recommended Action:
Run: ace-version-check --update
This will update Next.js to 14.2.16 (recommended)
```

### Error Output
```
❌ ACE-Flow Version Compatibility Check
=====================================

Current Versions:
├── Next.js: 12.3.0
└── AWS Amplify: 6.8.0

Status: ❌ Incompatible

Critical Issues:
├── Next.js 12.x is not supported with Amplify Gen 2
├── App Router is not available
└── Many Gen 2 features will not work

Required Action:
1. Backup your project
2. Run: ace-version-check --update --force
3. Review migration guide: ace-version-check --migration-guide
4. Test thoroughly after update
```

This command ensures your ACE-Flow projects always use the most compatible versions of Next.js with AWS Amplify Gen 2, preventing compatibility issues and ensuring optimal performance.