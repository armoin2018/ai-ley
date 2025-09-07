// lib/workflow-engine.js
const fs = require('fs').promises;
const path = require('path');
const { execSync } = require('child_process');

/**
 * Core PlantUML Workflow Engine
 * Parses PlantUML activity diagrams and executes them as workflows
 */
class PlantUMLWorkflowEngine {
  constructor(options = {}) {
    this.workflowsDir = options.workflowsDir || '../shared/uml-flows';
    this.templatesDir = path.join(this.workflowsDir, 'templates');
    this.userDir = path.join(this.workflowsDir, 'user');
    this.executionHistory = [];
    this.activeExecutions = new Map();

    this.initializeDirectories();
  }

  async initializeDirectories() {
    try {
      await fs.mkdir(this.workflowsDir, { recursive: true });
      await fs.mkdir(this.templatesDir, { recursive: true });
      await fs.mkdir(this.userDir, { recursive: true });
    } catch (error) {
      console.error('Failed to initialize directories:', error);
    }
  }

  /**
   * Parse PlantUML activity diagram into executable workflow steps
   */
  parseWorkflow(plantUMLContent) {
    const lines = plantUMLContent.split('\n');
    const steps = [];
    let currentStep = null;
    let inNote = false;
    let noteContent = '';

    for (let i = 0; i < lines.length; i++) {
      const line = lines[i].trim();

      // Skip empty lines and comments
      if (!line || line.startsWith("'") || line.startsWith('@start') || line.startsWith('@end')) {
        continue;
      }

      // Handle notes (contain execution details)
      if (line.startsWith('note ')) {
        inNote = true;
        noteContent = '';
        continue;
      }

      if (line === 'end note') {
        inNote = false;
        if (currentStep) {
          currentStep.executionDetails = this.parseNoteContent(noteContent);
        }
        continue;
      }

      if (inNote) {
        noteContent += line + '\n';
        continue;
      }

      // Parse activity steps
      if (line.startsWith(':') && line.endsWith(';')) {
        // Activity step: :Action description;
        const action = line.slice(1, -1).trim();
        currentStep = {
          id: `step_${steps.length + 1}`,
          type: 'action',
          description: action,
          action: this.extractActionFromDescription(action),
          executionDetails: null,
          status: 'pending',
        };
        steps.push(currentStep);
      }

      // Parse decision points
      else if (line.includes('if (') && line.includes(') then')) {
        const conditionMatch = line.match(/if \((.+?)\) then/);
        if (conditionMatch) {
          currentStep = {
            id: `decision_${steps.length + 1}`,
            type: 'decision',
            description: conditionMatch[1],
            condition: conditionMatch[1],
            branches: { yes: [], no: [] },
            status: 'pending',
          };
          steps.push(currentStep);
        }
      }

      // Parse parallel execution
      else if (line.includes('fork')) {
        currentStep = {
          id: `parallel_${steps.length + 1}`,
          type: 'parallel',
          description: 'Parallel execution',
          branches: [],
          status: 'pending',
        };
        steps.push(currentStep);
      }
    }

    return {
      id: `workflow_${Date.now()}`,
      steps,
      metadata: this.extractMetadata(plantUMLContent),
      createdAt: new Date().toISOString(),
    };
  }

  /**
   * Extract executable commands from PlantUML notes
   */
  parseNoteContent(noteContent) {
    const details = {};
    const lines = noteContent.split('\n');

    for (const line of lines) {
      const trimmed = line.trim();
      if (trimmed.includes(':')) {
        const [key, value] = trimmed.split(':', 2);
        details[key.toLowerCase().trim()] = value.trim();
      }
    }

    return details;
  }

