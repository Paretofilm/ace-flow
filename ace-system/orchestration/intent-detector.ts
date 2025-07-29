/**
 * ACE-Flow Intent Detection System
 * Analyzes natural language input to determine developer intent and complexity
 */

export enum IntentType {
  Information = 'information',
  Action = 'action',
  Debug = 'debug',
  Optimization = 'optimization',
  Specification = 'specification'
}

export enum Complexity {
  Simple = 'simple',
  Medium = 'medium', 
  Complex = 'complex'
}

export interface DetectedIntent {
  primary: IntentType;
  secondary?: IntentType[];
  confidence: number;
  complexity: Complexity;
  entities: {
    features?: string[];
    technologies?: string[];
    files?: string[];
    errors?: string[];
  };
  suggestedMode: 'vibe' | 'spec';
}

export interface ContextReference {
  type: 'file' | 'folder' | 'steering' | 'mcp' | 'url' | 'codebase' | 'amplify';
  value: string;
}

export class IntentDetector {
  // Intent patterns
  private readonly intentPatterns = {
    information: [
      /\b(explain|how does|what is|why|describe|understand|tell me about)\b/i,
      /\b(documentation|docs|help)\b/i,
      /\?$/ // Questions
    ],
    action: [
      /\b(create|add|implement|build|generate|make|develop|setup|configure)\b/i,
      /\b(integrate|connect|deploy)\b/i,
      /\b(new|initialize)\b/i
    ],
    debug: [
      /\b(fix|error|bug|issue|problem|not working|broken|failing|debug)\b/i,
      /\b(troubleshoot|resolve|solve)\b/i,
      /error:|exception:|failed:/i
    ],
    optimization: [
      /\b(optimize|faster|improve|enhance|refactor|reduce|performance)\b/i,
      /\b(efficiency|speed up|cache|cost)\b/i,
      /\b(scale|scaling)\b/i
    ],
    specification: [
      /\b(app|application|platform|system|website|service)\b/i,
      /\b(full|complete|entire)\b/i,
      /\b(e-commerce|social media|blog|dashboard|marketplace)\b/i
    ]
  };

  // Complexity indicators
  private readonly complexityIndicators = {
    simple: [
      /\b(simple|basic|just|only|quick)\b/i,
      /\b(single|one|a |an )\b/i
    ],
    complex: [
      /\b(complex|complicated|advanced|full|complete|entire)\b/i,
      /\b(multiple|many|several|various)\b/i,
      /\b(real-?time|websocket|streaming)\b/i,
      /\b(microservice|distributed|scalable)\b/i
    ]
  };

  // Technology keywords
  private readonly technologies = [
    'amplify', 'cognito', 'dynamodb', 's3', 'lambda', 'api gateway',
    'react', 'next.js', 'typescript', 'graphql', 'rest',
    'authentication', 'storage', 'database', 'serverless'
  ];

  /**
   * Detect intent from natural language input
   */
  detectIntent(input: string): DetectedIntent {
    const normalizedInput = input.toLowerCase();
    
    // Extract context references
    const contexts = this.extractContextReferences(input);
    
    // Detect primary intent
    const intentScores = this.scoreIntents(normalizedInput);
    const primary = this.selectPrimaryIntent(intentScores);
    
    // Detect secondary intents
    const secondary = this.detectSecondaryIntents(intentScores, primary);
    
    // Assess complexity
    const complexity = this.assessComplexity(normalizedInput, primary);
    
    // Extract entities
    const entities = this.extractEntities(normalizedInput);
    
    // Determine suggested mode
    const suggestedMode = this.suggestMode(primary, complexity, normalizedInput);
    
    // Calculate confidence
    const confidence = this.calculateConfidence(intentScores, primary);
    
    return {
      primary,
      secondary: secondary.length > 0 ? secondary : undefined,
      confidence,
      complexity,
      entities,
      suggestedMode
    };
  }

  /**
   * Extract context references from input
   */
  extractContextReferences(input: string): ContextReference[] {
    const references: ContextReference[] = [];
    
    // Pattern for #context:value
    const contextPattern = /#(\w+)(?::([^\s]+))?/g;
    let match;
    
    while ((match = contextPattern.exec(input)) !== null) {
      const type = match[1] as any;
      const value = match[2] || '';
      references.push({ type, value });
    }
    
    return references;
  }

  /**
   * Score each intent type based on pattern matching
   */
  private scoreIntents(input: string): Record<IntentType, number> {
    const scores: Record<IntentType, number> = {
      [IntentType.Information]: 0,
      [IntentType.Action]: 0,
      [IntentType.Debug]: 0,
      [IntentType.Optimization]: 0,
      [IntentType.Specification]: 0
    };
    
    // Score each intent
    for (const [intent, patterns] of Object.entries(this.intentPatterns)) {
      for (const pattern of patterns) {
        if (pattern.test(input)) {
          scores[intent as IntentType] += 1;
        }
      }
    }
    
    // Boost specification score for long, complex requests
    if (input.length > 100 && scores[IntentType.Specification] > 0) {
      scores[IntentType.Specification] += 2;
    }
    
    return scores;
  }

