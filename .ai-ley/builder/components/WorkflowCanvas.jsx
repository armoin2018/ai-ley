// components/WorkflowCanvas.jsx
import { Download, Play, Plus, Save, Settings, Upload } from 'lucide-react';
import { useCallback, useEffect, useRef, useState } from 'react';
import { DragDropContext, Draggable, Droppable } from 'react-beautiful-dnd';

const WorkflowCanvas = ({ 
  workflow, 
  onWorkflowChange, 
  onExecute, 
  onSave,
  isExecuting = false 
}) => {
  const [selectedStep, setSelectedStep] = useState(null);
  const [canvasOffset, setCanvasOffset] = useState({ x: 0, y: 0 });
  const [zoom, setZoom] = useState(1);
  const canvasRef = useRef(null);
  const fileInputRef = useRef(null);

  // Handle file import
  const handleFileImport = useCallback(async (event) => {
    const file = event.target.files?.[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = async (e) => {
      try {
        const content = e.target.result;
        
        // Send to API for processing
        const response = await fetch('/api/workflows/import', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            content,
            fileName: file.name,
          }),
        });

        const result = await response.json();
        
        if (result.success) {
          onWorkflowChange(result.workflow);
          console.log('✅ Workflow imported successfully');
        } else {
          throw new Error(result.error);
        }
      } catch (error) {
        console.error('Failed to import workflow:', error);
        alert('Failed to import workflow. Please check the file format.');
      }
    };
    
    reader.readAsText(file);
    event.target.value = ''; // Reset input
  }, [onWorkflowChange]);

  // Handle workflow export
  const handleExport = useCallback(() => {
    const dataStr = JSON.stringify(workflow, null, 2);
    const dataUri = 'data:application/json;charset=utf-8,'+ encodeURIComponent(dataStr);
    
    const exportFileDefaultName = `${workflow.metadata?.title || 'workflow'}.json`;
    
    const linkElement = document.createElement('a');
    linkElement.setAttribute('href', dataUri);
    linkElement.setAttribute('download', exportFileDefaultName);
    linkElement.click();
  }, [workflow]);

  // Trigger file input
  const triggerFileImport = useCallback(() => {
    fileInputRef.current?.click();
  }, []);

  // Handle drag end for workflow steps
  const handleDragEnd = useCallback((result) => {
    if (!result.destination) return;

    const { source, destination, draggableId } = result;
    const steps = Array.from(workflow.steps);
    
    // Reorder steps
    const [removed] = steps.splice(source.index, 1);
    steps.splice(destination.index, 0, removed);

    onWorkflowChange({
      ...workflow,
      steps: steps
    });
  }, [workflow, onWorkflowChange]);

  // Add new step to workflow
  const addStep = useCallback((stepType, position) => {
    const newStep = {
      id: `step_${Date.now()}`,
      type: stepType,
      name: `New ${stepType}`,
      command: '',
      parameters: {},
      position: position || { x: 100, y: 100 },
      connections: []
    };

    onWorkflowChange({
      ...workflow,
      steps: [...workflow.steps, newStep]
    });
  }, [workflow, onWorkflowChange]);

  // Handle canvas click to add steps
  const handleCanvasClick = useCallback((e) => {
    if (e.target === canvasRef.current) {
      const rect = canvasRef.current.getBoundingClientRect();
      const position = {
        x: (e.clientX - rect.left - canvasOffset.x) / zoom,
        y: (e.clientY - rect.top - canvasOffset.y) / zoom
      };
      
      // For now, add a default action step
      addStep('action', position);
    }
  }, [addStep, canvasOffset, zoom]);

  // Render workflow step
  const renderStep = (step, index) => (
    <Draggable key={step.id} draggableId={step.id} index={index}>
      {(provided, snapshot) => (
        <div
          ref={provided.innerRef}
          {...provided.draggableProps}
          {...provided.dragHandleProps}
          className={`workflow-step ${step.type} ${
            selectedStep?.id === step.id ? 'selected' : ''
          } ${snapshot.isDragging ? 'dragging' : ''}`}
          style={{
            ...provided.draggableProps.style,
            position: 'absolute',
            left: step.position?.x || 100,
            top: step.position?.y || 100,
            transform: `scale(${zoom})`,
          }}
          onClick={(e) => {
            e.stopPropagation();
            setSelectedStep(step);
          }}
        >
          <div className="step-header flex justify-between items-center mb-2">
            <span className="font-medium text-sm">{step.name}</span>
            <div className="flex gap-1">
              <button
                className="text-xs text-gray-500 hover:text-gray-700"
                onClick={(e) => {
                  e.stopPropagation();
                  // Open step configuration
                }}
              >
                <Settings size={12} />
              </button>
            </div>
          </div>
          <div className="step-content text-xs text-gray-600">
            {step.command || step.type}
          </div>
          {step.description && (
            <div className="step-description text-xs text-gray-500 mt-1">
              {step.description}
            </div>
          )}
        </div>
      )}
    </Draggable>
  );

  return (
    <div className="workflow-canvas-container h-full flex flex-col">
      {/* Toolbar */}
      <div className="toolbar bg-white border-b border-gray-200 p-3 flex gap-2 items-center">
        <button 
          className="toolbar-button primary"
          onClick={() => addStep('action')}
        >
          <Plus size={16} />
          Add Step
        </button>
        
        <div className="separator w-px h-6 bg-gray-300 mx-2" />
        
        <button 
          className="toolbar-button"
          onClick={() => onSave(workflow)}
          disabled={!workflow.steps.length}
        >
          <Save size={16} />
          Save
        </button>
        
        <button 
          className="toolbar-button success"
          onClick={() => onExecute(workflow)}
          disabled={isExecuting || !workflow.steps.length}
        >
          <Play size={16} />
          {isExecuting ? 'Executing...' : 'Execute'}
        </button>
        
        <div className="separator w-px h-6 bg-gray-300 mx-2" />
        
        <button className="toolbar-button" onClick={handleExport}>
          <Download size={16} />
          Export
        </button>
        
        <button className="toolbar-button" onClick={triggerFileImport}>
          <Upload size={16} />
          Import
        </button>

        {/* Hidden file input */}
        <input
          ref={fileInputRef}
          type="file"
          accept=".puml,.json"
          onChange={handleFileImport}
          style={{ display: 'none' }}
        />

        <div className="flex-1" />
        
        {/* Zoom controls */}
        <div className="zoom-controls flex items-center gap-2">
          <button 
            className="toolbar-button"
            onClick={() => setZoom(Math.max(0.5, zoom - 0.1))}
          >
            -
          </button>
          <span className="text-sm font-mono w-12 text-center">
            {Math.round(zoom * 100)}%
          </span>
          <button 
            className="toolbar-button"
            onClick={() => setZoom(Math.min(2, zoom + 0.1))}
          >
            +
          </button>
        </div>
      </div>

      {/* Canvas */}
      <div className="canvas-wrapper flex-1 overflow-hidden relative">
        <DragDropContext onDragEnd={handleDragEnd}>
          <Droppable droppableId="workflow-canvas" type="STEP">
            {(provided, snapshot) => (
              <div
                ref={(el) => {
                  canvasRef.current = el;
                  provided.innerRef(el);
                }}
                {...provided.droppableProps}
                className={`workflow-canvas w-full h-full relative ${
                  snapshot.isDraggingOver ? 'drag-over' : ''
                }`}
                onClick={handleCanvasClick}
                style={{
                  transform: `translate(${canvasOffset.x}px, ${canvasOffset.y}px)`,
                }}
              >
                {workflow.steps.map((step, index) => renderStep(step, index))}
                {provided.placeholder}
                
                {/* Canvas grid background is handled by CSS */}
              </div>
            )}
          </Droppable>
        </DragDropContext>

        {/* Empty state */}
        {workflow.steps.length === 0 && (
          <div className="empty-state absolute inset-0 flex items-center justify-center">
            <div className="text-center text-gray-500">
              <Plus size={48} className="mx-auto mb-4 text-gray-300" />
              <h3 className="text-lg font-medium mb-2">Create Your First Workflow</h3>
              <p className="text-sm">
                Click anywhere on the canvas to add a step, or use the toolbar above
              </p>
            </div>
          </div>
        )}
      </div>

      {/* Step Properties Panel */}
      {selectedStep && (
        <div className="step-properties absolute right-0 top-12 bottom-0 w-80 bg-white border-l border-gray-200 p-4 overflow-y-auto">
          <StepPropertiesPanel 
            step={selectedStep}
            onChange={(updatedStep) => {
              const updatedSteps = workflow.steps.map(s => 
                s.id === selectedStep.id ? updatedStep : s
              );
              onWorkflowChange({
                ...workflow,
                steps: updatedSteps
              });
              setSelectedStep(updatedStep);
            }}
            onClose={() => setSelectedStep(null)}
          />
        </div>
      )}
    </div>
  );
};

