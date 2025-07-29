/**
 * Amplify Gen 2 Pattern Validator
 * Ensures discovered patterns are 100% Gen 2 compatible
 */

interface ValidationResult {
  isValid: boolean;
  isGen2: boolean;
  score: number;
  issues: string[];
  suggestions: string[];
}

interface PatternCheck {
  pattern: RegExp;
  message: string;
  severity: 'error' | 'warning';
}

export class AmplifyGen2Validator {
  // Gen 1 patterns that must NEVER appear
  private gen1Patterns: PatternCheck[] = [
    {
      pattern: /import\s*{\s*API\s*}\s*from\s*['"]aws-amplify['"]/,
      message: 'Gen 1 import detected: API from aws-amplify',
      severity: 'error'
    },
    {
      pattern: /import\s*{\s*Auth\s*}\s*from\s*['"]aws-amplify['"]/,
      message: 'Gen 1 import detected: Auth from aws-amplify',
      severity: 'error'
    },
    {
      pattern: /import\s*{\s*Storage\s*}\s*from\s*['"]aws-amplify['"]/,
      message: 'Gen 1 import detected: Storage from aws-amplify',
      severity: 'error'
    },
    {
      pattern: /graphqlOperation/,
      message: 'Gen 1 graphqlOperation detected',
      severity: 'error'
    },
    {
      pattern: /amplify\s+(add|push|pull|init|delete|update|remove)/,
      message: 'Gen 1 CLI command detected',
      severity: 'error'
    },
    {
      pattern: /aws-exports\.js/,
      message: 'Gen 1 aws-exports.js reference detected',
      severity: 'error'
    },
    {
      pattern: /@model|@auth|@connection|@key/,
      message: 'Gen 1 GraphQL directives detected',
      severity: 'error'
    }
  ];

  // Gen 2 patterns that SHOULD appear
  private gen2Patterns: PatternCheck[] = [
    {
      pattern: /import\s*{\s*generateClient\s*}\s*from\s*['"]aws-amplify\/data['"]/,
      message: 'Gen 2 data client import',
      severity: 'warning'
    },
    {
      pattern: /import\s*{\s*signIn\s*,?\s*signOut\s*,?\s*signUp\s*}\s*from\s*['"]aws-amplify\/auth['"]/,
      message: 'Gen 2 auth imports',
      severity: 'warning'
    },
    {
      pattern: /import\s*{\s*uploadData\s*,?\s*downloadData\s*}\s*from\s*['"]aws-amplify\/storage['"]/,
      message: 'Gen 2 storage imports',
      severity: 'warning'
    },
    {
      pattern: /defineAuth|defineData|defineStorage|defineFunction/,
      message: 'Gen 2 define functions',
      severity: 'warning'
    },
    {
      pattern: /a\.schema|a\.model|a\.string|a\.integer/,
      message: 'Gen 2 schema builder',
      severity: 'warning'
    },
    {
      pattern: /npx\s+ampx/,
      message: 'Gen 2 CLI command',
      severity: 'warning'
    }
  ];

  // Required imports for specific features
  private featureImports: Record<string, RegExp[]> = {
    auth: [
      /import\s*{[^}]*}\s*from\s*['"]aws-amplify\/auth['"]/,
      /import\s*{[^}]*}\s*from\s*['"]@aws-amplify\/ui-react['"]/
    ],
    data: [
      /import\s*{\s*generateClient\s*}\s*from\s*['"]aws-amplify\/data['"]/,
      /import\s*type\s*{\s*Schema\s*}\s*from/
    ],
    storage: [
      /import\s*{[^}]*}\s*from\s*['"]aws-amplify\/storage['"]/
    ]
  };

  /**
   * Validate a code snippet for Gen 2 compatibility
   */
  validateCode(code: string, feature?: string): ValidationResult {
    const result: ValidationResult = {
      isValid: true,
      isGen2: true,
      score: 100,
      issues: [],
      suggestions: []
    };

    // Check for Gen 1 patterns (automatic failure)
    for (const check of this.gen1Patterns) {
      if (check.pattern.test(code)) {
        result.isValid = false;
        result.isGen2 = false;
        result.score = 0;
        result.issues.push(`❌ ${check.message}`);
      }
    }

    // If Gen 1 detected, return immediately
    if (!result.isGen2) {
      result.suggestions.push('This code uses Gen 1 patterns and must be completely rewritten for Gen 2');
      return result;
    }

    // Check for Gen 2 patterns (increase confidence)
    let gen2PatternCount = 0;
    for (const check of this.gen2Patterns) {
      if (check.pattern.test(code)) {
        gen2PatternCount++;
      }
    }

    // Calculate Gen 2 confidence score
    if (gen2PatternCount === 0) {
      result.score = 50;
      result.suggestions.push('No Gen 2 patterns detected. Verify this is Amplify Gen 2 code.');
    } else {
      result.score = Math.min(100, 50 + (gen2PatternCount * 10));
    }

    // Check feature-specific imports if feature is specified
    if (feature && this.featureImports[feature]) {
      const hasRequiredImports = this.featureImports[feature].some(pattern => 
        pattern.test(code)
      );
      
      if (!hasRequiredImports) {
        result.score -= 20;
        result.issues.push(`⚠️ Missing required imports for ${feature} feature`);
        result.suggestions.push(`Add Gen 2 imports for ${feature}`);
      }
    }

    // Additional quality checks
    this.performQualityChecks(code, result);

    return result;
  }

  /**
   * Perform additional quality checks
   */
  private performQualityChecks(code: string, result: ValidationResult): void {
    // Check for TypeScript
    if (!code.includes('type ') && !code.includes('interface ') && !code.includes(': ')) {
      result.score -= 10;
      result.suggestions.push('Consider using TypeScript for better type safety');
    }

    // Check for error handling
    if (code.includes('await ') && !code.includes('try') && !code.includes('catch')) {
      result.score -= 5;
      result.suggestions.push('Add error handling for async operations');
    }

    // Check for modular imports
    if (code.includes('from "aws-amplify"') && !code.includes('aws-amplify/')) {
      result.score -= 15;
      result.issues.push('⚠️ Use modular imports (aws-amplify/auth) instead of main package');
    }

    // Adjust final validity based on score
    if (result.score < 70) {
      result.isValid = false;
    }
  }

  /**
   * Validate a configuration object
   */
  validateConfiguration(config: any): ValidationResult {
    const result: ValidationResult = {
      isValid: true,
      isGen2: true,
      score: 100,
      issues: [],
      suggestions: []
    };

    // Check for Gen 2 configuration patterns
    const configString = JSON.stringify(config);
    
    // Must have Gen 2 patterns
    if (!configString.includes('defineAuth') && 
        !configString.includes('defineData') && 
        !configString.includes('defineStorage')) {
      result.isGen2 = false;
      result.isValid = false;
      result.issues.push('❌ No Gen 2 configuration patterns found');
    }

    // Must NOT have Gen 1 patterns
    if (configString.includes('aws-exports') || 
        configString.includes('amplify-meta')) {
      result.isGen2 = false;
      result.isValid = false;
      result.issues.push('❌ Gen 1 configuration detected');
    }

    return result;
  }

  /**
   * Extract and validate imports from code
   */
  validateImports(code: string): ValidationResult {
    const result: ValidationResult = {
      isValid: true,
      isGen2: true,
      score: 100,
      issues: [],
      suggestions: []
    };

    // Extract all import statements
    const importRegex = /import\s+(?:{[^}]*}|.*?)\s+from\s+['"]([^'"]+)['"]/g;
    const imports: string[] = [];
    let match;

    while ((match = importRegex.exec(code)) !== null) {
      imports.push(match[1]);
    }

    // Check each import
    for (const imp of imports) {
      if (imp === 'aws-amplify') {
        result.isValid = false;
        result.isGen2 = false;
        result.issues.push(`❌ Non-modular import detected: ${imp}`);
        result.suggestions.push(`Use modular imports like 'aws-amplify/auth' instead`);
      }
      
      if (imp.includes('aws-amplify/') && imp.includes('lib-')) {
        result.isValid = false;
        result.isGen2 = false;
        result.issues.push(`❌ Gen 1 lib import detected: ${imp}`);
      }
    }

    return result;
  }

  /**
   * Suggest Gen 2 alternatives for Gen 1 patterns
   */
  suggestGen2Alternative(gen1Code: string): string {
    const replacements: [RegExp, string][] = [
      // API replacements
      [/API\.graphql\(graphqlOperation\((.*?),\s*({.*?})\)\)/g, 
       'client.models.$1.create($2)'],
      [/import\s*{\s*API\s*}\s*from\s*['"]aws-amplify['"]/, 
       "import { generateClient } from 'aws-amplify/data'"],
      
      // Auth replacements
      [/Auth\.signIn\((.*?)\)/, 'signIn($1)'],
      [/Auth\.signOut\(\)/, 'signOut()'],
      [/Auth\.signUp\((.*?)\)/, 'signUp($1)'],
      [/import\s*{\s*Auth\s*}\s*from\s*['"]aws-amplify['"]/, 
       "import { signIn, signOut, signUp } from 'aws-amplify/auth'"],
      
      // Storage replacements
      [/Storage\.put\((.*?)\)/, 'uploadData($1)'],
      [/Storage\.get\((.*?)\)/, 'downloadData($1)'],
      [/import\s*{\s*Storage\s*}\s*from\s*['"]aws-amplify['"]/, 
       "import { uploadData, downloadData } from 'aws-amplify/storage'"],
       
      // CLI replacements
      [/amplify\s+push/, 'npx ampx sandbox'],
      [/amplify\s+init/, 'npm create amplify@latest'],
      [/amplify\s+add\s+auth/, 'Create defineAuth() in amplify/auth/resource.ts'],
      [/amplify\s+add\s+storage/, 'Create defineStorage() in amplify/storage/resource.ts']
    ];

    let gen2Code = gen1Code;
    for (const [pattern, replacement] of replacements) {
      gen2Code = gen2Code.replace(pattern, replacement);
    }

    return gen2Code;
  }
}

// Export singleton instance
export const validator = new AmplifyGen2Validator();