// pages/index.js
import {
  FolderOpen,
  HelpCircle,
  Layout,
  Maximize2,
  PanelLeftClose,
  PanelLeftOpen,
  Save,
  Settings,
} from 'lucide-react';
import Head from 'next/head';
import { useCallback, useEffect, useState } from 'react';

import ComponentPalette from '../components/ComponentPalette';
import ExecutionDashboard from '../components/ExecutionDashboard';
import PlantUMLPreview from '../components/PlantUMLPreview';
import WorkflowCanvas from '../components/WorkflowCanvas';

const LAYOUT_MODES = {
  DESIGN: 'design',
  PREVIEW: 'preview',
  EXECUTE: 'execute',
};

const WorkflowBuilder = () => {
  // Main application state
  const [layoutMode, setLayoutMode] = useState(LAYOUT_MODES.DESIGN);
  const [showPalette, setShowPalette] = useState(true);
  const [workflow, setWorkflow] = useState({
    name: 'New Workflow',
    description: 'Describe your workflow here',
    version: '1.0.0',
    steps: [],
  });
  const [plantUMLCode, setPlantUMLCode] = useState('');
  const [execution, setExecution] = useState(null);
  const [isExecuting, setIsExecuting] = useState(false);
  const [savedWorkflows, setSavedWorkflows] = useState([]);

  // Load saved workflows on mount
  useEffect(() => {
    loadSavedWorkflows();
  }, []);

  // Load workflows from localStorage or API
  const loadSavedWorkflows = async () => {
    try {
      const saved = localStorage.getItem('ai-ley-workflows');
      if (saved) {
        setSavedWorkflows(JSON.parse(saved));
      }
    } catch (error) {
      console.error('Failed to load saved workflows:', error);
    }
  };

  // Save workflow
  const handleSaveWorkflow = useCallback(
    async (workflowToSave) => {
      try {
        const workflowWithMetadata = {
          ...workflowToSave,
          id: workflowToSave.id || `workflow_${Date.now()}`,
          lastModified: new Date().toISOString(),
          plantUMLCode,
        };

        // Save to API
        const response = await fetch('/api/workflows/save', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(workflowWithMetadata),
        });

        if (!response.ok) {
          throw new Error('Failed to save workflow');
        }

        // Save to localStorage as backup
        const updated = savedWorkflows.filter((w) => w.id !== workflowWithMetadata.id);
        updated.push(workflowWithMetadata);
        setSavedWorkflows(updated);
        localStorage.setItem('ai-ley-workflows', JSON.stringify(updated));

        alert('Workflow saved successfully!');
      } catch (error) {
        console.error('Save failed:', error);
        alert('Failed to save workflow. Please try again.');
      }
    },
    [plantUMLCode, savedWorkflows],
  );

  // Execute workflow
  const handleExecuteWorkflow = useCallback(
    async (workflowToExecute) => {
      try {
        setIsExecuting(true);
        setLayoutMode(LAYOUT_MODES.EXECUTE);

        const response = await fetch('/api/workflows/execute', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            workflow: workflowToExecute,
            plantUMLCode,
          }),
        });

        if (!response.ok) {
          throw new Error('Execution failed');
        }

        const result = await response.json();
        setExecution(result);
      } catch (error) {
        console.error('Execution failed:', error);
        setExecution({
          status: 'error',
          error: error.message,
          steps: [],
          logs: [
            {
              timestamp: new Date().toISOString(),
              level: 'error',
              message: `Execution failed: ${error.message}`,
            },
          ],
        });
      } finally {
        setIsExecuting(false);
      }
    },
    [plantUMLCode],
  );

  // Add component from palette
  const handleAddComponent = useCallback(
    (component) => {
      const newStep = {
        ...component,
        id: `step_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
        position: component.position || {
          x: 100 + workflow.steps.length * 30,
          y: 100 + workflow.steps.length * 30,
        },
      };

      setWorkflow((prev) => ({
        ...prev,
        steps: [...prev.steps, newStep],
      }));
    },
    [workflow.steps.length],
  );

  // Load workflow
  const handleLoadWorkflow = (workflowToLoad) => {
    setWorkflow(workflowToLoad);
    if (workflowToLoad.plantUMLCode) {
      setPlantUMLCode(workflowToLoad.plantUMLCode);
    }
    setExecution(null);
    setLayoutMode(LAYOUT_MODES.DESIGN);
  };

  // Reset execution
  const handleResetExecution = () => {
    setExecution(null);
    setIsExecuting(false);
  };

  // Get layout classes based on mode
  const getLayoutClasses = () => {
    const base = 'flex h-screen bg-gray-50';

    switch (layoutMode) {
      case LAYOUT_MODES.PREVIEW:
        return `${base} preview-mode`;
      case LAYOUT_MODES.EXECUTE:
        return `${base} execute-mode`;
      default:
        return `${base} design-mode`;
    }
  };

  return (
    <>
      <Head>
        <title>AI-LEY Workflow Builder - Visual PlantUML Automation</title>
        <meta
          name="description"
          content="Design, generate, and execute workflows using PlantUML as the source of truth"
        />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <div className={getLayoutClasses()}>
        {/* Component Palette */}
        {showPalette && layoutMode === LAYOUT_MODES.DESIGN && (
          <div className="palette-panel w-64 bg-white border-r border-gray-200 overflow-y-auto">
            <div className="p-3 border-b border-gray-200">
              <div className="flex items-center justify-between">
                <h2 className="font-semibold text-sm">Components</h2>
                <button
                  onClick={() => setShowPalette(false)}
                  className="text-gray-500 hover:text-gray-700"
                >
                  <PanelLeftClose size={16} />
                </button>
              </div>
            </div>
            <ComponentPalette onAddComponent={handleAddComponent} />
          </div>
        )}

        {/* Main Content Area */}
        <div className="main-content flex-1 flex flex-col overflow-hidden">
          {/* Top Navigation */}
          <nav className="top-nav bg-white border-b border-gray-200 px-4 py-2">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-4">
                {!showPalette && layoutMode === LAYOUT_MODES.DESIGN && (
                  <button
                    onClick={() => setShowPalette(true)}
                    className="text-gray-500 hover:text-gray-700"
                  >
                    <PanelLeftOpen size={20} />
                  </button>
                )}

                <div className="flex items-center gap-2">
                  <Layout size={20} className="text-blue-600" />
                  <h1 className="text-lg font-semibold">AI-LEY Workflow Builder</h1>
                </div>

                <div className="workflow-info text-sm text-gray-600">
                  <input
                    type="text"
                    value={workflow.name}
                    onChange={(e) => setWorkflow((prev) => ({ ...prev, name: e.target.value }))}
                    className="font-medium bg-transparent border-none outline-none hover:bg-gray-50 px-2 py-1 rounded"
                  />
                </div>
              </div>

              <div className="nav-controls flex items-center gap-2">
                {/* Layout Mode Buttons */}
                <div className="mode-switcher bg-gray-100 rounded-lg p-1 flex">
                  <button
                    className={`px-3 py-1 rounded text-sm font-medium transition-colors ${
                      layoutMode === LAYOUT_MODES.DESIGN
                        ? 'bg-white text-gray-900 shadow-sm'
                        : 'text-gray-600 hover:text-gray-900'
                    }`}
                    onClick={() => setLayoutMode(LAYOUT_MODES.DESIGN)}
                  >
                    Design
                  </button>
                  <button
                    className={`px-3 py-1 rounded text-sm font-medium transition-colors ${
                      layoutMode === LAYOUT_MODES.PREVIEW
                        ? 'bg-white text-gray-900 shadow-sm'
                        : 'text-gray-600 hover:text-gray-900'
                    }`}
                    onClick={() => setLayoutMode(LAYOUT_MODES.PREVIEW)}
                  >
                    Preview
                  </button>
                  <button
                    className={`px-3 py-1 rounded text-sm font-medium transition-colors ${
                      layoutMode === LAYOUT_MODES.EXECUTE
                        ? 'bg-white text-gray-900 shadow-sm'
                        : 'text-gray-600 hover:text-gray-900'
                    }`}
                    onClick={() => setLayoutMode(LAYOUT_MODES.EXECUTE)}
                  >
                    Execute
                  </button>
                </div>

                <div className="separator w-px h-6 bg-gray-300" />

                {/* Action Buttons */}
                <button
                  className="nav-button"
                  onClick={() => handleSaveWorkflow(workflow)}
                  title="Save Workflow"
                >
                  <Save size={16} />
                </button>

                <button
                  className="nav-button"
                  onClick={() => {
                    /* Show load dialog */
                  }}
                  title="Open Workflow"
                >
                  <FolderOpen size={16} />
                </button>

                <button className="nav-button" title="Settings">
                  <Settings size={16} />
                </button>

                <button className="nav-button" title="Help">
                  <HelpCircle size={16} />
                </button>
              </div>
            </div>
          </nav>

          {/* Main Workspace */}
          <div className="workspace flex-1 flex overflow-hidden">
            {layoutMode === LAYOUT_MODES.DESIGN && (
              <>
                <div className="canvas-area flex-1">
                  <WorkflowCanvas
                    workflow={workflow}
                    onWorkflowChange={setWorkflow}
                    onExecute={handleExecuteWorkflow}
                    onSave={handleSaveWorkflow}
                    isExecuting={isExecuting}
                  />
                </div>
              </>
            )}

            {layoutMode === LAYOUT_MODES.PREVIEW && (
              <div className="preview-area flex-1">
                <PlantUMLPreview
                  workflow={workflow}
                  plantUMLCode={plantUMLCode}
                  onCodeChange={setPlantUMLCode}
                  showEditor={true}
                  showPreview={true}
                />
              </div>
            )}

            {layoutMode === LAYOUT_MODES.EXECUTE && (
              <div className="execute-area flex-1">
                <ExecutionDashboard
                  workflow={workflow}
                  execution={execution}
                  onExecute={handleExecuteWorkflow}
                  onPause={() => {
                    /* Implement pause */
                  }}
                  onStop={() => {
                    /* Implement stop */
                  }}
                  onReset={handleResetExecution}
                  isExecuting={isExecuting}
                />
              </div>
            )}
          </div>
        </div>

        {/* Side Panel for Preview in Design Mode */}
        {layoutMode === LAYOUT_MODES.DESIGN && (
          <div className="side-panel w-80 bg-white border-l border-gray-200 overflow-hidden">
            <div className="panel-header bg-gray-50 border-b border-gray-200 p-3">
              <div className="flex items-center justify-between">
                <h3 className="font-semibold text-sm">PlantUML Preview</h3>
                <div className="flex gap-1">
                  <button className="text-gray-500 hover:text-gray-700" title="Maximize">
                    <Maximize2 size={14} />
                  </button>
                </div>
              </div>
            </div>
            <div className="panel-content h-full">
              <PlantUMLPreview
                workflow={workflow}
                plantUMLCode={plantUMLCode}
                onCodeChange={setPlantUMLCode}
                showEditor={false}
                showPreview={true}
              />
            </div>
          </div>
        )}
      </div>

      {/* Global Styles */}
      <style jsx>{`
        .nav-button {
          @apply p-2 rounded-md hover:bg-gray-100 transition-colors text-gray-600 hover:text-gray-900;
        }

        .panel-content {
          height: calc(100vh - 120px);
        }

        .line-clamp-2 {
          display: -webkit-box;
          -webkit-line-clamp: 2;
          -webkit-box-orient: vertical;
          overflow: hidden;
        }
      `}</style>
    </>
  );
};

export default WorkflowBuilder;
