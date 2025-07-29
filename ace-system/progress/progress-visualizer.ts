/**
 * ACE-Flow Progress Visualization System
 * Provides real-time progress tracking and visualization for all workflow phases
 */

import { EventEmitter } from 'events';
import chalk from 'chalk';

export interface TaskProgress {
  id: string;
  name: string;
  agent?: string;
  status: 'pending' | 'in_progress' | 'completed' | 'failed' | 'skipped';
  progress: number; // 0-100
  startTime?: Date;
  endTime?: Date;
  message?: string;
  subtasks?: TaskProgress[];
}

export interface PhaseProgress {
  name: string;
  phase: 'requirements' | 'design' | 'implementation' | 'validation';
  status: 'pending' | 'active' | 'completed';
  tasks: TaskProgress[];
  overallProgress: number;
}

export interface WorkflowProgress {
  id: string;
  name: string;
  startTime: Date;
  phases: PhaseProgress[];
  currentPhase: string;
  overallProgress: number;
  estimatedCompletion?: Date;
}

export class ProgressVisualizer extends EventEmitter {
  private workflows: Map<string, WorkflowProgress> = new Map();
  private updateInterval: NodeJS.Timer | null = null;
  private displayMode: 'compact' | 'detailed' | 'minimal' = 'detailed';
  
  constructor() {
    super();
    this.setupUpdateInterval();
  }
  
  /**
   * Start tracking a new workflow
   */
  startWorkflow(id: string, name: string): void {
    const workflow: WorkflowProgress = {
      id,
      name,
      startTime: new Date(),
      phases: [
        {
          name: 'Requirements Engineering',
          phase: 'requirements',
          status: 'pending',
          tasks: [],
          overallProgress: 0,
        },
        {
          name: 'Design Architecture',
          phase: 'design',
          status: 'pending',
          tasks: [],
          overallProgress: 0,
        },
        {
          name: 'Implementation',
          phase: 'implementation',
          status: 'pending',
          tasks: [],
          overallProgress: 0,
        },
        {
          name: 'Validation & Testing',
          phase: 'validation',
          status: 'pending',
          tasks: [],
          overallProgress: 0,
        },
      ],
      currentPhase: 'requirements',
      overallProgress: 0,
    };
    
    this.workflows.set(id, workflow);
    this.emit('workflow:started', workflow);
    this.render();
  }
  
  /**
   * Update task progress
   */
  updateTask(
    workflowId: string,
    phase: string,
    taskId: string,
    update: Partial<TaskProgress>
  ): void {
    const workflow = this.workflows.get(workflowId);
    if (!workflow) return;
    
    const phaseData = workflow.phases.find(p => p.phase === phase);
    if (!phaseData) return;
    
    let task = phaseData.tasks.find(t => t.id === taskId);
    if (!task) {
      // Create new task if doesn't exist
      task = {
        id: taskId,
        name: update.name || 'Unknown Task',
        status: 'pending',
        progress: 0,
        ...update,
      };
      phaseData.tasks.push(task);
    } else {
      // Update existing task
      Object.assign(task, update);
    }
    
    // Update phase progress
    this.updatePhaseProgress(phaseData);
    
    // Update workflow progress
    this.updateWorkflowProgress(workflow);
    
    this.emit('task:updated', { workflowId, phase, task });
    this.render();
  }
  
  /**
   * Add agent activity
   */
  agentActivity(
    workflowId: string,
    agentName: string,
    activity: string,
    progress?: number
  ): void {
    const taskId = `agent-${agentName}-${Date.now()}`;
    const phase = this.getCurrentPhase(workflowId);
    
    this.updateTask(workflowId, phase, taskId, {
      name: activity,
      agent: agentName,
      status: progress === 100 ? 'completed' : 'in_progress',
      progress: progress || 0,
    });
  }
  
  /**
   * Calculate phase progress
   */
  private updatePhaseProgress(phase: PhaseProgress): void {
    if (phase.tasks.length === 0) {
      phase.overallProgress = 0;
      return;
    }
    
    const totalProgress = phase.tasks.reduce((sum, task) => sum + task.progress, 0);
    phase.overallProgress = Math.round(totalProgress / phase.tasks.length);
    
    // Update phase status
    if (phase.overallProgress === 0) {
      phase.status = 'pending';
    } else if (phase.overallProgress === 100) {
      phase.status = 'completed';
    } else {
      phase.status = 'active';
    }
  }
  
  /**
   * Calculate workflow progress
   */
  private updateWorkflowProgress(workflow: WorkflowProgress): void {
    const totalPhases = workflow.phases.length;
    const completedPhases = workflow.phases.filter(p => p.status === 'completed').length;
    const activePhase = workflow.phases.find(p => p.status === 'active');
    
    // Calculate weighted progress
    let progress = (completedPhases / totalPhases) * 100;
    if (activePhase) {
      progress += (activePhase.overallProgress / 100) * (100 / totalPhases);
    }
    
    workflow.overallProgress = Math.round(progress);
    
    // Update current phase
    const active = workflow.phases.find(p => p.status === 'active');
    if (active) {
      workflow.currentPhase = active.phase;
    }
    
    // Estimate completion time
    this.estimateCompletion(workflow);
  }
  
