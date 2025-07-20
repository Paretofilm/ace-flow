# Update-Docs: Documentation Maintenance Command

**Automated documentation updating and maintenance system for ACE-Flow documentation library.**

## 🔄 Command Overview

The `/update-docs` command maintains the ACE-Flow documentation library by fetching the latest framework documentation, validating content freshness, and ensuring comprehensive coverage for both human developers and AI code analysis.

## 🎯 Usage

### Basic Commands
```bash
# Update all documentation
/update-docs

# Update specific framework
/update-docs amplify-gen2
/update-docs nextjs
/update-docs amplify-ui

# Update with validation
/update-docs --validate

# Generate coverage report
/update-docs --coverage

# Dry run (check what would be updated)
/update-docs --dry-run

# Force update (bypass freshness checks)
/update-docs --force
```

### Advanced Options
```bash
# Update with custom source validation
/update-docs --validate-sources

# Update and generate diff report
/update-docs --diff

# Update specific documentation sections
/update-docs amplify-gen2 --sections="data-modeling,authentication"

# Update with specific version targeting
/update-docs nextjs --version="14.x"

# Update integration documentation
/update-docs integrations --services="stripe,sendgrid"
```

## 🔧 Update Process

### Phase 1: Source Analysis
```yaml
Source_Discovery:
  frameworks:
    amplify_gen2:
      primary_source: "https://docs.amplify.aws/gen2/"
      api_endpoint: "https://api.github.com/repos/aws-amplify/amplify-backend"
      version_check: "package.json#version"
      
    nextjs:
      primary_source: "https://nextjs.org/docs"
      api_endpoint: "https://api.github.com/repos/vercel/next.js"
      version_check: "package.json#version"
      
    amplify_ui:
      primary_source: "https://ui.docs.amplify.aws/"
      api_endpoint: "https://api.github.com/repos/aws-amplify/amplify-ui"
      version_check: "package.json#version"

  validation_checks:
    - source_availability: "Verify source URLs are accessible"
    - version_freshness: "Check for newer framework versions"
    - content_changes: "Detect significant documentation updates"
    - broken_links: "Validate all internal and external links"
```

### Phase 2: Content Fetching
```python
class DocumentationFetcher:
    def __init__(self, framework: str, config: dict):
        self.framework = framework
        self.config = config
        self.session = requests.Session()
        
    async def fetch_documentation_set(self) -> dict:
        """
        Fetch complete documentation set for framework
        """
        documentation = {}
        
        for section in self.config['sections']:
            try:
                content = await self.fetch_section(section)
                processed_content = self.process_content(content)
                documentation[section['name']] = processed_content
                
            except Exception as e:
                self.handle_fetch_error(section, e)
                
        return documentation
    
    async def fetch_section(self, section: dict) -> str:
        """
        Fetch individual documentation section
        """
        url = f"{self.config['primary_source']}{section['path']}"
        
        response = await self.session.get(url)
        response.raise_for_status()
        
        # Extract content from HTML/Markdown
        content = self.extract_content(response.text, section['format'])
        
        return content
    
    def process_content(self, content: str) -> dict:
        """
        Process and structure content for ACE-Flow usage
        """
        return {
            'content': content,
            'code_examples': self.extract_code_examples(content),
            'api_references': self.extract_api_references(content),
            'best_practices': self.extract_best_practices(content),
            'gotchas': self.extract_gotchas(content),
            'last_updated': datetime.now().isoformat(),
        }
```

### Phase 3: Content Processing
```typescript
interface DocumentationProcessor {
  framework: string;
  sourceContent: RawDocumentation;
  
  processForACEFlow(): ProcessedDocumentation;
  extractCodePatterns(): CodePattern[];
  identifyGotchas(): Gotcha[];
  validateCompleteness(): ValidationResult;
}

class AmplifyDocProcessor implements DocumentationProcessor {
  processForACEFlow(): ProcessedDocumentation {
    return {
      gettingStarted: this.processGettingStarted(),
      dataModeling: this.processDataModeling(),
      authentication: this.processAuthentication(),
      storage: this.processStorage(),
      realTime: this.processRealTime(),
      deployment: this.processDeployment(),
      
      // Extract patterns for AI optimization
      codePatterns: this.extractCodePatterns(),
      commonGotchas: this.identifyGotchas(),
      integrationPoints: this.mapIntegrationPoints(),
      
      metadata: {
        sourceVersion: this.getSourceVersion(),
        lastUpdated: new Date().toISOString(),
        coverage: this.calculateCoverage(),
        aiOptimized: true,
      },
    };
  }
  
  extractCodePatterns(): CodePattern[] {
    // Extract reusable code patterns from documentation
    const patterns: CodePattern[] = [];
    
    // Schema definition patterns
    patterns.push(...this.extractSchemaPatterns());
    
    // Authorization patterns
    patterns.push(...this.extractAuthPatterns());
    
    // Query patterns
    patterns.push(...this.extractQueryPatterns());
    
    return patterns;
  }
}
```