  /**
   * Extract action type from description (emoji-based categorization)
   */
  extractActionFromDescription(description) {
    // Map emojis to action types
    const actionMap = {
      '📥': 'git_pull',
      '📦': 'build',
      '🚀': 'deploy',
      '🧪': 'test',
      '📧': 'notify',
      '🔄': 'rollback',
      '❌': 'fail',
      '✅': 'success',
      '📊': 'report',
      '🔍': 'check',
      '⚡': 'execute',
      '📁': 'file_operation',
      '🌐': 'api_call',
    };

    for (const [emoji, action] of Object.entries(actionMap)) {
      if (description.includes(emoji)) {
        return action;
      }
    }

    return 'generic';
  }

  /**
   * Extract metadata from PlantUML title and comments
   */
  extractMetadata(plantUMLContent) {
    const metadata = {
      title: 'Untitled Workflow',
      description: '',
      author: 'Unknown',
      version: '1.0',
      tags: [],
    };

    const lines = plantUMLContent.split('\n');
    for (const line of lines) {
      const trimmed = line.trim();

      if (trimmed.startsWith('title ')) {
        metadata.title = trimmed.replace('title ', '').replace(/"/g, '');
      }

      if (trimmed.startsWith("' Description:")) {
        metadata.description = trimmed.replace("' Description:", '').trim();
      }

      if (trimmed.startsWith("' Author:")) {
        metadata.author = trimmed.replace("' Author:", '').trim();
      }

      if (trimmed.startsWith("' Tags:")) {
        metadata.tags = trimmed
          .replace("' Tags:", '')
          .split(',')
          .map((tag) => tag.trim());
      }
    }

    return metadata;
  }

  /**
   * Execute a parsed workflow
   */
  async executeWorkflow(workflowId, workflow, options = {}) {
    const executionId = `exec_${Date.now()}`;
    const execution = {
      id: executionId,
      workflowId,
      startTime: new Date().toISOString(),
      status: 'running',
      steps: [],
      options,
    };

    this.activeExecutions.set(executionId, execution);

    try {
      console.log(`🚀 Starting workflow execution: ${workflow.metadata.title}`);

      for (const step of workflow.steps) {
        const stepResult = await this.executeStep(step, options);
        execution.steps.push(stepResult);

        // Stop on error unless configured to continue
        if (stepResult.status === 'error' && !options.continueOnError) {
          execution.status = 'failed';
          break;
        }
      }

      if (execution.status === 'running') {
        execution.status = 'completed';
      }
    } catch (error) {
      execution.status = 'failed';
      execution.error = error.message;
      console.error(`❌ Workflow execution failed: ${error.message}`);
    } finally {
      execution.endTime = new Date().toISOString();
      execution.duration = new Date(execution.endTime) - new Date(execution.startTime);

      this.activeExecutions.delete(executionId);
      this.executionHistory.push(execution);
    }

    return execution;
  }

  /**
   * Execute individual workflow step
   */
  async executeStep(step, options = {}) {
    const startTime = Date.now();
    const result = {
      id: step.id,
      type: step.type,
      description: step.description,
      startTime: new Date().toISOString(),
      status: 'running',
      output: '',
      error: null,
    };

    try {
      console.log(`⚡ Executing step: ${step.description}`);

      switch (step.type) {
        case 'action':
          result.output = await this.executeAction(step, options);
          break;

        case 'decision':
          result.output = await this.evaluateDecision(step, options);
          break;

        case 'parallel':
          result.output = await this.executeParallel(step, options);
          break;

        default:
          throw new Error(`Unknown step type: ${step.type}`);
      }

      result.status = 'completed';
      console.log(`✅ Step completed: ${step.description}`);
    } catch (error) {
      result.status = 'error';
      result.error = error.message;
      console.error(`❌ Step failed: ${step.description} - ${error.message}`);
    } finally {
      result.endTime = new Date().toISOString();
      result.duration = Date.now() - startTime;
    }

    return result;
  }

  /**
   * Execute action step
   */
  async executeAction(step, options) {
    const { executionDetails } = step;

    if (!executionDetails || !executionDetails.command) {
      return `Simulated: ${step.description}`;
    }

    // Security check - only allow safe commands
    if (!this.isCommandSafe(executionDetails.command)) {
      throw new Error(`Command not allowed: ${executionDetails.command}`);
    }

    try {
      const output = execSync(executionDetails.command, {
        cwd: executionDetails.directory || process.cwd(),
        timeout: (executionDetails.timeout || 30) * 1000,
        encoding: 'utf8',
      });

      return output;
    } catch (error) {
      throw new Error(`Command execution failed: ${error.message}`);
    }
  }

  /**
   * Evaluate decision step
   */
  async evaluateDecision(step, options) {
    // For now, simulate decision making
    // In a real implementation, this would evaluate conditions
    const result = Math.random() > 0.5 ? 'yes' : 'no';
    return `Decision: ${step.condition} -> ${result}`;
  }

  /**
   * Execute parallel steps
   */
  async executeParallel(step, options) {
    // Simulate parallel execution
    return `Parallel execution completed for ${step.branches.length} branches`;
  }

  /**
   * Security check for command execution
   */
  isCommandSafe(command) {
    const dangerousPatterns = [
      'rm -rf',
      'sudo',
      'passwd',
      'chmod 777',
      '> /dev/',
      'mkfs',
      'fdisk',
      'dd if=',
    ];

    const lowerCommand = command.toLowerCase();
    return !dangerousPatterns.some((pattern) => lowerCommand.includes(pattern));
  }

  /**
   * Load workflow from PlantUML file
   */
  async loadWorkflow(filePath) {
    try {
      const content = await fs.readFile(filePath, 'utf8');
      const workflow = this.parseWorkflow(content);
      workflow.filePath = filePath;
      return workflow;
    } catch (error) {
      throw new Error(`Failed to load workflow: ${error.message}`);
    }
  }

  /**
   * Save workflow as PlantUML file
   */
  async saveWorkflow(workflow, filePath) {
    try {
      const plantUMLContent = this.generatePlantUML(workflow);
      await fs.writeFile(filePath, plantUMLContent, 'utf8');
      return filePath;
    } catch (error) {
      throw new Error(`Failed to save workflow: ${error.message}`);
    }
  }

  /**
   * Generate PlantUML from workflow object
   */
  generatePlantUML(workflow) {
    const lines = [];

    lines.push('@startuml');
    lines.push(`title "${workflow.metadata.title}"`);
    lines.push('');

    if (workflow.metadata.description) {
      lines.push(`' Description: ${workflow.metadata.description}`);
    }
    if (workflow.metadata.author) {
      lines.push(`' Author: ${workflow.metadata.author}`);
    }
    if (workflow.metadata.tags.length > 0) {
      lines.push(`' Tags: ${workflow.metadata.tags.join(', ')}`);
    }
    lines.push('');

    lines.push('start');

    for (const step of workflow.steps) {
      lines.push(this.stepToPlantUML(step));
    }

    lines.push('stop');
    lines.push('@enduml');

    return lines.join('\n');
  }

  /**
   * Convert workflow step to PlantUML syntax
   */
  stepToPlantUML(step) {
    switch (step.type) {
      case 'action':
        let actionLine = `:${step.description};`;
        if (step.executionDetails) {
          actionLine += '\nnote right';
          Object.entries(step.executionDetails).forEach(([key, value]) => {
            actionLine += `\n  ${key}: ${value}`;
          });
          actionLine += '\nend note';
        }
        return actionLine;

      case 'decision':
        return `if (${step.condition}) then (yes)\nelse (no)\nendif`;

      case 'parallel':
        return 'fork\n  :Branch 1;\nfork again\n  :Branch 2;\nend fork';

      default:
        return `:${step.description};`;
    }
  }

  /**
   * Get execution status
   */
  getExecutionStatus(executionId) {
    return (
      this.activeExecutions.get(executionId) ||
      this.executionHistory.find((e) => e.id === executionId)
    );
  }

  /**
   * List all executions
   */
  getExecutionHistory() {
    return this.executionHistory;
  }
}

module.exports = { PlantUMLWorkflowEngine };
