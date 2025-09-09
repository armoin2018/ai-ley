// pages/api/workflows/import.js
import { PlantUMLWorkflowEngine } from '../../../lib/workflow-engine';

const workflowEngine = new PlantUMLWorkflowEngine({
  workflowsDir: '../shared/uml-flows',
});

export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { content, fileName } = req.body;

  if (!content) {
    return res.status(400).json({ error: 'File content is required' });
  }

  try {
    let workflow;

    if (fileName && fileName.endsWith('.puml')) {
      // Parse PlantUML content
      workflow = workflowEngine.parseWorkflow(content);
      console.log(`📥 Imported PlantUML workflow: ${workflow.metadata.title}`);
    } else if (fileName && fileName.endsWith('.json')) {
      // Parse JSON workflow
      workflow = JSON.parse(content);
      console.log(`📥 Imported JSON workflow: ${workflow.metadata?.title || 'Untitled'}`);
    } else {
      // Try to auto-detect format
      try {
        // Try JSON first
        workflow = JSON.parse(content);
      } catch {
        // Fall back to PlantUML
        workflow = workflowEngine.parseWorkflow(content);
      }
    }

    res.status(200).json({
      success: true,
      workflow,
      message: 'Workflow imported successfully',
    });
  } catch (error) {
    console.error('Failed to import workflow:', error);
    res.status(500).json({
      success: false,
      error: error.message,
    });
  }
}

export const config = {
  api: {
    bodyParser: {
      sizeLimit: '1mb',
    },
  },
};