### Phase 4: Integration with Existing Docs
```yaml
Integration_Strategy:
  preservation:
    - "Always backup existing documentation before updates"
    - "Preserve custom modifications and local additions"
    - "Maintain ACE-Flow specific patterns and examples"
    
  merging:
    - "Merge new official patterns with existing curated content"
    - "Update outdated examples while preserving custom ones"
    - "Resolve conflicts between official docs and ACE-Flow enhancements"
    
  validation:
    - "Ensure all ACE-Flow specific examples still work"
    - "Validate that custom patterns align with new official guidance"
    - "Check that AI optimization annotations remain relevant"
```

## 📊 Quality Assurance

### Content Validation
```typescript
interface ValidationCheck {
  name: string;
  description: string;
  run(): Promise<ValidationResult>;
}

class ContentValidationSuite {
  private checks: ValidationCheck[] = [
    new LinkValidation(),
    new CodeExampleValidation(),
    new APIReferenceValidation(),
    new CompletenessCheck(),
    new FreshnessCheck(),
    new AIOptimizationCheck(),
  ];
  
  async runAllChecks(): Promise<ValidationReport> {
    const results = await Promise.all(
      this.checks.map(check => check.run())
    );
    
    return {
      overall: results.every(r => r.passed) ? 'passed' : 'failed',
      checks: results,
      summary: this.generateSummary(results),
      recommendations: this.generateRecommendations(results),
    };
  }
}

class CodeExampleValidation implements ValidationCheck {
  async run(): Promise<ValidationResult> {
    const codeBlocks = this.extractAllCodeBlocks();
    const validationResults = await Promise.all(
      codeBlocks.map(block => this.validateCodeBlock(block))
    );
    
    const failedBlocks = validationResults.filter(r => !r.valid);
    
    return {
      name: 'Code Example Validation',
      passed: failedBlocks.length === 0,
      details: {
        totalBlocks: codeBlocks.length,
        validBlocks: validationResults.length - failedBlocks.length,
        failedBlocks: failedBlocks.map(b => b.error),
      },
    };
  }
  
  private async validateCodeBlock(block: CodeBlock): Promise<CodeValidationResult> {
    try {
      // Syntax validation
      if (block.language === 'typescript') {
        await this.validateTypeScript(block.code);
      }
      
      // Pattern validation
      await this.validateAgainstKnownPatterns(block);
      
      // Dependency validation
      await this.validateDependencies(block);
      
      return { valid: true };
    } catch (error) {
      return { 
        valid: false, 
        error: error.message,
        block: block.id,
      };
    }
  }
}
```

### Freshness Monitoring
```typescript
class FreshnessMonitor {
  async checkDocumentationFreshness(): Promise<FreshnessReport> {
    const frameworks = ['amplify-gen2', 'nextjs', 'amplify-ui'];
    
    const freshnessChecks = await Promise.all(
      frameworks.map(async (framework) => {
        const currentVersion = await this.getCurrentVersion(framework);
        const latestVersion = await this.getLatestVersion(framework);
        const lastUpdate = await this.getLastUpdateTime(framework);
        
        return {
          framework,
          currentVersion,
          latestVersion,
          isUpToDate: currentVersion === latestVersion,
          daysSinceUpdate: this.getDaysSince(lastUpdate),
          updateUrgency: this.calculateUrgency(currentVersion, latestVersion, lastUpdate),
        };
      })
    );
    
    return {
      overallStatus: this.calculateOverallStatus(freshnessChecks),
      frameworks: freshnessChecks,
      recommendations: this.generateUpdateRecommendations(freshnessChecks),
    };
  }
  
  private calculateUrgency(current: string, latest: string, lastUpdate: Date): 'low' | 'medium' | 'high' {
    const versionGap = this.calculateVersionGap(current, latest);
    const daysSinceUpdate = this.getDaysSince(lastUpdate);
    
    if (versionGap >= 2 || daysSinceUpdate > 90) return 'high';
    if (versionGap >= 1 || daysSinceUpdate > 30) return 'medium';
    return 'low';
  }
}
```

## 🔄 Automation Features

### Scheduled Updates
```yaml
Automation_Schedule:
  daily_checks:
    time: "06:00 UTC"
    actions:
      - "Check for critical security updates"
      - "Validate external links"
      - "Monitor source documentation changes"
      
  weekly_updates:
    day: "Sunday"
    time: "02:00 UTC"
    actions:
      - "Full freshness check across all frameworks"
      - "Update documentation if minor versions available"
      - "Generate weekly freshness report"
      
  monthly_maintenance:
    day: "First Sunday"
    time: "02:00 UTC"
    actions:
      - "Complete documentation refresh"
      - "Comprehensive validation sweep"
      - "Coverage analysis and gap identification"
      - "AI optimization review and enhancement"
```