// Step properties editing panel
const StepPropertiesPanel = ({ step, onChange, onClose }) => {
  const [localStep, setLocalStep] = useState(step);

  useEffect(() => {
    setLocalStep(step);
  }, [step]);

  const handleChange = (field, value) => {
    const updated = { ...localStep, [field]: value };
    setLocalStep(updated);
    onChange(updated);
  };

  return (
    <div className="step-properties-panel h-full flex flex-col">
      <div className="panel-header flex justify-between items-center mb-4">
        <h3 className="font-medium">Step Properties</h3>
        <button 
          className="text-gray-500 hover:text-gray-700"
          onClick={onClose}
        >
          ×
        </button>
      </div>

      <div className="panel-content flex-1 space-y-4">
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Name
          </label>
          <input
            type="text"
            className="w-full p-2 border border-gray-300 rounded-md"
            value={localStep.name}
            onChange={(e) => handleChange('name', e.target.value)}
          />
        </div>

        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Type
          </label>
          <select
            className="w-full p-2 border border-gray-300 rounded-md"
            value={localStep.type}
            onChange={(e) => handleChange('type', e.target.value)}
          >
            <option value="action">Action</option>
            <option value="decision">Decision</option>
            <option value="parallel">Parallel</option>
            <option value="start">Start</option>
            <option value="end">End</option>
          </select>
        </div>

        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Command
          </label>
          <textarea
            className="w-full p-2 border border-gray-300 rounded-md h-20 font-mono text-sm"
            value={localStep.command}
            onChange={(e) => handleChange('command', e.target.value)}
            placeholder="Enter command or script..."
          />
        </div>

        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Description
          </label>
          <textarea
            className="w-full p-2 border border-gray-300 rounded-md h-16"
            value={localStep.description || ''}
            onChange={(e) => handleChange('description', e.target.value)}
            placeholder="Optional description..."
          />
        </div>

        {/* Parameters section */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-2">
            Parameters
          </label>
          <div className="space-y-2">
            {Object.entries(localStep.parameters || {}).map(([key, value], index) => (
              <div key={index} className="flex gap-2">
                <input
                  type="text"
                  placeholder="Key"
                  className="flex-1 p-2 border border-gray-300 rounded-md text-sm"
                  value={key}
                  onChange={(e) => {
                    const newParams = { ...localStep.parameters };
                    delete newParams[key];
                    newParams[e.target.value] = value;
                    handleChange('parameters', newParams);
                  }}
                />
                <input
                  type="text"
                  placeholder="Value"
                  className="flex-1 p-2 border border-gray-300 rounded-md text-sm"
                  value={value}
                  onChange={(e) => {
                    handleChange('parameters', {
                      ...localStep.parameters,
                      [key]: e.target.value
                    });
                  }}
                />
                <button 
                  className="text-red-500 hover:text-red-700"
                  onClick={() => {
                    const newParams = { ...localStep.parameters };
                    delete newParams[key];
                    handleChange('parameters', newParams);
                  }}
                >
                  ×
                </button>
              </div>
            ))}
            <button 
              className="text-blue-600 hover:text-blue-700 text-sm"
              onClick={() => {
                handleChange('parameters', {
                  ...localStep.parameters,
                  '': ''
                });
              }}
            >
              + Add Parameter
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default WorkflowCanvas;
