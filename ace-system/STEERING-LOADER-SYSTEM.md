# 🎯 ACE-Flow Steering Loader System

## Overview

The Steering Loader System provides the infrastructure for ACE-Flow commands to load and utilize Kiro-style steering files based on context, file patterns, and inclusion modes.

## System Architecture

### Core Components

```yaml
steering_loader_system:
  components:
    parser:
      - reads_frontmatter: "Extract YAML metadata from steering files"
      - validates_structure: "Ensure steering files have required fields"
      - processes_patterns: "Parse file match patterns for conditional inclusion"
      
    loader:
      - discovers_files: "Find all steering files in .ace-flow/steering/"
      - evaluates_inclusion: "Determine which files to include based on context"
      - caches_content: "Cache parsed steering content for performance"
      
    context_provider:
      - provides_context: "Supply steering context to ACE commands"
      - tracks_usage: "Monitor steering file usage for analytics"
      - updates_content: "Capture learnings back to steering files"
```

## Steering File Format

### Standard Steering File Structure
```markdown
---
inclusion: always|conditional|manual
fileMatchPattern: "glob patterns for conditional inclusion"
description: "What this steering file provides"
lastUpdated: "ISO 8601 timestamp"
version: "semantic version"
priority: high|medium|low
tags: ["research", "architecture", "quality"]
---

# Steering Content Title

[Markdown content providing context and knowledge]
```

### Inclusion Modes Explained

#### Always Included
```yaml
inclusion: always
```
- Loaded for every ACE command interaction
- Use for universal context (architecture decisions, core standards)
- Minimal performance impact due to caching

#### Conditional Inclusion
```yaml
inclusion: conditional
fileMatchPattern: "**/ace-research*,**/research/*,**/docs/*"
```
- Loaded when current context matches patterns
- Pattern matching against:
  - Current command being executed
  - Files being processed
  - Working directory context
- Most common mode for specialized context

#### Manual Inclusion
```yaml
inclusion: manual
```
- Only loaded when explicitly referenced
- Use for specialized or sensitive context
- Reference with `#steering-file-name` in commands

## Implementation Details

### Steering Parser Implementation
```javascript
// Conceptual implementation of steering parser
class SteeringParser {
  constructor() {
    this.cache = new Map();
    this.steeringDir = '.ace-flow/steering/';
  }

  async parseSteeringFile(filePath) {
    if (this.cache.has(filePath)) {
      return this.cache.get(filePath);
    }

    const content = await readFile(filePath, 'utf-8');
    const { frontmatter, body } = this.extractFrontmatter(content);
    
    const steeringFile = {
      path: filePath,
      metadata: this.parseFrontmatter(frontmatter),
      content: body,
      lastLoaded: new Date().toISOString()
    };

    this.cache.set(filePath, steeringFile);
    return steeringFile;
  }

  extractFrontmatter(content) {
    const match = content.match(/^---\n([\s\S]*?)\n---\n([\s\S]*)$/);
    if (!match) {
      throw new Error('Invalid steering file format - missing frontmatter');
    }
    return { frontmatter: match[1], body: match[2] };
  }

  parseFrontmatter(frontmatter) {
    // Parse YAML frontmatter
    return {
      inclusion: 'conditional',
      fileMatchPattern: '',
      description: '',
      lastUpdated: new Date().toISOString(),
      version: '1.0',
      priority: 'medium',
      tags: [],
      ...parseYAML(frontmatter)
    };
  }
}
```

### Steering Loader Implementation
```javascript
// Conceptual implementation of steering loader
class SteeringLoader {
  constructor(parser) {
    this.parser = parser;
    this.activeContext = new Map();
  }

  async loadSteeringContext(command, currentPath, options = {}) {
    const steeringFiles = await this.discoverSteeringFiles();
    const applicableFiles = [];

    for (const file of steeringFiles) {
      const steering = await this.parser.parseSteeringFile(file);
      
      if (this.shouldInclude(steering, command, currentPath, options)) {
        applicableFiles.push(steering);
        this.activeContext.set(steering.path, steering);
      }
    }

    return this.createContextObject(applicableFiles);
  }

  shouldInclude(steering, command, currentPath, options) {
    const { inclusion, fileMatchPattern } = steering.metadata;

    switch (inclusion) {
      case 'always':
        return true;
        
      case 'conditional':
        return this.matchesPattern(fileMatchPattern, command, currentPath);
        
      case 'manual':
        return options.manualIncludes?.includes(steering.path);
        
      default:
        return false;
    }
  }

  matchesPattern(pattern, command, currentPath) {
    const patterns = pattern.split(',').map(p => p.trim());
    const contexts = [command, currentPath, ...this.getAdditionalContexts()];
    
    return patterns.some(pattern => 
      contexts.some(context => minimatch(context, pattern))
    );
  }

  createContextObject(steeringFiles) {
    return {
      files: steeringFiles,
      summary: this.generateContextSummary(steeringFiles),
      analytics: this.captureAnalytics(steeringFiles),
      updateHandler: this.createUpdateHandler(steeringFiles)
    };
  }
}
```

