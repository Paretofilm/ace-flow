/**
 * Agent Progress Adapter
 * Connects agents to the progress visualization system
 */

import { progressVisualizer, TaskProgress } from './progress-visualizer';

export interface AgentProgress {
  agentName: string;
  workflowId: string;
  currentPhase: string;
}

export class AgentProgressAdapter {
  private agentProgress: Map<string, AgentProgress> = new Map();
  
  /**
   * Register an agent with the progress system
   */
  registerAgent(agentName: string, workflowId: string, phase: string): void {
    this.agentProgress.set(agentName, {
      agentName,
      workflowId,
      currentPhase: phase,
    });
  }
  
  /**
   * Report agent starting a task
   */
  startTask(agentName: string, taskName: string, taskId?: string): string {
    const progress = this.agentProgress.get(agentName);
    if (!progress) {
      console.warn(`Agent ${agentName} not registered`);
      return '';
    }
    
    const id = taskId || `${agentName}-${Date.now()}`;
    
    progressVisualizer.updateTask(
      progress.workflowId,
      progress.currentPhase,
      id,
      {
        name: taskName,
        agent: agentName,
        status: 'in_progress',
        progress: 0,
        startTime: new Date(),
      }
    );
    
    return id;
  }
  
  /**
   * Update task progress
   */
  updateProgress(agentName: string, taskId: string, progress: number, message?: string): void {
    const agentInfo = this.agentProgress.get(agentName);
    if (!agentInfo) return;
    
    progressVisualizer.updateTask(
      agentInfo.workflowId,
      agentInfo.currentPhase,
      taskId,
      {
        progress,
        message,
        status: progress === 100 ? 'completed' : 'in_progress',
      }
    );
  }
  
  /**
   * Complete a task
   */
  completeTask(agentName: string, taskId: string, message?: string): void {
    const agentInfo = this.agentProgress.get(agentName);
    if (!agentInfo) return;
    
    progressVisualizer.updateTask(
      agentInfo.workflowId,
      agentInfo.currentPhase,
      taskId,
      {
        progress: 100,
        status: 'completed',
        endTime: new Date(),
        message,
      }
    );
  }
  
  /**
   * Report task failure
   */
  failTask(agentName: string, taskId: string, error: string): void {
    const agentInfo = this.agentProgress.get(agentName);
    if (!agentInfo) return;
    
    progressVisualizer.updateTask(
      agentInfo.workflowId,
      agentInfo.currentPhase,
      taskId,
      {
        status: 'failed',
        message: error,
        endTime: new Date(),
      }
    );
  }
  
  /**
   * Add a subtask
   */
  addSubtask(
    agentName: string,
    parentTaskId: string,
    subtaskName: string,
    subtaskId?: string
  ): string {
    const agentInfo = this.agentProgress.get(agentName);
    if (!agentInfo) return '';
    
    const id = subtaskId || `${parentTaskId}-sub-${Date.now()}`;
    
    // This would need enhancement in progress-visualizer to support subtasks
    // For now, create as a separate task
    return this.startTask(agentName, `  └─ ${subtaskName}`, id);
  }
  
  /**
   * Batch update multiple tasks
   */
  batchUpdate(agentName: string, updates: Array<{
    taskId: string;
    progress?: number;
    status?: TaskProgress['status'];
    message?: string;
  }>): void {
    const agentInfo = this.agentProgress.get(agentName);
    if (!agentInfo) return;
    
    for (const update of updates) {
      progressVisualizer.updateTask(
        agentInfo.workflowId,
        agentInfo.currentPhase,
        update.taskId,
        update
      );
    }
  }
}

// Agent-specific adapters
export class RequirementsAgentProgress extends AgentProgressAdapter {
  constructor(workflowId: string) {
    super();
    this.registerAgent('requirements-agent', workflowId, 'requirements');
  }
  
  analyzeInput() {
    return this.startTask('requirements-agent', 'Analyzing natural language input');
  }
  
  generateEARS(taskId: string, count: number) {
    this.updateProgress('requirements-agent', taskId, 50, `Generating ${count} EARS requirements`);
  }
  
  createUserStories(taskId: string) {
    return this.startTask('requirements-agent', 'Creating user stories');
  }
}

export class DesignAgentProgress extends AgentProgressAdapter {
  constructor(workflowId: string) {
    super();
    this.registerAgent('design-agent', workflowId, 'design');
  }
  
  analyzeRequirements() {
    return this.startTask('design-agent', 'Analyzing requirements');
  }
  
  selectAWSServices() {
    return this.startTask('design-agent', 'Selecting optimal AWS services');
  }
  
  createArchitecture() {
    return this.startTask('design-agent', 'Creating system architecture');
  }
}

export class ImplementationAgentProgress extends AgentProgressAdapter {
  constructor(workflowId: string) {
    super();
    this.registerAgent('implementation-agent', workflowId, 'implementation');
  }
  
  coordinateAgents() {
    return this.startTask('implementation-agent', 'Coordinating sub-agents');
  }
  
  launchParallelAgents(agents: string[]) {
    const taskId = this.startTask('implementation-agent', `Launching ${agents.length} agents in parallel`);
    
    // Create subtasks for each agent
    for (const agent of agents) {
      this.addSubtask('implementation-agent', taskId, `${agent} starting`);
    }
    
    return taskId;
  }
}

// Sub-agent progress adapters
export class FrontendAgentProgress extends AgentProgressAdapter {
  constructor(workflowId: string) {
    super();
    this.registerAgent('frontend-agent', workflowId, 'implementation');
  }
  
  createComponents(count: number) {
    return this.startTask('frontend-agent', `Creating ${count} React components`);
  }
  
  implementAuth() {
    return this.startTask('frontend-agent', 'Implementing authentication UI');
  }
  
  buildDataViews() {
    return this.startTask('frontend-agent', 'Building data views and forms');
  }
}

export class BackendAgentProgress extends AgentProgressAdapter {
  constructor(workflowId: string) {
    super();
    this.registerAgent('backend-agent', workflowId, 'implementation');
  }
  
  createSchema() {
    return this.startTask('backend-agent', 'Implementing GraphQL schema');
  }
  
  createLambdas(count: number) {
    return this.startTask('backend-agent', `Creating ${count} Lambda functions`);
  }
  
  setupSubscriptions() {
    return this.startTask('backend-agent', 'Configuring real-time subscriptions');
  }
}

// Example usage in an agent
export function exampleAgentUsage() {
  const workflowId = 'recipe-app-workflow';
  const progress = new RequirementsAgentProgress(workflowId);
  
  // Start analyzing input
  const analyzeTask = progress.analyzeInput();
  
  // Simulate progress
  setTimeout(() => {
    progress.updateProgress('requirements-agent', analyzeTask, 30, 'Extracting key features');
  }, 1000);
  
  setTimeout(() => {
    progress.updateProgress('requirements-agent', analyzeTask, 60, 'Identifying user roles');
  }, 2000);
  
  setTimeout(() => {
    progress.completeTask('requirements-agent', analyzeTask, 'Analysis complete');
    
    // Start next task
    const earsTask = progress.startTask('requirements-agent', 'Generating EARS requirements');
    progress.generateEARS(earsTask, 15);
  }, 3000);
}