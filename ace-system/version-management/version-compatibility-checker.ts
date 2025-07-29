/**
 * ACE-Flow Version Compatibility Checker
 * Ensures Next.js version is compatible with AWS Amplify Gen 2
 */

import { execSync } from 'child_process';
import * as fs from 'fs';
import * as path from 'path';
import * as semver from 'semver';

interface CompatibilityMatrix {
  amplifyGen2: {
    [version: string]: {
      minNextJs: string;
      maxNextJs: string;
      recommendedNextJs: string;
      notes: string;
      knownIssues: string[];
    };
  };
}

interface VersionCheckResult {
  isCompatible: boolean;
  currentNextJs?: string;
  currentAmplify?: string;
  recommendedNextJs?: string;
  issues: string[];
  actions: string[];
}

export class AmplifyNextJsCompatibilityChecker {
  private compatibilityData: CompatibilityMatrix;
  private projectPath: string;

  constructor(projectPath: string = process.cwd()) {
    this.projectPath = projectPath;
    this.loadCompatibilityMatrix();
  }

  /**
   * Load compatibility matrix from JSON file
   */
  private loadCompatibilityMatrix(): void {
    const matrixPath = path.join(__dirname, 'amplify-nextjs-compatibility.json');
    const data = JSON.parse(fs.readFileSync(matrixPath, 'utf-8'));
    this.compatibilityData = data.compatibilityMatrix;
  }

  /**
   * Get current versions from package.json
   */
  private getCurrentVersions(): { nextjs?: string; amplify?: string } {
    const packageJsonPath = path.join(this.projectPath, 'package.json');
    
    if (!fs.existsSync(packageJsonPath)) {
      return {};
    }

    const packageJson = JSON.parse(fs.readFileSync(packageJsonPath, 'utf-8'));
    const deps = { ...packageJson.dependencies, ...packageJson.devDependencies };

    return {
      nextjs: deps.next?.replace(/[\^~]/, ''),
      amplify: deps['aws-amplify']?.replace(/[\^~]/, '')
    };
  }

  /**
   * Get latest compatible Next.js version for current Amplify
   */
  private getCompatibleNextJsVersion(amplifyVersion: string): string | null {
    // Find the closest Amplify version in our matrix
    const amplifyVersions = Object.keys(this.compatibilityData.amplifyGen2)
      .sort((a, b) => semver.compare(b, a));

    for (const version of amplifyVersions) {
      if (semver.gte(amplifyVersion, version)) {
        return this.compatibilityData.amplifyGen2[version].recommendedNextJs;
      }
    }

    // If no match, use latest
    return this.compatibilityData.amplifyGen2[amplifyVersions[0]].recommendedNextJs;
  }

  /**
   * Check if current versions are compatible
   */
  async checkCompatibility(): Promise<VersionCheckResult> {
    const result: VersionCheckResult = {
      isCompatible: true,
      issues: [],
      actions: []
    };

    const { nextjs, amplify } = this.getCurrentVersions();
    result.currentNextJs = nextjs;
    result.currentAmplify = amplify;

    if (!nextjs || !amplify) {
      result.isCompatible = false;
      result.issues.push('Next.js or AWS Amplify not found in package.json');
      result.actions.push('Install required dependencies');
      return result;
    }

    // Find compatibility info for current Amplify version
    const compatibleNextJs = this.getCompatibleNextJsVersion(amplify);
    result.recommendedNextJs = compatibleNextJs;

    if (compatibleNextJs && !semver.satisfies(nextjs, compatibleNextJs)) {
      result.isCompatible = false;
      result.issues.push(
        `Next.js ${nextjs} may not be fully compatible with AWS Amplify ${amplify}`
      );
      result.actions.push(
        `Update Next.js to ${compatibleNextJs} for best compatibility`
      );
    }

    // Check for known issues
    const amplifyMajor = semver.major(amplify) + '.' + semver.minor(amplify) + '.0';
    const compatInfo = this.compatibilityData.amplifyGen2[amplifyMajor];
    
    if (compatInfo?.knownIssues.length > 0) {
      result.issues.push(...compatInfo.knownIssues);
    }

    return result;
  }

  /**
   * Automatically update to compatible versions
   */
  async updateToCompatibleVersions(useYarn = false): Promise<void> {
    const result = await this.checkCompatibility();
    
    if (!result.recommendedNextJs) {
      throw new Error('Unable to determine compatible Next.js version');
    }

    const packageManager = useYarn ? 'yarn' : 'npm';
    const command = useYarn ? 'add' : 'install';

    console.log(`📦 Updating Next.js to ${result.recommendedNextJs}...`);
    
    try {
      execSync(
        `${packageManager} ${command} next@${result.recommendedNextJs}`,
        { stdio: 'inherit', cwd: this.projectPath }
      );
      
      console.log('✅ Successfully updated to compatible Next.js version');
    } catch (error) {
      console.error('❌ Failed to update Next.js:', error);
      throw error;
    }
  }

