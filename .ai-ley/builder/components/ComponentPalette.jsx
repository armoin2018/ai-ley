// components/ComponentPalette.jsx
import {
    ChevronDown,
    ChevronRight,
    Circle,
    Cloud,
    Code,
    Database,
    Diamond,
    FileText,
    GitBranch,
    Globe,
    Mail,
    Package,
    Play,
    Search,
    Settings,
    Square,
    Timer
} from 'lucide-react';
import { useState } from 'react';

// Component categories and definitions
const COMPONENT_CATEGORIES = {
  'Basic Flow': {
    icon: Play,
    components: [
      {
        id: 'start',
        name: 'Start',
        type: 'start',
        icon: Circle,
        description: 'Begin workflow execution',
        template: {
          name: 'Start',
          command: '',
          parameters: {}
        }
      },
      {
        id: 'action',
        name: 'Action',
        type: 'action',
        icon: Square,
        description: 'Execute a command or script',
        template: {
          name: 'New Action',
          command: 'echo "Hello World"',
          parameters: {}
        }
      },
      {
        id: 'decision',
        name: 'Decision',
        type: 'decision',
        icon: Diamond,
        description: 'Conditional branching based on criteria',
        template: {
          name: 'Decision Point',
          command: 'test -f "file.txt"',
          parameters: {
            'true_path': 'continue',
            'false_path': 'alternative'
          }
        }
      },
      {
        id: 'parallel',
        name: 'Parallel',
        type: 'parallel',
        icon: GitBranch,
        description: 'Execute multiple tasks simultaneously',
        template: {
          name: 'Parallel Tasks',
          command: '',
          parameters: {
            'max_concurrent': '3'
          }
        }
      },
      {
        id: 'end',
        name: 'End',
        type: 'end',
        icon: Circle,
        description: 'Terminate workflow execution',
        template: {
          name: 'End',
          command: '',
          parameters: {}
        }
      }
    ]
  },
  'System Operations': {
    icon: Settings,
    components: [
      {
        id: 'file_read',
        name: 'Read File',
        type: 'action',
        icon: FileText,
        description: 'Read content from a file',
        template: {
          name: 'Read File',
          command: 'cat "${file_path}"',
          parameters: {
            'file_path': '/path/to/file.txt'
          }
        }
      },
      {
        id: 'file_write',
        name: 'Write File',
        type: 'action',
        icon: FileText,
        description: 'Write content to a file',
        template: {
          name: 'Write File',
          command: 'echo "${content}" > "${file_path}"',
          parameters: {
            'content': 'Hello World',
            'file_path': '/path/to/output.txt'
          }
        }
      },
      {
        id: 'wait',
        name: 'Wait/Sleep',
        type: 'action',
        icon: Timer,
        description: 'Pause execution for specified time',
        template: {
          name: 'Wait',
          command: 'sleep ${duration}',
          parameters: {
            'duration': '5'
          }
        }
      }
    ]
  },
  'Web & API': {
    icon: Globe,
    components: [
      {
        id: 'http_get',
        name: 'HTTP GET',
        type: 'action',
        icon: Globe,
        description: 'Make HTTP GET request',
        template: {
          name: 'HTTP GET',
          command: 'curl -X GET "${url}" -H "${headers}"',
          parameters: {
            'url': 'https://api.example.com/data',
            'headers': 'Content-Type: application/json'
          }
        }
      },
      {
        id: 'http_post',
        name: 'HTTP POST',
        type: 'action',
        icon: Globe,
        description: 'Make HTTP POST request',
        template: {
          name: 'HTTP POST',
          command: 'curl -X POST "${url}" -H "${headers}" -d "${data}"',
          parameters: {
            'url': 'https://api.example.com/submit',
            'headers': 'Content-Type: application/json',
            'data': '{"key": "value"}'
          }
        }
      },
      {
        id: 'webhook',
        name: 'Webhook',
        type: 'action',
        icon: Globe,
        description: 'Send webhook notification',
        template: {
          name: 'Send Webhook',
          command: 'curl -X POST "${webhook_url}" -d "${payload}"',
          parameters: {
            'webhook_url': 'https://hooks.example.com/webhook',
            'payload': '{"event": "workflow_completed"}'
          }
        }
      }
    ]
  },
  'Data Processing': {
    icon: Database,
    components: [
      {
        id: 'csv_read',
        name: 'Read CSV',
        type: 'action',
        icon: Database,
        description: 'Read and process CSV data',
        template: {
          name: 'Read CSV',
          command: 'cat "${csv_file}" | csvcut -c "${columns}"',
          parameters: {
            'csv_file': 'data.csv',
            'columns': '1,2,3'
          }
        }
      },
      {
        id: 'json_parse',
        name: 'Parse JSON',
        type: 'action',
        icon: Code,
        description: 'Extract data from JSON',
        template: {
          name: 'Parse JSON',
          command: 'cat "${json_file}" | jq "${query}"',
          parameters: {
            'json_file': 'data.json',
            'query': '.results[] | .name'
          }
        }
      },
      {
        id: 'data_transform',
        name: 'Transform Data',
        type: 'action',
        icon: Settings,
        description: 'Transform or filter data',
        template: {
          name: 'Transform Data',
          command: 'cat "${input}" | ${transform_command} > "${output}"',
          parameters: {
            'input': 'input.txt',
            'transform_command': 'sort | uniq',
            'output': 'output.txt'
          }
        }
      }
    ]
  },
  'Deployment': {
    icon: Cloud,
    components: [
      {
        id: 'docker_build',
        name: 'Docker Build',
        type: 'action',
        icon: Package,
        description: 'Build Docker image',
        template: {
          name: 'Docker Build',
          command: 'docker build -t "${image_name}:${tag}" "${context_path}"',
          parameters: {
            'image_name': 'my-app',
            'tag': 'latest',
            'context_path': '.'
          }
        }
      },
      {
        id: 'docker_run',
        name: 'Docker Run',
        type: 'action',
        icon: Play,
        description: 'Run Docker container',
        template: {
          name: 'Docker Run',
          command: 'docker run -d -p "${port}:${container_port}" "${image_name}:${tag}"',
          parameters: {
            'image_name': 'my-app',
            'tag': 'latest',
            'port': '8080',
            'container_port': '80'
          }
        }
      },
      {
        id: 'deploy_cloud',
        name: 'Cloud Deploy',
        type: 'action',
        icon: Cloud,
        description: 'Deploy to cloud platform',
        template: {
          name: 'Cloud Deploy',
          command: 'vercel --prod',
          parameters: {
            'platform': 'vercel'
          }
        }
      }
    ]
  },
  'Notifications': {
    icon: Mail,
    components: [
      {
        id: 'email',
        name: 'Send Email',
        type: 'action',
        icon: Mail,
        description: 'Send email notification',
        template: {
          name: 'Send Email',
          command: 'echo "${message}" | mail -s "${subject}" "${recipient}"',
          parameters: {
            'recipient': 'user@example.com',
            'subject': 'Workflow Notification',
            'message': 'Workflow completed successfully'
          }
        }
      },
      {
        id: 'slack',
        name: 'Slack Message',
        type: 'action',
        icon: Mail,
        description: 'Send Slack notification',
        template: {
          name: 'Slack Message',
          command: 'curl -X POST "${slack_webhook}" -d "{\\"text\\": \\"${message}\\"}"',
          parameters: {
            'slack_webhook': 'https://hooks.slack.com/...',
            'message': 'Workflow completed'
          }
        }
      }
    ]
  }
};