  /**
   * Select primary intent based on scores
   */
  private selectPrimaryIntent(scores: Record<IntentType, number>): IntentType {
    let maxScore = 0;
    let primaryIntent = IntentType.Information;
    
    for (const [intent, score] of Object.entries(scores)) {
      if (score > maxScore) {
        maxScore = score;
        primaryIntent = intent as IntentType;
      }
    }
    
    // Default to action if no clear winner and seems actionable
    if (maxScore === 0) {
      return IntentType.Action;
    }
    
    return primaryIntent;
  }

  /**
   * Detect secondary intents
   */
  private detectSecondaryIntents(
    scores: Record<IntentType, number>, 
    primary: IntentType
  ): IntentType[] {
    const secondary: IntentType[] = [];
    
    for (const [intent, score] of Object.entries(scores)) {
      if (intent !== primary && score > 0) {
        secondary.push(intent as IntentType);
      }
    }
    
    return secondary;
  }

  /**
   * Assess complexity of the request
   */
  private assessComplexity(input: string, primaryIntent: IntentType): Complexity {
    // Check for explicit complexity indicators
    for (const pattern of this.complexityIndicators.simple) {
      if (pattern.test(input)) {
        return Complexity.Simple;
      }
    }
    
    for (const pattern of this.complexityIndicators.complex) {
      if (pattern.test(input)) {
        return Complexity.Complex;
      }
    }
    
    // Assess based on length and intent
    if (input.length < 50) {
      return Complexity.Simple;
    } else if (input.length > 150 || primaryIntent === IntentType.Specification) {
      return Complexity.Complex;
    }
    
    // Count mentioned features/technologies
    const techCount = this.technologies.filter(tech => 
      input.toLowerCase().includes(tech)
    ).length;
    
    if (techCount >= 3) {
      return Complexity.Complex;
    } else if (techCount >= 2) {
      return Complexity.Medium;
    }
    
    return Complexity.Medium;
  }

  /**
   * Extract entities from input
   */
  private extractEntities(input: string): DetectedIntent['entities'] {
    const entities: DetectedIntent['entities'] = {};
    
    // Extract features
    const featurePattern = /\b(authentication|payment|chat|messaging|upload|search|notification)\b/gi;
    const features = input.match(featurePattern);
    if (features) {
      entities.features = [...new Set(features.map(f => f.toLowerCase()))];
    }
    
    // Extract technologies
    entities.technologies = this.technologies.filter(tech => 
      input.toLowerCase().includes(tech)
    );
    
    // Extract file references
    const filePattern = /\b(\w+\.(ts|tsx|js|jsx|json|md))\b/g;
    const files = input.match(filePattern);
    if (files) {
      entities.files = files;
    }
    
    // Extract error keywords
    const errorPattern = /\b(error|exception|failed|timeout|undefined|null)\b/gi;
    const errors = input.match(errorPattern);
    if (errors) {
      entities.errors = [...new Set(errors.map(e => e.toLowerCase()))];
    }
    
    return entities;
  }

  /**
   * Suggest interaction mode based on intent and complexity
   */
  private suggestMode(
    primary: IntentType, 
    complexity: Complexity,
    input: string
  ): 'vibe' | 'spec' {
    // Explicit spec request
    if (input.includes('spec ')) {
      return 'spec';
    }
    
    // Specification intent or complex requests need spec mode
    if (primary === IntentType.Specification || complexity === Complexity.Complex) {
      return 'spec';
    }
    
    // Multiple features mentioned
    const featureCount = (input.match(/\b(and|with|plus|also)\b/gi) || []).length;
    if (featureCount >= 2) {
      return 'spec';
    }
    
    // Default to vibe for quick tasks
    return 'vibe';
  }

  /**
   * Calculate confidence score
   */
  private calculateConfidence(
    scores: Record<IntentType, number>,
    primary: IntentType
  ): number {
    const totalScore = Object.values(scores).reduce((sum, score) => sum + score, 0);
    const primaryScore = scores[primary];
    
    if (totalScore === 0) {
      return 0.5; // No clear patterns, medium confidence
    }
    
    // Confidence based on how dominant the primary intent is
    const confidence = primaryScore / totalScore;
    
    // Boost confidence if primary score is high
    if (primaryScore >= 3) {
      return Math.min(0.95, confidence + 0.1);
    }
    
    return Math.max(0.6, confidence);
  }

  /**
   * Analyze request and provide structured guidance
   */
  analyzeRequest(input: string): {
    intent: DetectedIntent;
    contexts: ContextReference[];
    recommendation: string;
  } {
    const intent = this.detectIntent(input);
    const contexts = this.extractContextReferences(input);
    
    // Generate recommendation
    let recommendation = '';
    
    if (intent.suggestedMode === 'spec') {
      recommendation = 'This request would benefit from a structured specification workflow. Consider using spec mode for comprehensive planning and implementation.';
    } else if (intent.confidence < 0.7) {
      recommendation = 'The intent is somewhat unclear. Consider providing more specific details about what you want to achieve.';
    } else {
      recommendation = `Detected ${intent.primary} intent with ${intent.complexity} complexity. Ready to proceed in ${intent.suggestedMode} mode.`;
    }
    
    return {
      intent,
      contexts,
      recommendation
    };
  }
}

// Export singleton instance
export const intentDetector = new IntentDetector();