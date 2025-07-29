/**
 * Example usage of the ACE-Flow Progress Visualization System
 * This demonstrates how the system works during a typical workflow
 */

import { progressVisualizer } from './progress-visualizer';
import {
  RequirementsAgentProgress,
  DesignAgentProgress,
  ImplementationAgentProgress,
  FrontendAgentProgress,
  BackendAgentProgress,
} from './agent-progress-adapter';

// Simulate a complete ACE-Flow workflow
async function simulateWorkflow() {
  const workflowId = 'recipe-app-demo';
  
  // Start the workflow
  console.log('Starting Recipe Sharing Platform workflow...\n');
  progressVisualizer.startWorkflow(workflowId, 'Recipe Sharing Platform');
  
  // Phase 1: Requirements Engineering
  await simulateRequirementsPhase(workflowId);
  
  // Phase 2: Design Architecture
  await simulateDesignPhase(workflowId);
  
  // Phase 3: Implementation (Parallel)
  await simulateImplementationPhase(workflowId);
  
  // Phase 4: Validation
  await simulateValidationPhase(workflowId);
  
  console.log('\n✅ Workflow completed!');
}

async function simulateRequirementsPhase(workflowId: string) {
  const progress = new RequirementsAgentProgress(workflowId);
  
  // Analyze input
  const analyzeTask = progress.analyzeInput();
  await simulateProgress(progress, 'requirements-agent', analyzeTask, [
    { progress: 20, message: 'Extracting key features' },
    { progress: 40, message: 'Identifying user types' },
    { progress: 60, message: 'Determining business objectives' },
    { progress: 80, message: 'Analyzing technical constraints' },
    { progress: 100, message: 'Analysis complete' },
  ]);
  
  // Generate EARS requirements
  const earsTask = progress.startTask('requirements-agent', 'Generating EARS requirements');
  await simulateProgress(progress, 'requirements-agent', earsTask, [
    { progress: 25, message: 'Creating authentication requirements' },
    { progress: 50, message: 'Defining data management requirements' },
    { progress: 75, message: 'Specifying real-time features' },
    { progress: 100, message: 'Generated 15 EARS requirements' },
  ]);
  
  // Create user stories
  const storiesTask = progress.createUserStories(earsTask);
  await simulateProgress(progress, 'requirements-agent', storiesTask, [
    { progress: 50, message: 'Writing user stories' },
    { progress: 100, message: 'Created 8 user stories' },
  ]);
}

async function simulateDesignPhase(workflowId: string) {
  const progress = new DesignAgentProgress(workflowId);
  
  // Analyze requirements
  const analyzeTask = progress.analyzeRequirements();
  await simulateProgress(progress, 'design-agent', analyzeTask, [
    { progress: 50, message: 'Reviewing functional requirements' },
    { progress: 100, message: 'Requirements analysis complete' },
  ]);
  
  // Select AWS services
  const servicesTask = progress.selectAWSServices();
  await simulateProgress(progress, 'design-agent', servicesTask, [
    { progress: 20, message: 'Evaluating authentication options' },
    { progress: 40, message: 'Selecting database solution' },
    { progress: 60, message: 'Choosing storage service' },
    { progress: 80, message: 'Planning API architecture' },
    { progress: 100, message: 'Selected: Cognito, DynamoDB, S3, AppSync' },
  ]);
  
  // Create architecture
  const archTask = progress.createArchitecture();
  await simulateProgress(progress, 'design-agent', archTask, [
    { progress: 33, message: 'Designing data models' },
    { progress: 66, message: 'Creating API specifications' },
    { progress: 100, message: 'Architecture design complete' },
  ]);
}

async function simulateImplementationPhase(workflowId: string) {
  const implProgress = new ImplementationAgentProgress(workflowId);
  
  // Coordinate agents
  const coordTask = implProgress.coordinateAgents();
  await delay(500);
  implProgress.completeTask('implementation-agent', coordTask, 'Agents coordinated');
  
  // Launch parallel agents
  const parallelTask = implProgress.launchParallelAgents([
    'frontend-agent',
    'backend-agent',
    'infrastructure-agent',
    'testing-agent',
  ]);
  
  // Simulate parallel agent work
  await Promise.all([
    simulateFrontendAgent(workflowId),
    simulateBackendAgent(workflowId),
    simulateInfrastructureAgent(workflowId),
    simulateTestingAgent(workflowId),
  ]);
  
  implProgress.completeTask('implementation-agent', parallelTask, 'All agents completed');
}

async function simulateFrontendAgent(workflowId: string) {
  const progress = new FrontendAgentProgress(workflowId);
  
  const componentsTask = progress.createComponents(12);
  await simulateProgress(progress, 'frontend-agent', componentsTask, [
    { progress: 25, message: 'Creating layout components' },
    { progress: 50, message: 'Building recipe components' },
    { progress: 75, message: 'Adding user profile views' },
    { progress: 100, message: '12 components created' },
  ]);
  
  const authTask = progress.implementAuth();
  await simulateProgress(progress, 'frontend-agent', authTask, [
    { progress: 50, message: 'Setting up Amplify UI' },
    { progress: 100, message: 'Authentication UI complete' },
  ]);
}

async function simulateBackendAgent(workflowId: string) {
  const progress = new BackendAgentProgress(workflowId);
  
  const schemaTask = progress.createSchema();
  await simulateProgress(progress, 'backend-agent', schemaTask, [
    { progress: 33, message: 'Defining Recipe model' },
    { progress: 66, message: 'Adding relationships' },
    { progress: 100, message: 'GraphQL schema complete' },
  ]);
  
  const lambdaTask = progress.createLambdas(5);
  await simulateProgress(progress, 'backend-agent', lambdaTask, [
    { progress: 20, message: 'Image processing function' },
    { progress: 40, message: 'Search function' },
    { progress: 60, message: 'Notification handler' },
    { progress: 80, message: 'Data validation' },
    { progress: 100, message: '5 Lambda functions created' },
  ]);
}

async function simulateInfrastructureAgent(workflowId: string) {
  // Similar pattern for infrastructure tasks
  await delay(8000); // Simulate work
}

async function simulateTestingAgent(workflowId: string) {
  // Similar pattern for testing tasks
  await delay(10000); // Simulate work
}

async function simulateValidationPhase(workflowId: string) {
  // Validation phase simulation
  await delay(5000);
}

// Helper functions
async function simulateProgress(
  adapter: any,
  agentName: string,
  taskId: string,
  steps: Array<{ progress: number; message: string }>
) {
  for (const step of steps) {
    await delay(800); // Simulate work time
    adapter.updateProgress(agentName, taskId, step.progress, step.message);
  }
}

function delay(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

// Run the simulation
if (require.main === module) {
  console.log('ACE-Flow Progress Visualization Demo\n');
  console.log('This simulates a complete workflow with multiple agents working in parallel.\n');
  console.log('Press Ctrl+C to stop.\n');
  
  // Set display mode
  progressVisualizer.setDisplayMode('detailed');
  
  // Run simulation
  simulateWorkflow().catch(console.error);
}