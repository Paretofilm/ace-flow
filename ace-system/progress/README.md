# ACE-Flow Progress Visualization System

Real-time progress tracking and visualization for ACE-Flow workflows, providing transparency into agent activities and workflow status.

## Overview

The Progress Visualization System provides:
- Real-time workflow progress tracking
- Multi-agent activity monitoring
- Phase-based progress visualization
- Time estimation and completion prediction
- Integration with all ACE-Flow agents

## Visual Examples

### Detailed View
```
🎯 Recipe Sharing Platform
Started: 10:45:23 AM
Estimated completion: ~12 minutes

Overall: [████████████████████████████░░░░░░░░░░░░░░░░░░░░░] 56%

✅ Requirements Engineering
   [██████████████████████████████] 100%
   ✓ Analyzing natural language input [requirements-agent]
   ✓ Generating 15 EARS requirements [requirements-agent]
   ✓ Creating user stories [requirements-agent]
   ✓ Defining acceptance criteria [requirements-agent]

✅ Design Architecture  
   [██████████████████████████████] 100%
   ✓ Analyzing requirements [design-agent]
   ✓ Selecting optimal AWS services [design-agent]
   ✓ Creating system architecture [design-agent]
   ✓ Designing data models [design-agent]

🔄 Implementation
   [████████████░░░░░░░░░░░░░░░░░░] 40%
   • Coordinating sub-agents [implementation-agent] 100%
   • Creating 12 React components [frontend-agent] 60%
   • Implementing GraphQL schema [backend-agent] 80%
   • Setting up AWS resources [infrastructure-agent] 40%
   • Creating test suites [testing-agent] 20%

⏳ Validation & Testing
```

### Compact View
```
Recipe Sharing Platform [56%] ████████████░░░░░░░░

✅ Requirements     [████] 100%
✅ Design          [████] 100%  
🔄 Implementation  [██░░] 40%
⏳ Validation      [░░░░] 0%

Active: 4 agents working in parallel
ETA: ~12 minutes
```

## Integration

### Starting a Workflow

```typescript
import { progressVisualizer } from './progress-visualizer';

// Start tracking a new workflow
progressVisualizer.startWorkflow(
  'recipe-app-001',
  'Recipe Sharing Platform'
);
```

### Agent Integration

Agents automatically report progress using adapters:

```typescript
import { RequirementsAgentProgress } from './agent-progress-adapter';

export class RequirementsAgent {
  private progress: RequirementsAgentProgress;
  
  constructor(workflowId: string) {
    this.progress = new RequirementsAgentProgress(workflowId);
  }
  
  async generateRequirements(input: string) {
    // Start task
    const taskId = this.progress.analyzeInput();
    
    // Update progress
    this.progress.updateProgress('requirements-agent', taskId, 30, 'Parsing input');
    
    // Do work...
    const requirements = await this.parseRequirements(input);
    
    // Complete task
    this.progress.completeTask('requirements-agent', taskId, 
      `Generated ${requirements.length} requirements`);
  }
}
```

### Manual Progress Updates

For custom integrations:

```typescript
// Update specific task
progressVisualizer.updateTask(
  'workflow-id',
  'implementation',
  'task-id',
  {
    progress: 75,
    message: 'Compiling TypeScript...',
    status: 'in_progress'
  }
);

// Report agent activity
progressVisualizer.agentActivity(
  'workflow-id',
  'backend-agent',
  'Creating Lambda function',
  50
);
```

## Display Modes

### Detailed Mode (Default)
Shows all tasks, subtasks, and agent activities with full progress bars.

### Compact Mode
Shows only phase-level progress with minimal detail.

### Minimal Mode
Single-line progress indicator for space-constrained environments.

```typescript
// Change display mode
progressVisualizer.setDisplayMode('compact');
```

## Progress Events

Subscribe to progress events:

```typescript
progressVisualizer.on('workflow:started', (workflow) => {
  console.log(`New workflow: ${workflow.name}`);
});

progressVisualizer.on('task:updated', ({ workflowId, phase, task }) => {
  if (task.status === 'failed') {
    console.error(`Task failed: ${task.name}`);
  }
});

progressVisualizer.on('workflow:completed', (workflow) => {
  const duration = Date.now() - workflow.startTime.getTime();
  console.log(`Completed in ${Math.round(duration / 60000)} minutes`);
});
```

## CLI Integration

The progress visualizer can be used in CLI commands:

```bash
# Show progress for active workflows
ace-flow progress

# Show specific workflow
ace-flow progress --workflow recipe-app-001

# Compact mode
ace-flow progress --compact

# JSON output for programmatic use
ace-flow progress --json
```

## Web Dashboard

For web-based monitoring, the progress data can be exposed via API:

```typescript
// Express endpoint example
app.get('/api/progress/:workflowId', (req, res) => {
  const progress = progressVisualizer.getWorkflow(req.params.workflowId);
  res.json(progress);
});

// WebSocket for real-time updates
io.on('connection', (socket) => {
  progressVisualizer.on('task:updated', (data) => {
    socket.emit('progress:update', data);
  });
});
```

## Terminal UI Features

### Color Coding
- 🟢 Green: Completed tasks
- 🔵 Blue: Active phase
- 🟡 Yellow: In-progress tasks
- ⚪ Gray: Pending tasks
- 🔴 Red: Failed tasks

### Progress Bars
- Filled blocks (█) show completed progress
- Empty blocks (░) show remaining work
- Percentage displayed for precision

### Time Tracking
- Start time for workflow
- Estimated completion based on current pace
- Duration tracking for completed tasks

## Performance Considerations

### Update Frequency
- Display updates every second during active work
- Automatic pause when no active tasks
- Configurable update interval

### Memory Management
- Completed workflows are archived after 1 hour
- Maximum 10 active workflows tracked
- Old task details compressed

### Terminal Optimization
- Smart clearing to reduce flicker
- Partial updates when possible
- Responsive to terminal size

## Error Handling

### Task Failures
```typescript
// Report task failure
progress.failTask('backend-agent', taskId, 'Lambda timeout after 30s');
```

Failed tasks are displayed with:
- Red color coding
- Error message
- Timestamp of failure
- Option to retry

### Recovery
```typescript
// Retry failed task
progress.retryTask('backend-agent', failedTaskId);
```

## Customization

### Custom Progress Renderers

```typescript
class CustomRenderer {
  render(workflow: WorkflowProgress): void {
    // Custom visualization logic
  }
}

progressVisualizer.setRenderer(new CustomRenderer());
```

### Progress Webhooks

```typescript
// Send progress to external service
progressVisualizer.on('task:updated', async (data) => {
  await fetch('https://metrics.example.com/progress', {
    method: 'POST',
    body: JSON.stringify(data)
  });
});
```

## Best Practices

1. **Granular Updates**: Update progress frequently for smooth visualization
2. **Meaningful Messages**: Provide clear, actionable progress messages
3. **Error Context**: Include helpful error details when tasks fail
4. **Batch Updates**: Use batch updates for multiple related changes
5. **Clean Completion**: Always mark tasks as completed or failed

## Troubleshooting

### Progress Not Updating
- Check agent registration
- Verify workflow ID matches
- Ensure progress events are emitted

### Display Issues
- Check terminal capabilities
- Try different display modes
- Verify color support

### Performance Problems
- Reduce update frequency
- Use compact mode
- Archive old workflows

---

The Progress Visualization System brings transparency to AI-driven development, showing exactly what agents are doing and how close they are to completing your application.