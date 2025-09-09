// components/PlantUMLPreview.jsx
import { Check, Code, Copy, Download, Eye, FileText, RotateCcw } from 'lucide-react';
import { useEffect, useMemo, useState } from 'react';

const PlantUMLPreview = ({ 
  workflow, 
  plantUMLCode,
  onCodeChange,
  showEditor = true,
  showPreview = true 
}) => {
  const [activeTab, setActiveTab] = useState('preview');
  const [localCode, setLocalCode] = useState('');
  const [copied, setCopied] = useState(false);
  const [isGenerating, setIsGenerating] = useState(false);

  // Generate PlantUML from workflow
  const generatedCode = useMemo(() => {
    if (!workflow || !workflow.steps?.length) {
      return `@startuml
title Empty Workflow
note "Click 'Add Step' to begin creating your workflow" as N1
@enduml`;
    }

    const lines = ['@startuml'];
    
    // Add title if available
    if (workflow.name) {
      lines.push(`title ${workflow.name}`);
    }
    
    if (workflow.description) {
      lines.push(`note top : ${workflow.description}`);
    }
    
    lines.push('');

    // Generate workflow steps
    let hasStart = false;
    let hasEnd = false;

    workflow.steps.forEach((step, index) => {
      const stepId = step.id || `step_${index}`;
      
      switch (step.type) {
        case 'start':
          lines.push(`start`);
          hasStart = true;
          break;
          
        case 'end':
          lines.push(`stop`);
          hasEnd = true;
          break;
          
        case 'action':
          const actionText = step.command || step.name || 'Action';
          lines.push(`:${actionText};`);
          if (step.description) {
            lines.push(`note right : ${step.description}`);
          }
          break;
          
        case 'decision':
          const decisionText = step.command || step.name || 'Decision';
          lines.push(`if (${decisionText}) then (yes)`);
          lines.push('  :Continue;');
          lines.push('else (no)');
          lines.push('  :Alternative action;');
          lines.push('endif');
          break;
          
        case 'parallel':
          lines.push('fork');
          lines.push(`  :${step.name || 'Parallel Task 1'};`);
          lines.push('fork again');
          lines.push(`  :${step.name || 'Parallel Task 2'};`);
          lines.push('end fork');
          break;
          
        default:
          lines.push(`:${step.name || 'Unknown Step'};`);
      }
    });

    // Add start/end if missing
    if (!hasStart && workflow.steps.length > 0) {
      lines.splice(workflow.name ? 3 : 1, 0, 'start', '');
    }
    
    if (!hasEnd && workflow.steps.length > 0) {
      lines.push('', 'stop');
    }

    lines.push('@enduml');
    
    return lines.join('\n');
  }, [workflow]);

  // Update local code when generated code changes
  useEffect(() => {
    if (!localCode || localCode === plantUMLCode) {
      setLocalCode(generatedCode);
    }
  }, [generatedCode, plantUMLCode, localCode]);

  // Handle code changes
  const handleCodeChange = (newCode) => {
    setLocalCode(newCode);
    if (onCodeChange) {
      onCodeChange(newCode);
    }
  };

  // Copy to clipboard
  const handleCopy = async () => {
    try {
      await navigator.clipboard.writeText(localCode);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch (err) {
      console.error('Failed to copy:', err);
    }
  };

  // Generate diagram image URL (using PlantUML server)
  const getDiagramUrl = (code) => {
    try {
      const encoded = btoa(unescape(encodeURIComponent(code)));
      return `https://www.plantuml.com/plantuml/svg/${encoded}`;
    } catch (err) {
      console.error('Failed to encode PlantUML:', err);
      return null;
    }
  };

  // Download PlantUML file
  const handleDownload = () => {
    const blob = new Blob([localCode], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `${workflow.name || 'workflow'}.puml`;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
  };

  // Regenerate from workflow
  const handleRegenerate = () => {
    setIsGenerating(true);
    setLocalCode(generatedCode);
    if (onCodeChange) {
      onCodeChange(generatedCode);
    }
    setTimeout(() => setIsGenerating(false), 500);
  };

  const diagramUrl = getDiagramUrl(localCode);

  return (
    <div className="plantuml-preview h-full flex flex-col">
      {/* Header */}
      <div className="preview-header bg-white border-b border-gray-200 p-3">
        <div className="flex justify-between items-center">
          <div className="flex gap-2">
            {showPreview && (
              <button
                className={`toolbar-button ${activeTab === 'preview' ? 'active' : ''}`}
                onClick={() => setActiveTab('preview')}
              >
                <Eye size={16} />
                Preview
              </button>
            )}
            {showEditor && (
              <button
                className={`toolbar-button ${activeTab === 'code' ? 'active' : ''}`}
                onClick={() => setActiveTab('code')}
              >
                <Code size={16} />
                Code
              </button>
            )}
          </div>
          
          <div className="flex gap-2">
            <button 
              className="toolbar-button"
              onClick={handleRegenerate}
              disabled={isGenerating}
              title="Regenerate from workflow"
            >
              <RotateCcw size={16} className={isGenerating ? 'animate-spin' : ''} />
            </button>
            
            <button 
              className="toolbar-button"
              onClick={handleCopy}
              title="Copy to clipboard"
            >
              {copied ? <Check size={16} /> : <Copy size={16} />}
            </button>
            
            <button 
              className="toolbar-button"
              onClick={handleDownload}
              title="Download PlantUML file"
            >
              <Download size={16} />
            </button>
          </div>
        </div>
      </div>

      {/* Content */}
      <div className="preview-content flex-1 overflow-hidden">
        {activeTab === 'preview' ? (
          <div className="diagram-preview h-full overflow-auto p-4 bg-gray-50">
            {diagramUrl ? (
              <div className="flex justify-center">
                <img 
                  src={diagramUrl}
                  alt="PlantUML Diagram"
                  className="max-w-full h-auto"
                  onError={(e) => {
                    e.target.style.display = 'none';
                    e.target.nextSibling.style.display = 'block';
                  }}
                />
                <div className="error-message hidden p-4 text-center text-gray-500">
                  <FileText size={48} className="mx-auto mb-2" />
                  <p>Unable to render diagram</p>
                  <p className="text-sm">Check the PlantUML syntax in the Code tab</p>
                </div>
              </div>
            ) : (
              <div className="error-message p-4 text-center text-gray-500">
                <FileText size={48} className="mx-auto mb-2" />
                <p>Unable to generate diagram URL</p>
                <p className="text-sm">Please check your PlantUML code</p>
              </div>
            )}
          </div>
        ) : (
          <div className="code-editor h-full">
            <textarea
              className="plantuml-editor w-full h-full p-4 border-none resize-none focus:outline-none"
              value={localCode}
              onChange={(e) => handleCodeChange(e.target.value)}
              placeholder="PlantUML code will appear here..."
              spellCheck={false}
            />
          </div>
        )}
      </div>

      {/* Footer with stats */}
      <div className="preview-footer bg-gray-50 border-t border-gray-200 px-3 py-2 text-xs text-gray-500">
        <div className="flex justify-between">
          <span>{localCode.split('\n').length} lines</span>
          <span>{localCode.length} characters</span>
        </div>
      </div>
    </div>
  );
};

export default PlantUMLPreview;
