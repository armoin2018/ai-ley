// pages/api/workflows/execute.js
import { PlantUMLWorkflowEngine } from '../../../lib/workflow-engine';

const workflowEngine = new PlantUMLWorkflowEngine({
  workflowsDir: '../shared/uml-flows',
});

export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { workflow, options = {} } = req.body;

  if (!workflow) {
    return res.status(400).json({ error: 'Workflow is required' });
  }

  try {
    console.log(`🚀 Executing workflow: ${workflow.metadata?.title || 'Untitled'}`);

    // Execute the workflow
    const execution = await workflowEngine.executeWorkflow(workflow.id, workflow, options);

    // Return execution results
    res.status(200).json({
      success: true,
      execution: {
        id: execution.id,
        status: execution.status,
        startTime: execution.startTime,
        endTime: execution.endTime,
        duration: execution.duration,
        steps: execution.steps,
        error: execution.error,
      },
    });
  } catch (error) {
    console.error('Workflow execution failed:', error);
    res.status(500).json({
      success: false,
      error: error.message,
      details: error.stack,
    });
  }
}

export const config = {
  api: {
    responseLimit: '8mb',
  },
};