### CI/CD Integration
```typescript
// .github/workflows/update-docs.yml
export const updateDocsWorkflow = {
  name: 'Update Documentation',
  on: {
    schedule: [
      { cron: '0 6 * * *' }, // Daily at 6 AM UTC
    ],
    workflow_dispatch: {
      inputs: {
        framework: {
          description: 'Framework to update',
          required: false,
          default: 'all',
          type: 'choice',
          options: ['all', 'amplify-gen2', 'nextjs', 'amplify-ui'],
        },
        force: {
          description: 'Force update',
          required: false,
          default: false,
          type: 'boolean',
        },
      },
    },
  },
  jobs: {
    'update-docs': {
      'runs-on': 'ubuntu-latest',
      steps: [
        {
          name: 'Checkout',
          uses: 'actions/checkout@v4',
        },
        {
          name: 'Setup Node.js',
          uses: 'actions/setup-node@v4',
          with: {
            'node-version': '18',
          },
        },
        {
          name: 'Run documentation update',
          run: 'npm run update-docs -- ${{ github.event.inputs.framework }}',
        },
        {
          name: 'Create PR if changes',
          uses: 'peter-evans/create-pull-request@v5',
          with: {
            title: 'docs: Update framework documentation',
            body: 'Automated documentation update from update-docs workflow',
            branch: 'docs/automated-update',
          },
        },
      ],
    },
  },
};
```

## 📋 Coverage Matrix Management

### Coverage Tracking
```typescript
interface CoverageMatrix {
  frameworks: {
    [framework: string]: {
      coreDocumentation: number; // Percentage complete
      advancedFeatures: number;
      integrationGuides: number;
      bestPractices: number;
      troubleshooting: number;
      lastUpdated: string;
      version: string;
    };
  };
  patterns: {
    [pattern: string]: {
      completeness: number;
      examples: number;
      integrations: number;
    };
  };
  overall: {
    completeness: number;
    aiOptimization: number;
    freshness: number;
  };
}

class CoverageAnalyzer {
  async generateCoverageMatrix(): Promise<CoverageMatrix> {
    const frameworks = await this.analyzeFrameworkCoverage();
    const patterns = await this.analyzePatternCoverage();
    const overall = await this.calculateOverallMetrics();
    
    return { frameworks, patterns, overall };
  }
  
  private async analyzeFrameworkCoverage() {
    const frameworks = ['amplify-gen2', 'nextjs', 'amplify-ui'];
    const coverage = {};
    
    for (const framework of frameworks) {
      coverage[framework] = {
        coreDocumentation: await this.calculateCoreDocCoverage(framework),
        advancedFeatures: await this.calculateAdvancedCoverage(framework),
        integrationGuides: await this.calculateIntegrationCoverage(framework),
        bestPractices: await this.calculateBestPracticesCoverage(framework),
        troubleshooting: await this.calculateTroubleshootingCoverage(framework),
        lastUpdated: await this.getLastUpdateTime(framework),
        version: await this.getCurrentVersion(framework),
      };
    }
    
    return coverage;
  }
}
```

## 🎯 Expected Outcomes

### After Running `/update-docs`
```yaml
Documentation_State:
  freshness:
    - "All framework documentation current with latest versions"
    - "Breaking changes identified and documented"
    - "Deprecated patterns flagged for removal"
    
  quality:
    - "All code examples validated and working"
    - "External links verified and functional"
    - "API references accurate and complete"
    
  completeness:
    - "Coverage gaps identified and addressed"
    - "Missing integration guides added"
    - "Best practices updated with latest recommendations"
    
  ai_optimization:
    - "Content structured for optimal Claude Opus analysis"
    - "Code patterns formatted for AI extraction"
    - "Context annotations maintained and enhanced"
```

### Generated Reports
```markdown
# Documentation Update Report

## Summary
- **Frameworks Updated**: 3/3
- **New Documentation**: 12 pages
- **Updated Documentation**: 8 pages
- **Validation Issues**: 2 resolved
- **Coverage Improvement**: +5.2%

## Framework Status
### AWS Amplify Gen 2
- **Version**: 2.1.3 → 2.2.0
- **Status**: ✅ Updated
- **Changes**: New authentication patterns, updated data modeling guide

### Next.js
- **Version**: 14.1.0 → 14.1.4
- **Status**: ✅ Updated
- **Changes**: Performance optimizations, new caching strategies

## Action Items
- [ ] Review new Amplify authentication patterns
- [ ] Update architecture pattern examples
- [ ] Validate custom ACE-Flow integrations

## Next Update: 2024-02-01
```

---

*The `/update-docs` command ensures ACE-Flow documentation remains current, comprehensive, and optimized for both human developers and AI code analysis.*

**Usage**: Run weekly or when framework updates are detected  
**Automation**: Integrated with CI/CD for hands-off maintenance  
**Quality**: Comprehensive validation and coverage tracking