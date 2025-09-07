// components/ExecutionDashboard.jsx
import {
    AlertTriangle,
    CheckCircle,
    ChevronDown,
    ChevronRight,
    Clock,
    FileText,
    Pause,
    Play,
    RotateCcw,
    Square,
    Terminal,
    XCircle
} from 'lucide-react';
import { useEffect, useState } from 'react';

const ExecutionDashboard = ({ 
  workflow, 
  execution, 
  onExecute, 
  onPause, 
  onStop, 
  onReset,
  isExecuting = false 
}) => {
  const [expandedSteps, setExpandedSteps] = useState(new Set());
  const [logs, setLogs] = useState([]);

  // Update logs when execution changes
  useEffect(() => {
    if (execution?.logs) {
      setLogs(execution.logs);
    }
  }, [execution]);

  // Toggle step expansion
  const toggleStep = (stepId) => {
    const newExpanded = new Set(expandedSteps);
    if (newExpanded.has(stepId)) {
      newExpanded.delete(stepId);
    } else {
      newExpanded.add(stepId);
    }
    setExpandedSteps(newExpanded);
  };

  // Get status icon for step
  const getStatusIcon = (status) => {
    switch (status) {
      case 'completed':
        return <CheckCircle size={16} className="text-green-500" />;
      case 'error':
        return <XCircle size={16} className="text-red-500" />;
      case 'running':
        return <Clock size={16} className="text-blue-500 animate-spin" />;
      case 'pending':
        return <Clock size={16} className="text-gray-400" />;
      case 'warning':
        return <AlertTriangle size={16} className="text-yellow-500" />;
      default:
        return <Clock size={16} className="text-gray-400" />;
    }
  };

  // Format duration
  const formatDuration = (ms) => {
    if (!ms) return '-';
    const seconds = Math.floor(ms / 1000);
    const minutes = Math.floor(seconds / 60);
    if (minutes > 0) {
      return `${minutes}m ${seconds % 60}s`;
    }
    return `${seconds}s`;
  };

  // Get overall execution status
  const getExecutionStatus = () => {
    if (!execution) return 'pending';
    if (execution.status) return execution.status;
    if (isExecuting) return 'running';
    return 'pending';
  };

  const executionStatus = getExecutionStatus();
  const totalSteps = workflow?.steps?.length || 0;
  const completedSteps = execution?.steps?.filter(s => s.status === 'completed').length || 0;
  const errorSteps = execution?.steps?.filter(s => s.status === 'error').length || 0;

  return (
    <div className="execution-dashboard h-full flex flex-col bg-white">
      {/* Header */}
      <div className="dashboard-header border-b border-gray-200 p-4">
        <div className="flex justify-between items-center mb-3">
          <h2 className="text-lg font-semibold">Execution Dashboard</h2>
          <div className="execution-controls flex gap-2">
            <button
              className="toolbar-button success"
              onClick={() => onExecute(workflow)}
              disabled={isExecuting || !totalSteps}
            >
              <Play size={16} />
              {isExecuting ? 'Running' : 'Execute'}
            </button>
            
            {isExecuting && (
              <button
                className="toolbar-button"
                onClick={onPause}
              >
                <Pause size={16} />
                Pause
              </button>
            )}
            
            <button
              className="toolbar-button danger"
              onClick={onStop}
              disabled={!isExecuting}
            >
              <Square size={16} />
              Stop
            </button>
            
            <button
              className="toolbar-button"
              onClick={onReset}
            >
              <RotateCcw size={16} />
              Reset
            </button>
          </div>
        </div>

        {/* Status Summary */}
        <div className="status-summary grid grid-cols-4 gap-4">
          <div className="status-card bg-gray-50 p-3 rounded-lg">
            <div className="text-sm text-gray-600">Status</div>
            <div className={`font-semibold capitalize flex items-center gap-2 ${
              executionStatus === 'completed' ? 'text-green-600' :
              executionStatus === 'error' ? 'text-red-600' :
              executionStatus === 'running' ? 'text-blue-600' :
              'text-gray-600'
            }`}>
              {getStatusIcon(executionStatus)}
              {executionStatus}
            </div>
          </div>
          
          <div className="status-card bg-gray-50 p-3 rounded-lg">
            <div className="text-sm text-gray-600">Progress</div>
            <div className="font-semibold">
              {completedSteps} / {totalSteps}
            </div>
            <div className="w-full bg-gray-200 rounded-full h-2 mt-1">
              <div 
                className="bg-blue-600 h-2 rounded-full transition-all duration-300"
                style={{ width: `${totalSteps ? (completedSteps / totalSteps) * 100 : 0}%` }}
              />
            </div>
          </div>
          
          <div className="status-card bg-gray-50 p-3 rounded-lg">
            <div className="text-sm text-gray-600">Duration</div>
            <div className="font-semibold">
              {formatDuration(execution?.duration)}
            </div>
          </div>
          
          <div className="status-card bg-gray-50 p-3 rounded-lg">
            <div className="text-sm text-gray-600">Errors</div>
            <div className={`font-semibold ${errorSteps > 0 ? 'text-red-600' : 'text-gray-600'}`}>
              {errorSteps}
            </div>
          </div>
        </div>
      </div>

      {/* Steps List */}
      <div className="steps-list flex-1 overflow-y-auto">
        {workflow?.steps?.map((step, index) => {
          const executionStep = execution?.steps?.find(s => s.id === step.id) || {};
          const isExpanded = expandedSteps.has(step.id);
          
          return (
            <div key={step.id} className={`execution-step ${executionStep.status || 'pending'}`}>
              <div 
                className="step-header flex items-center justify-between p-3 cursor-pointer hover:bg-gray-50"
                onClick={() => toggleStep(step.id)}
              >
                <div className="flex items-center gap-3">
                  <div className="step-number bg-gray-200 text-gray-600 w-6 h-6 rounded-full flex items-center justify-center text-sm font-medium">
                    {index + 1}
                  </div>
                  {getStatusIcon(executionStep.status)}
                  <div>
                    <div className="font-medium">{step.name}</div>
                    <div className="text-sm text-gray-500">{step.type}</div>
                  </div>
                </div>
                
                <div className="flex items-center gap-2">
                  {executionStep.duration && (
                    <span className="text-sm text-gray-500">
                      {formatDuration(executionStep.duration)}
                    </span>
                  )}
                  {isExpanded ? <ChevronDown size={16} /> : <ChevronRight size={16} />}
                </div>
              </div>
              
              {isExpanded && (
                <div className="step-details p-3 pt-0 border-t border-gray-100">
                  {step.command && (
                    <div className="mb-3">
                      <div className="text-sm font-medium text-gray-700 mb-1">Command:</div>
                      <code className="text-sm bg-gray-100 p-2 rounded block font-mono">
                        {step.command}
                      </code>
                    </div>
                  )}
                  
                  {executionStep.output && (
                    <div className="mb-3">
                      <div className="text-sm font-medium text-gray-700 mb-1 flex items-center gap-2">
                        <Terminal size={14} />
                        Output:
                      </div>
                      <pre className="text-sm bg-gray-900 text-green-400 p-3 rounded overflow-x-auto max-h-40">
                        {executionStep.output}
                      </pre>
                    </div>
                  )}
                  
                  {executionStep.error && (
                    <div className="mb-3">
                      <div className="text-sm font-medium text-red-700 mb-1 flex items-center gap-2">
                        <XCircle size={14} />
                        Error:
                      </div>
                      <pre className="text-sm bg-red-50 text-red-700 p-3 rounded border border-red-200">
                        {executionStep.error}
                      </pre>
                    </div>
                  )}
                  
                  {executionStep.logs && executionStep.logs.length > 0 && (
                    <div>
                      <div className="text-sm font-medium text-gray-700 mb-1 flex items-center gap-2">
                        <FileText size={14} />
                        Logs:
                      </div>
                      <div className="text-sm space-y-1 max-h-32 overflow-y-auto">
                        {executionStep.logs.map((log, logIndex) => (
                          <div key={logIndex} className="flex gap-2">
                            <span className="text-gray-500 font-mono text-xs">
                              {new Date(log.timestamp).toLocaleTimeString()}
                            </span>
                            <span className={`${
                              log.level === 'error' ? 'text-red-600' :
                              log.level === 'warn' ? 'text-yellow-600' :
                              log.level === 'info' ? 'text-blue-600' :
                              'text-gray-600'
                            }`}>
                              {log.message}
                            </span>
                          </div>
                        ))}
                      </div>
                    </div>
                  )}
                </div>
              )}
            </div>
          );
        })}
        
        {/* Empty state */}
        {!workflow?.steps?.length && (
          <div className="empty-state p-8 text-center text-gray-500">
            <Terminal size={48} className="mx-auto mb-4 text-gray-300" />
            <h3 className="text-lg font-medium mb-2">No Steps to Execute</h3>
            <p className="text-sm">Add steps to your workflow to see execution details here</p>
          </div>
        )}
      </div>

      {/* Footer with overall logs */}
      {logs.length > 0 && (
        <div className="execution-logs border-t border-gray-200 bg-gray-50">
          <div className="p-3 border-b border-gray-200">
            <h3 className="font-medium text-sm">Execution Logs</h3>
          </div>
          <div className="max-h-32 overflow-y-auto p-3 font-mono text-xs">
            {logs.map((log, index) => (
              <div key={index} className="flex gap-2 mb-1">
                <span className="text-gray-500">
                  {new Date(log.timestamp).toLocaleTimeString()}
                </span>
                <span className={`${
                  log.level === 'error' ? 'text-red-600' :
                  log.level === 'warn' ? 'text-yellow-600' :
                  'text-gray-600'
                }`}>
                  [{log.level.toUpperCase()}]
                </span>
                <span>{log.message}</span>
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  );
};

export default ExecutionDashboard;