const ComponentPalette = ({ onAddComponent, searchQuery = '', className = '' }) => {
  const [expandedCategories, setExpandedCategories] = useState(new Set(['Basic Flow']));
  const [localSearch, setLocalSearch] = useState(searchQuery);

  // Toggle category expansion
  const toggleCategory = (categoryName) => {
    const newExpanded = new Set(expandedCategories);
    if (newExpanded.has(categoryName)) {
      newExpanded.delete(categoryName);
    } else {
      newExpanded.add(categoryName);
    }
    setExpandedCategories(newExpanded);
  };

  // Filter components based on search
  const filterComponents = (components, query) => {
    if (!query.trim()) return components;
    const lowerQuery = query.toLowerCase();
    return components.filter(comp => 
      comp.name.toLowerCase().includes(lowerQuery) ||
      comp.description.toLowerCase().includes(lowerQuery) ||
      comp.type.toLowerCase().includes(lowerQuery)
    );
  };

  // Handle drag start
  const handleDragStart = (e, component) => {
    e.dataTransfer.setData('application/json', JSON.stringify(component));
    e.dataTransfer.effectAllowed = 'copy';
  };

  // Handle click to add component
  const handleAddComponent = (component) => {
    if (onAddComponent) {
      onAddComponent({
        ...component.template,
        type: component.type,
        id: `${component.id}_${Date.now()}`,
        position: { x: 150, y: 150 } // Default position
      });
    }
  };

  return (
    <div className={`component-palette ${className}`}>
      {/* Search */}
      <div className="palette-search mb-4">
        <div className="relative">
          <Search size={16} className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400" />
          <input
            type="text"
            placeholder="Search components..."
            className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            value={localSearch}
            onChange={(e) => setLocalSearch(e.target.value)}
          />
        </div>
      </div>

      {/* Categories */}
      <div className="palette-categories space-y-2">
        {Object.entries(COMPONENT_CATEGORIES).map(([categoryName, category]) => {
          const isExpanded = expandedCategories.has(categoryName);
          const filteredComponents = filterComponents(category.components, localSearch);
          
          // Hide empty categories when searching
          if (localSearch.trim() && filteredComponents.length === 0) {
            return null;
          }
          
          const CategoryIcon = category.icon;
          
          return (
            <div key={categoryName} className="category">
              <button
                className="category-header w-full flex items-center justify-between p-2 hover:bg-gray-50 rounded-md text-left"
                onClick={() => toggleCategory(categoryName)}
              >
                <div className="flex items-center gap-2">
                  <CategoryIcon size={16} className="text-gray-600" />
                  <span className="font-medium text-sm">{categoryName}</span>
                  <span className="text-xs text-gray-500">
                    ({filteredComponents.length})
                  </span>
                </div>
                {isExpanded ? <ChevronDown size={16} /> : <ChevronRight size={16} />}
              </button>
              
              {isExpanded && (
                <div className="category-components ml-4 space-y-1 mt-2">
                  {filteredComponents.map((component) => {
                    const ComponentIcon = component.icon;
                    
                    return (
                      <div
                        key={component.id}
                        className="palette-component"
                        draggable
                        onDragStart={(e) => handleDragStart(e, component)}
                        onClick={() => handleAddComponent(component)}
                        title={component.description}
                      >
                        <div className="flex items-center gap-2 mb-1">
                          <ComponentIcon size={14} className="text-gray-600 flex-shrink-0" />
                          <span className="font-medium text-sm">{component.name}</span>
                        </div>
                        <div className="text-xs text-gray-500 line-clamp-2">
                          {component.description}
                        </div>
                      </div>
                    );
                  })}
                </div>
              )}
            </div>
          );
        })}
      </div>

      {/* No results message */}
      {localSearch.trim() && 
       Object.values(COMPONENT_CATEGORIES).every(cat => 
         filterComponents(cat.components, localSearch).length === 0
       ) && (
        <div className="no-results text-center py-8 text-gray-500">
          <Search size={32} className="mx-auto mb-2 text-gray-300" />
          <p className="text-sm">No components found</p>
          <p className="text-xs">Try a different search term</p>
        </div>
      )}

      {/* Usage instructions */}
      <div className="palette-help mt-6 p-3 bg-blue-50 rounded-lg border border-blue-200">
        <h4 className="text-sm font-medium text-blue-800 mb-2">How to Use</h4>
        <ul className="text-xs text-blue-700 space-y-1">
          <li>• Click components to add to canvas</li>
          <li>• Drag & drop for precise positioning</li>
          <li>• Select steps to edit properties</li>
          <li>• Connect steps by drawing lines</li>
        </ul>
      </div>
    </div>
  );
};

export default ComponentPalette;
