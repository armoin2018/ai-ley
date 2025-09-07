# build-registry.md

## Objective

- Build a json registry of the personas, instructions, workflows, schemas, prompts, and policies using the

## Variables

- Folders, Files and Indexes are stored in `{{folders.shared}}/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`

## Steps

- Scan the following folders recursively

  - {{folders.shared}}/personas
  - {{folders.shared}}/instructions
  - {{folders.shared}}/workflows
  - {{folders.shared}}/schemas
  - {{folders.shared}}/prompts
  - {{folders.shared}}/policies

- Make sure that each file has a header that includes the following elements in yaml format:

```yaml
---
applyTo: 'angular, @angular'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on Angular 18+ with standalone components and signals'
title: 'Angular Best Practices'
description: 'A comprehensive guide to best practices in Angular development.'
version: '1.0.0'
author: 'John Doe'
lastUpdated: '2023-10-01T12:00:00Z'
keywords:  'angular', 'best practices', 'development'
extensions:  '.md', '.yaml'
summaryScore: 5
---
```

- If elements are missing, the file should be analysed and the missing elements should be added to the file

  - Documents should be scored based on completeness and accuracy utilizing the scoring defined in `.ai-ley/shared/prompts/update-(instructions|personas).md`

- if the score is <= 4.5, suggestions should be generated and added to the `{{files.suggestions}}`

## Exclude Files

- README.md
- CHANGES.md

## Output

- Output to `{{files.registry}}`

### Example Format

```json
{
	"personas": {
		"name": {
			"path": ".ai-ley/shared/personas/category/name.md",
            "applyTo": "angular, @angular",
            "agentMode": "framework-specific",
            "instructionType": "guide",
            "guidelines": "Focus on Angular 18+ with standalone components and signals",
            "title": "Angular Best Practices",
			"description": "Example Description",
			"version": "0.3.0",
            "last-updated": "2023-10-01T12:00:00Z",
			"md5sum": "cd97120eba38c4269a040beb812666d2",
			"keywords": [ "template", "frameworks", "architecture", "integration" ],
			"score": "4.9",
			"extensions": [ ".md", ".yaml" ]
		}
	},
	"instructions": {
		"name": {
			"path": ".ai-ley/shared/instructions/category/name.md",
			"applyTo": "angular, @angular",
            "agentMode": "framework-specific",
            "instructionType": "guide",
            "guidelines": "Focus on Angular 18+ with standalone components and signals",
            "title": "Angular Best Practices",
			"description": "Example Description",
			"version": "0.3.0",
            "last-updated": "2023-10-01T12:00:00Z",
			"md5sum": "cd97120eba38c4269a040beb812666d2",
			"keywords": [ "template", "frameworks", "architecture", "integration" ],
			"summary": "Example Description",
			"score": "4.9",
			"extensions": [ ".md", ".yaml" ]
		}
	},
	"workflows": {
		"name": {
			"path": ".ai-ley/shared/workflows/name.md",
			"applyTo": "angular, @angular",
            "agentMode": "framework-specific",
            "instructionType": "guide",
            "guidelines": "Focus on Angular 18+ with standalone components and signals",
            "title": "Angular Best Practices",
			"description": "Example Description",
			"version": "0.3.0",
            "last-updated": "2023-10-01T12:00:00Z",
			"md5sum": "cd97120eba38c4269a040beb812666d2",
			"keywords": [ "template", "frameworks", "architecture", "integration" ],
			"summary": "Example Description",
			"score": "4.9"
		}
	},
	"prompts": {
		"name": {
			"path": ".ai-ley/shared/prompts/name.md",
            "applyTo": "angular, @angular",
            "agentMode": "framework-specific",
            "instructionType": "guide",
            "guidelines": "Focus on Angular 18+ with standalone components and signals",
            "title": "Angular Best Practices",
			"description": "Example Description",
			"version": "0.3.0",
            "last-updated": "2023-10-01T12:00:00Z",
			"md5sum": "cd97120eba38c4269a040beb812666d2",
			"keywords": [ "template", "frameworks", "architecture", "integration" ],
			"summary": "Example Description",
			"score": "4.9"
	},
	"policies": {
		"name": {
			"path": ".ai-ley/shared/policies/name.md",
            "applyTo": "angular, @angular",
            "agentMode": "framework-specific",
            "instructionType": "guide",
            "guidelines": "Focus on Angular 18+ with standalone components and signals",
            "title": "Angular Best Practices",
			"description": "Example Description",
			"version": "0.3.0",
            "last-updated": "2023-10-01T12:00:00Z",
			"md5sum": "cd97120eba38c4269a040beb812666d2",
			"keywords": [ "template", "frameworks", "architecture", "integration" ],
			"summary": "Example Description",
			"score": "4.9"
		}
	},
    "schemas": {
		"name": {
			"path": ".ai-ley/shared/schemas/name.yaml",
            "applyTo": "angular, @angular",
            "agentMode": "framework-specific",
            "instructionType": "guide",
            "guidelines": "Focus on Angular 18+ with standalone components and signals",
            "title": "Angular Best Practices",
			"description": "Example Description",
			"version": "0.3.0",
            "last-updated": "2023-10-01T12:00:00Z",
			"md5sum": "cd97120eba38c4269a040beb812666d2",
			"keywords": [ "template", "frameworks", "architecture", "integration" ],
			"summary": "Example Description",
			"score": "4.9"
		}
	}
}
```