  /**
   * Estimate completion time based on current progress
   */
  private estimateCompletion(workflow: WorkflowProgress): void {
    if (workflow.overallProgress === 0 || workflow.overallProgress === 100) {
      workflow.estimatedCompletion = undefined;
      return;
    }
    
    const elapsed = Date.now() - workflow.startTime.getTime();
    const rate = workflow.overallProgress / elapsed;
    const remaining = (100 - workflow.overallProgress) / rate;
    
    workflow.estimatedCompletion = new Date(Date.now() + remaining);
  }
  
  /**
   * Get current phase for workflow
   */
  private getCurrentPhase(workflowId: string): string {
    const workflow = this.workflows.get(workflowId);
    return workflow?.currentPhase || 'requirements';
  }
  
  /**
   * Render progress visualization
   */
  render(): void {
    console.clear();
    
    for (const workflow of this.workflows.values()) {
      this.renderWorkflow(workflow);
    }
  }
  
  /**
   * Render individual workflow
   */
  private renderWorkflow(workflow: WorkflowProgress): void {
    console.log(chalk.bold.cyan(`\n🎯 ${workflow.name}`));
    console.log(chalk.gray(`Started: ${workflow.startTime.toLocaleTimeString()}`));
    
    if (workflow.estimatedCompletion) {
      const remaining = workflow.estimatedCompletion.getTime() - Date.now();
      const minutes = Math.round(remaining / 60000);
      console.log(chalk.gray(`Estimated completion: ~${minutes} minutes`));
    }
    
    // Overall progress bar
    this.renderProgressBar('Overall', workflow.overallProgress, 50);
    
    // Phase progress
    console.log('');
    for (const phase of workflow.phases) {
      this.renderPhase(phase);
    }
  }
  
  /**
   * Render phase progress
   */
  private renderPhase(phase: PhaseProgress): void {
    const icon = this.getStatusIcon(phase.status);
    const color = this.getStatusColor(phase.status);
    
    console.log(chalk[color](`\n${icon} ${phase.name}`));
    
    if (phase.status === 'active' || phase.status === 'completed') {
      // Show phase progress bar
      this.renderProgressBar('', phase.overallProgress, 30);
      
      // Show tasks in detailed mode
      if (this.displayMode === 'detailed' && phase.tasks.length > 0) {
        for (const task of phase.tasks) {
          this.renderTask(task, '  ');
        }
      }
    }
  }
  
  /**
   * Render individual task
   */
  private renderTask(task: TaskProgress, indent: string = ''): void {
    const icon = this.getTaskIcon(task.status);
    const color = this.getStatusColor(task.status);
    
    let taskLine = `${indent}${icon} ${task.name}`;
    
    if (task.agent) {
      taskLine += chalk.gray(` [${task.agent}]`);
    }
    
    if (task.status === 'in_progress') {
      taskLine += ` ${chalk.yellow(`${task.progress}%`)}`;
    }
    
    if (task.message) {
      taskLine += chalk.gray(` - ${task.message}`);
    }
    
    console.log(chalk[color](taskLine));
    
    // Render subtasks
    if (task.subtasks) {
      for (const subtask of task.subtasks) {
        this.renderTask(subtask, indent + '  ');
      }
    }
  }
  
  /**
   * Render progress bar
   */
  private renderProgressBar(label: string, progress: number, width: number): void {
    const filled = Math.round((progress / 100) * width);
    const empty = width - filled;
    
    const bar = chalk.green('█'.repeat(filled)) + chalk.gray('░'.repeat(empty));
    const percentage = `${progress}%`.padStart(4);
    
    if (label) {
      console.log(`${label}: [${bar}] ${percentage}`);
    } else {
      console.log(`   [${bar}] ${percentage}`);
    }
  }
  
  /**
   * Get status icon
   */
  private getStatusIcon(status: string): string {
    switch (status) {
      case 'completed': return '✅';
      case 'active': return '🔄';
      case 'in_progress': return '🔄';
      case 'pending': return '⏳';
      case 'failed': return '❌';
      case 'skipped': return '⏭️';
      default: return '•';
    }
  }
  
  /**
   * Get task icon
   */
  private getTaskIcon(status: string): string {
    switch (status) {
      case 'completed': return '✓';
      case 'in_progress': return '•';
      case 'pending': return '○';
      case 'failed': return '✗';
      case 'skipped': return '-';
      default: return '·';
    }
  }
  
  /**
   * Get status color
   */
  private getStatusColor(status: string): string {
    switch (status) {
      case 'completed': return 'green';
      case 'active': return 'blue';
      case 'in_progress': return 'yellow';
      case 'pending': return 'gray';
      case 'failed': return 'red';
      case 'skipped': return 'gray';
      default: return 'white';
    }
  }
  
  /**
   * Setup periodic updates
   */
  private setupUpdateInterval(): void {
    // Update display every second when there are active workflows
    this.updateInterval = setInterval(() => {
      const hasActive = Array.from(this.workflows.values()).some(
        w => w.overallProgress > 0 && w.overallProgress < 100
      );
      
      if (hasActive) {
        this.render();
      }
    }, 1000);
  }
  
  /**
   * Set display mode
   */
  setDisplayMode(mode: 'compact' | 'detailed' | 'minimal'): void {
    this.displayMode = mode;
    this.render();
  }
  
  /**
   * Clean up
   */
  destroy(): void {
    if (this.updateInterval) {
      clearInterval(this.updateInterval);
    }
    this.removeAllListeners();
  }
}

// Export singleton instance
export const progressVisualizer = new ProgressVisualizer();