  /**
   * Get latest versions from NPM/GitHub
   */
  async getLatestVersions(): Promise<{
    latestNextJs: string;
    latestAmplify: string;
    compatible: boolean;
  }> {
    try {
      // Get latest Next.js version
      const nextjsInfo = execSync('npm view next version', { encoding: 'utf-8' }).trim();
      
      // Get latest Amplify version
      const amplifyInfo = execSync('npm view aws-amplify version', { encoding: 'utf-8' }).trim();

      // Check compatibility
      const compatibleNextJs = this.getCompatibleNextJsVersion(amplifyInfo);
      const compatible = compatibleNextJs ? semver.satisfies(nextjsInfo, compatibleNextJs) : false;

      return {
        latestNextJs: nextjsInfo,
        latestAmplify: amplifyInfo,
        compatible
      };
    } catch (error) {
      console.error('Failed to fetch latest versions:', error);
      throw error;
    }
  }

  /**
   * Update framework registry with current versions
   */
  async updateFrameworkRegistry(): Promise<void> {
    const registryPath = path.join(this.projectPath, 'ace-system', 'frameworks', 'README.md');
    
    if (!fs.existsSync(registryPath)) {
      throw new Error('Framework registry not found at ' + registryPath);
    }
    
    const { nextjs, amplify } = this.getCurrentVersions();
    const registryContent = fs.readFileSync(registryPath, 'utf-8');
    
    // Update YAML section with current versions
    const updatedContent = registryContent
      .replace(/version: "[^"]+" # AWS Amplify/, `version: "${amplify}"` + ' # AWS Amplify')
      .replace(/version: "[^"]+" # Next.js/, `version: "${nextjs}"` + ' # Next.js')
      .replace(/last_updated: "[^"]+"/, `last_updated: "${new Date().toISOString()}"`)
      .replace(/updated_by: "[^"]+"/, `updated_by: "ace-version-check"`);
    
    // Update framework versions in YAML
    const frameworksRegex = /frameworks:\s*\n(\s+amplify:[\s\S]*?)\n\s+nextjs:/;
    const nextjsRegex = /nextjs:\s*\n(\s+[\s\S]*?)\n\s+react:/;
    
    let finalContent = updatedContent;
    
    // Update Amplify version
    if (amplify) {
      finalContent = finalContent.replace(
        /amplify:\s*\n(\s+)name:[^\n]+\n\s+version: "[^"]+"/,
        `amplify:\n$1name: "AWS Amplify Gen 2"\n$1version: "${amplify}"`
      );
    }
    
    // Update Next.js version
    if (nextjs) {
      const recommendedNextJs = this.getCompatibleNextJsVersion(amplify || '6.8.0');
      finalContent = finalContent.replace(
        /nextjs:\s*\n(\s+)name:[^\n]+\n\s+version: "[^"]+"/,
        `nextjs:\n$1name: "Next.js"\n$1version: "${nextjs}"`
      );
    }
    
    // Update metadata timestamp
    finalContent = finalContent.replace(
      /metadata:\s*\n(\s+)last_updated: "[^"]+"/,
      `metadata:\n$1last_updated: "${new Date().toISOString()}"`
    );
    
    fs.writeFileSync(registryPath, finalContent, 'utf-8');
    console.log('✅ Framework registry updated successfully');
  }

  /**
   * Generate compatibility report
   */
  generateReport(): string {
    const result = this.checkCompatibility();
    const { nextjs, amplify } = this.getCurrentVersions();

    let report = `
🔍 ACE-Flow Version Compatibility Report
=======================================

Current Versions:
├── Next.js: ${nextjs || 'Not installed'}
└── AWS Amplify: ${amplify || 'Not installed'}

Compatibility Status: ${result.isCompatible ? '✅ Compatible' : '❌ Issues Found'}
`;

    if (result.recommendedNextJs) {
      report += `\nRecommended Next.js: ${result.recommendedNextJs}\n`;
    }

    if (result.issues.length > 0) {
      report += '\nIssues:\n';
      result.issues.forEach(issue => {
        report += `├── ⚠️  ${issue}\n`;
      });
    }

    if (result.actions.length > 0) {
      report += '\nRecommended Actions:\n';
      result.actions.forEach(action => {
        report += `├── 🔧 ${action}\n`;
      });
    }

    return report;
  }
}

/**
 * CLI Integration
 */
if (require.main === module) {
  const checker = new AmplifyNextJsCompatibilityChecker();
  
  const args = process.argv.slice(2);
  const command = args[0];

  switch (command) {
    case 'check':
      console.log(checker.generateReport());
      break;
      
    case 'update':
      checker.updateToCompatibleVersions(args.includes('--yarn'))
        .then(() => {
          console.log('✅ Update complete');
          // Update framework registry after version update
          return checker.updateFrameworkRegistry();
        })
        .then(() => console.log('✅ Framework registry updated'))
        .catch(err => console.error('❌ Update failed:', err));
      break;
      
    case 'latest':
      checker.getLatestVersions()
        .then(versions => {
          console.log(`Latest versions:
├── Next.js: ${versions.latestNextJs}
├── AWS Amplify: ${versions.latestAmplify}
└── Compatible: ${versions.compatible ? '✅' : '❌'}`);
        })
        .catch(err => console.error('Failed to check latest versions:', err));
      break;
      
    case 'update-registry':
      checker.updateFrameworkRegistry()
        .then(() => console.log('✅ Framework registry updated successfully'))
        .catch(err => console.error('❌ Failed to update registry:', err));
      break;
      
    default:
      console.log(`Usage: 
  check           - Check current compatibility
  update          - Update to compatible versions
  latest          - Check latest available versions
  update-registry - Update framework registry with current versions`);
  }
}