### Context Provider Implementation
```javascript
// Conceptual implementation of context provider
class SteeringContextProvider {
  constructor(loader) {
    this.loader = loader;
    this.analytics = new SteeringAnalytics();
  }

  async provideContext(command, options = {}) {
    const context = await this.loader.loadSteeringContext(
      command,
      process.cwd(),
      options
    );

    // Track usage for analytics
    this.analytics.trackUsage(context);

    // Return enhanced context object
    return {
      ...context,
      display: () => this.displayActiveContext(context),
      update: (updates) => this.updateSteeringFiles(updates),
      effectiveness: () => this.analytics.getEffectiveness(context)
    };
  }

  displayActiveContext(context) {
    console.log('\n🎯 Active Steering Context:');
    context.files.forEach(file => {
      console.log(`  • ${file.metadata.description} (${file.metadata.inclusion})`);
    });
    console.log(`  Total: ${context.files.length} steering files loaded\n`);
  }

  async updateSteeringFiles(updates) {
    for (const update of updates) {
      const { filePath, section, content } = update;
      await this.appendToSection(filePath, section, content);
    }
  }
}
```

## Integration with ACE Commands

### Command Enhancement Pattern
```javascript
// Example: Enhancing ace-research with steering
async function enhancedAceResearch(projectDomain, pattern) {
  // Load steering context
  const steering = await steeringProvider.provideContext('ace-research');
  
  // Display active steering context
  steering.display();
  
  // Use steering to enhance research
  const researchPriorities = extractResearchPriorities(steering);
  const domainKnowledge = extractDomainKnowledge(steering);
  
  // Perform enhanced research
  const results = await performResearch(projectDomain, pattern, {
    priorities: researchPriorities,
    existingKnowledge: domainKnowledge
  });
  
  // Update steering with new learnings
  const learnings = extractLearnings(results);
  await steering.update([
    {
      filePath: '.ace-flow/steering/research-methodology.md',
      section: 'Research Efficiency Improvements',
      content: learnings.efficiencyInsights
    },
    {
      filePath: '.ace-flow/steering/domain-expertise.md',
      section: 'Accumulated Domain Knowledge',
      content: learnings.domainInsights
    }
  ]);
  
  return results;
}
```

### Steering Context Display
```
🎯 Active Steering Context:
  • Research methodology and focus areas (conditional)
  • Accumulated domain knowledge (conditional)
  • Architectural context and decisions (always)
  Total: 3 steering files loaded

📊 Steering Effectiveness: 85% (improving research efficiency)
```

## Analytics and Tracking

### Usage Analytics Structure
```json
{
  "steeringAnalytics": {
    "totalLoads": 145,
    "averageFilesPerLoad": 2.3,
    "fileUsageFrequency": {
      "research-methodology.md": 45,
      "technical-context.md": 38,
      "architecture-decisions.md": 32
    },
    "effectivenessMetrics": {
      "researchEfficiencyGain": "+42%",
      "implementationSpeedIncrease": "+35%",
      "qualityImprovement": "+28%"
    },
    "lastUpdated": "2025-01-22T18:00:00Z"
  }
}
```

### Effectiveness Tracking
- **Load Time**: Track steering file load performance
- **Context Relevance**: Measure how often steering context is utilized
- **Update Frequency**: Track how often steering files are updated with learnings
- **Command Enhancement**: Measure improvement in command effectiveness

## Performance Considerations

### Caching Strategy
- **In-Memory Cache**: Parsed steering files cached during session
- **File Watch**: Monitor steering files for changes
- **Lazy Loading**: Only parse files when needed
- **Batch Updates**: Collect updates and write in batches

### Optimization Techniques
```javascript
// Optimized pattern matching
const patternCache = new Map();

function matchesPatternOptimized(pattern, context) {
  const cacheKey = `${pattern}:${context}`;
  if (patternCache.has(cacheKey)) {
    return patternCache.get(cacheKey);
  }
  
  const result = minimatch(context, pattern);
  patternCache.set(cacheKey, result);
  return result;
}
```

## Error Handling

### Common Error Scenarios
1. **Missing Frontmatter**: Provide clear error message and template
2. **Invalid YAML**: Show parsing error with line numbers
3. **Pattern Syntax Error**: Validate glob patterns and provide examples
4. **File Not Found**: Gracefully handle missing steering files
5. **Permission Issues**: Check file permissions before reading/writing

### Error Recovery
```javascript
async function loadSteeringWithFallback(filePath) {
  try {
    return await parseSteeringFile(filePath);
  } catch (error) {
    console.warn(`Warning: Failed to load steering file ${filePath}`);
    console.warn(`Reason: ${error.message}`);
    
    // Return minimal valid steering object
    return {
      metadata: { inclusion: 'manual', description: 'Failed to load' },
      content: '',
      error: error.message
    };
  }
}
```

## Best Practices

### For Command Integration
1. **Load Early**: Load steering context at command start
2. **Display Context**: Show users what steering is active
3. **Update Continuously**: Capture learnings throughout execution
4. **Handle Failures**: Gracefully degrade if steering unavailable
5. **Track Effectiveness**: Measure steering impact on outcomes

### For Steering File Management
1. **Version Control**: Track steering file changes in git
2. **Regular Updates**: Keep steering files current with learnings
3. **Team Collaboration**: Share steering updates across team
4. **Quality Standards**: Maintain high-quality steering content
5. **Performance Monitoring**: Track steering system performance

---

This steering loader system provides the foundation for making ACE-Flow commands context-aware and self-improving through persistent knowledge capture and reuse.