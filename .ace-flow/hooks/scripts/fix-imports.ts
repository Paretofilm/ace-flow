#!/usr/bin/env ts-node

/**
 * Hook: fix-imports
 * Automatically fixes and organizes import statements
 */

import * as fs from 'fs';

interface ImportGroup {
  react: string[];
  next: string[];
  amplify: string[];
  external: string[];
  internal: string[];
  relative: string[];
  types: string[];
}

interface FixResult {
  success: boolean;
  fixedContent?: string;
  message: string;
}

// Import replacements for AWS Amplify
const IMPORT_REPLACEMENTS = [
  // Amplify core
  {
    pattern: /import\s+Amplify\s+from\s+['"]aws-amplify['"]/g,
    replacement: "import { Amplify } from 'aws-amplify'",
  },
  // DataStore to client
  {
    pattern: /import\s+{\s*DataStore\s*}\s+from\s+['"]@aws-amplify\/datastore['"]/g,
    replacement: "import { generateClient } from 'aws-amplify/data'",
  },
  // Storage API updates
  {
    pattern: /import\s+{\s*Storage\s*}\s+from\s+['"]@aws-amplify\/storage['"]/g,
    replacement: "import { uploadData, downloadData, remove, list } from 'aws-amplify/storage'",
  },
  // Auth API updates
  {
    pattern: /import\s+{\s*Auth\s*}\s+from\s+['"]@aws-amplify\/auth['"]/g,
    replacement: "import { signIn, signOut, signUp, getCurrentUser } from 'aws-amplify/auth'",
  },
  // API updates
  {
    pattern: /import\s+{\s*API\s*,?\s*graphqlOperation\s*}\s+from\s+['"]@aws-amplify\/api['"]/g,
    replacement: "import { generateClient } from 'aws-amplify/data'",
  },
];

function categorizeImport(importLine: string): keyof ImportGroup {
  if (importLine.includes('react')) return 'react';
  if (importLine.includes('next/')) return 'next';
  if (importLine.includes('aws-amplify') || importLine.includes('@aws-amplify')) return 'amplify';
  if (importLine.includes('type ') || importLine.includes('interface ')) return 'types';
  if (importLine.startsWith("import './") || importLine.startsWith('import "../')) return 'relative';
  if (importLine.includes('@/') || importLine.includes('~/')) return 'internal';
  return 'external';
}

function parseImports(content: string): { imports: ImportGroup; restContent: string } {
  const lines = content.split('\n');
  const imports: ImportGroup = {
    react: [],
    next: [],
    amplify: [],
    external: [],
    internal: [],
    relative: [],
    types: [],
  };
  
  let inImportSection = true;
  let restStartIndex = 0;
  
  for (let i = 0; i < lines.length; i++) {
    const line = lines[i].trim();
    
    // Skip empty lines and comments in import section
    if (inImportSection && (line === '' || line.startsWith('//'))) {
      continue;
    }
    
    // Check if we're still in import section
    if (inImportSection && line.startsWith('import ')) {
      const category = categorizeImport(line);
      imports[category].push(lines[i]); // Keep original formatting
    } else if (inImportSection && line !== '') {
      // First non-import, non-empty line
      inImportSection = false;
      restStartIndex = i;
      break;
    }
  }
  
  const restContent = lines.slice(restStartIndex).join('\n');
  return { imports, restContent };
}

function organizeImports(imports: ImportGroup): string {
  const organized: string[] = [];
  
  // Order: react -> next -> amplify -> external -> internal -> relative -> types
  const groups = [
    imports.react,
    imports.next,
    imports.amplify,
    imports.external,
    imports.internal,
    imports.relative,
    imports.types,
  ];
  
  for (const group of groups) {
    if (group.length > 0) {
      // Sort within group
      group.sort((a, b) => a.toLowerCase().localeCompare(b.toLowerCase()));
      organized.push(...group);
      organized.push(''); // Empty line between groups
    }
  }
  
  // Remove trailing empty line if exists
  if (organized[organized.length - 1] === '') {
    organized.pop();
  }
  
  return organized.join('\n');
}

function fixImports(content: string): FixResult {
  try {
    let fixedContent = content;
    
    // Apply import replacements
    for (const { pattern, replacement } of IMPORT_REPLACEMENTS) {
      fixedContent = fixedContent.replace(pattern, replacement);
    }
    
    // Parse and organize imports
    const { imports, restContent } = parseImports(fixedContent);
    const organizedImports = organizeImports(imports);
    
    // Combine organized imports with rest of content
    fixedContent = organizedImports + '\n\n' + restContent;
    
    // Remove duplicate imports
    const importLines = new Set<string>();
    const cleanedLines: string[] = [];
    
    for (const line of fixedContent.split('\n')) {
      if (line.trim().startsWith('import ')) {
        if (!importLines.has(line.trim())) {
          importLines.add(line.trim());
          cleanedLines.push(line);
        }
      } else {
        cleanedLines.push(line);
      }
    }
    
    fixedContent = cleanedLines.join('\n');
    
    return {
      success: true,
      fixedContent,
      message: 'Imports organized and updated to current patterns',
    };
  } catch (error) {
    return {
      success: false,
      message: `Failed to fix imports: ${error}`,
    };
  }
}

// Main execution
async function main() {
  const filePath = process.argv[2];
  
  if (!filePath) {
    console.error('Usage: fix-imports.ts <file-path>');
    process.exit(1);
  }
  
  try {
    const content = fs.readFileSync(filePath, 'utf-8');
    const result = fixImports(content);
    
    if (result.success && result.fixedContent) {
      // Check if content actually changed
      if (content !== result.fixedContent) {
        fs.writeFileSync(filePath, result.fixedContent, 'utf-8');
        console.log(JSON.stringify({
          success: true,
          message: 'Imports fixed and organized',
          changed: true,
        }));
      } else {
        console.log(JSON.stringify({
          success: true,
          message: 'Imports already organized',
          changed: false,
        }));
      }
    } else {
      console.log(JSON.stringify(result));
    }
    
    process.exit(result.success ? 0 : 1);
  } catch (error) {
    console.error('Error processing file:', error);
    process.exit(1);
  }
}

// Run if called directly
if (require.main === module) {
  main();
}

// Export for use as module
export { fixImports, FixResult };