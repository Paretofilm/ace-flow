#!/usr/bin/env ts-node

/**
 * Hook: validate-amplify-syntax
 * Validates AWS Amplify Gen 2 syntax and patterns
 */

import * as fs from 'fs';
import * as path from 'path';

interface ValidationIssue {
  type: 'error' | 'warning';
  line: number;
  column?: number;
  message: string;
  fix?: string;
}

interface ValidationResult {
  valid: boolean;
  issues: ValidationIssue[];
  autoFixAvailable: boolean;
  fixedContent?: string;
}

// Deprecated patterns to check
const DEPRECATED_PATTERNS = [
  {
    pattern: /import\s+{\s*DataStore\s*}\s+from\s+['"]@aws-amplify\/datastore['"]/g,
    message: 'DataStore is deprecated. Use generateClient from aws-amplify/data',
    fix: "import { generateClient } from 'aws-amplify/data'",
  },
  {
    pattern: /Storage\.put\(/g,
    message: 'Storage.put is deprecated. Use uploadData from aws-amplify/storage',
    fix: 'uploadData(',
  },
  {
    pattern: /Storage\.get\(/g,
    message: 'Storage.get is deprecated. Use downloadData from aws-amplify/storage',
    fix: 'downloadData(',
  },
  {
    pattern: /API\.graphql\(/g,
    message: 'API.graphql is deprecated. Use client.models methods',
    fix: 'client.models.ModelName.method(',
  },
  {
    pattern: /@auth\s*\(\s*rules:/g,
    message: '@auth directive is deprecated. Use .authorization() method',
    fix: '.authorization((allow) => [',
  },
  {
    pattern: /import\s+Amplify\s+from\s+['"]aws-amplify['"]/g,
    message: 'Default import is deprecated. Use named import',
    fix: "import { Amplify } from 'aws-amplify'",
  },
];

// Current patterns to enforce
const REQUIRED_PATTERNS = [
  {
    filePattern: /amplify\/auth\/resource\.ts$/,
    requiredImport: /@aws-amplify\/backend/,
    message: 'Auth resource must import from @aws-amplify/backend',
  },
  {
    filePattern: /amplify\/data\/resource\.ts$/,
    requiredImport: /@aws-amplify\/backend/,
    message: 'Data resource must import from @aws-amplify/backend',
  },
];

// Type patterns to validate
const TYPE_PATTERNS = [
  {
    pattern: /generateClient\(\)/g,
    message: 'generateClient should be typed with Schema',
    fix: 'generateClient<Schema>()',
  },
  {
    pattern: /useState\(\[\]\)/g,
    message: 'useState arrays should be typed',
    fix: 'useState<Type[]>([])',
  },
];

function getLineNumber(content: string, match: RegExpMatchArray): number {
  const index = match.index || 0;
  const lines = content.substring(0, index).split('\n');
  return lines.length;
}

function validateContent(filePath: string, content: string): ValidationResult {
  const issues: ValidationIssue[] = [];
  let fixedContent = content;
  let hasAutoFix = false;

  // Check deprecated patterns
  for (const { pattern, message, fix } of DEPRECATED_PATTERNS) {
    const matches = [...content.matchAll(pattern)];
    for (const match of matches) {
      issues.push({
        type: 'error',
        line: getLineNumber(content, match),
        message,
        fix,
      });
      
      if (fix) {
        fixedContent = fixedContent.replace(pattern, fix);
        hasAutoFix = true;
      }
    }
  }

  // Check required patterns
  for (const { filePattern, requiredImport, message } of REQUIRED_PATTERNS) {
    if (filePattern.test(filePath) && !requiredImport.test(content)) {
      issues.push({
        type: 'error',
        line: 1,
        message,
      });
    }
  }

  // Check type patterns (warnings)
  for (const { pattern, message, fix } of TYPE_PATTERNS) {
    const matches = [...content.matchAll(pattern)];
    for (const match of matches) {
      issues.push({
        type: 'warning',
        line: getLineNumber(content, match),
        message,
        fix,
      });
    }
  }

  // Check for console.log in production code
  if (!filePath.includes('.test.') && !filePath.includes('.spec.')) {
    const consoleMatches = [...content.matchAll(/console\.log\(/g)];
    for (const match of consoleMatches) {
      issues.push({
        type: 'warning',
        line: getLineNumber(content, match),
        message: 'Remove console.log from production code',
      });
    }
  }

  return {
    valid: issues.filter(i => i.type === 'error').length === 0,
    issues,
    autoFixAvailable: hasAutoFix,
    fixedContent: hasAutoFix ? fixedContent : undefined,
  };
}

// Main execution
async function main() {
  const filePath = process.argv[2];
  
  if (!filePath) {
    console.error('Usage: validate-amplify-syntax.ts <file-path>');
    process.exit(1);
  }

  try {
    const content = fs.readFileSync(filePath, 'utf-8');
    const result = validateContent(filePath, content);

    // Output results
    console.log(JSON.stringify(result, null, 2));

    // Exit with appropriate code
    process.exit(result.valid ? 0 : 1);
  } catch (error) {
    console.error('Error validating file:', error);
    process.exit(1);
  }
}

// Run if called directly
if (require.main === module) {
  main();
}

// Export for use as module
export { validateContent, ValidationResult, ValidationIssue };