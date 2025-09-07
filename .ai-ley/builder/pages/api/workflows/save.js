// pages/api/workflows/save.js
import fs from 'fs/promises';
import path from 'path';
import { PlantUMLWorkflowEngine } from '../../../lib/workflow-engine';

const workflowEngine = new PlantUMLWorkflowEngine({
  workflowsDir: '../shared/uml-flows',
});

export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { workflow, plantUML, fileName } = req.body;

  if (!workflow || !plantUML) {
    return res.status(400).json({ error: 'Workflow and PlantUML code are required' });
  }

  try {
    // Generate filename if not provided
    const safeFileName =
      fileName || `${workflow.metadata.title.replace(/[^a-zA-Z0-9]/g, '-').toLowerCase()}.puml`;

    const filePath = path.join(process.cwd(), '../shared/uml-flows/user', safeFileName);

    // Save PlantUML file
    await fs.writeFile(filePath, plantUML, 'utf8');

    // Also save workflow metadata as JSON for quick loading
    const metadataPath = filePath.replace('.puml', '.meta.json');
    await fs.writeFile(metadataPath, JSON.stringify(workflow, null, 2), 'utf8');

    console.log(`💾 Saved workflow: ${safeFileName}`);

    res.status(200).json({
      success: true,
      fileName: safeFileName,
      filePath,
      message: 'Workflow saved successfully',
    });
  } catch (error) {
    console.error('Failed to save workflow:', error);
    res.status(500).json({
      success: false,
      error: error.message,
    });
  }
}
