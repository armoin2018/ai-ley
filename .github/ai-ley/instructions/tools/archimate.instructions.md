---
name: 'ArchiMate Enterprise Architecture Modeling'
description: 'Comprehensive instructions for using ArchiMate to model enterprise architecture, including core concepts, diagram types, tools, and best practices for AI-assisted enterprise modeling.'
keywords: [(open, cross, common, archimate, archi, bizzdesign, architecture, archimate.instructions, concepts, (soa)]
---


# ArchiMate Enterprise Architecture Modeling Instructions

## Tool Overview

- **Tool Name**: ArchiMate (Architecture Modeling Language)
- **Version**: ArchiMate 3.2 (latest standard)
- **Category**: Enterprise Architecture Modeling
- **Purpose**: Model, analyze, and visualize enterprise architectures across business, application, and technology layers
- **Prerequisites**: Understanding of enterprise architecture concepts, TOGAF framework knowledge (recommended)

## ArchiMate Core Concepts

### Architecture Layers

ArchiMate organizes enterprise architecture into three core layers:

#### Business Layer

- **Purpose**: Models business services, processes, actors, and roles
- **Focus**: Business capabilities, value streams, and organizational structure
- **Key Elements**: Business Actor, Business Role, Business Process, Business Service

#### Application Layer

- **Purpose**: Models application services, functions, and components
- **Focus**: Software applications and their interactions
- **Key Elements**: Application Component, Application Service, Application Function, Data Object

#### Technology Layer

- **Purpose**: Models technology services, infrastructure, and platforms
- **Focus**: Hardware, system software, and communication infrastructure
- **Key Elements**: Node, Device, System Software, Technology Service

### Cross-Layer Elements

#### Strategy Elements

- **Resource**: Strategic asset or capability
- **Capability**: Ability to employ resources to achieve goals
- **Value Stream**: Sequence of activities creating value
- **Course of Action**: Approach to configuring capabilities

#### Motivation Elements

- **Stakeholder**: Individual, team, or organization with interests
- **Driver**: External or internal condition motivating change
- **Assessment**: Outcome of analysis of the state of affairs
- **Goal**: High-level statement of intent or direction
- **Outcome**: End result that has been achieved
- **Principle**: Normative property of all systems
- **Requirement**: Statement of need defining criteria to be fulfilled
- **Constraint**: Restriction on the way objectives are realized

#### Implementation & Migration Elements

- **Work Package**: Series of actions with defined deliverables
- **Deliverable**: Precisely-defined result of a work package
- **Implementation Event**: State change in architecture realization
- **Plateau**: Relatively stable state during implementation

## Viewpoints and Perspectives

### Core Viewpoints

#### Organization Viewpoint

- **Purpose**: Model organizational structure and relationships
- **Elements**: Business Actor, Business Role, Business Collaboration
- **Usage**: Organizational charts, responsibility matrices

#### Business Process Cooperation Viewpoint

- **Purpose**: Show business process relationships and dependencies
- **Elements**: Business Process, Business Interaction, Business Event
- **Usage**: Process flow diagrams, value chain analysis

#### Product Viewpoint

- **Purpose**: Model products and their composition
- **Elements**: Product, Business Service, Contract
- **Usage**: Product portfolios, service catalogs

#### Application Cooperation Viewpoint

- **Purpose**: Show application relationships and dependencies
- **Elements**: Application Component, Application Interface, Data Object
- **Usage**: Application landscape diagrams, integration maps

#### Technology Viewpoint

- **Purpose**: Model technology infrastructure and platforms
- **Elements**: Node, Device, System Software, Technology Interface
- **Usage**: Infrastructure diagrams, deployment models

### Specialized Viewpoints

#### Capability Map Viewpoint

- **Purpose**: High-level view of business capabilities
- **Elements**: Capability, Resource, Business Service
- **Usage**: Capability assessments, strategic planning

#### Value Stream Viewpoint

- **Purpose**: End-to-end value creation processes
- **Elements**: Value Stream, Business Process, Stakeholder
- **Usage**: Value stream mapping, customer journey analysis

#### Strategy Viewpoint

- **Purpose**: Strategic elements and their relationships
- **Elements**: Resource, Capability, Value Stream, Course of Action
- **Usage**: Strategic planning, business model canvas

## Relationship Types

### Structural Relationships

#### Composition

- **Symbol**: Filled diamond
- **Meaning**: Part-of relationship, aggregates elements
- **Example**: Business Process composed of Business Functions

#### Aggregation

- **Symbol**: Empty diamond
- **Meaning**: Groups elements without ownership
- **Example**: Location aggregates various Business Actors

#### Assignment

- **Symbol**: Filled circle with line
- **Meaning**: Allocates responsibility or execution
- **Example**: Business Role assigned to Business Actor

#### Realization

- **Symbol**: Dashed line with empty triangle
- **Meaning**: Implementation or achievement relationship
- **Example**: Application Service realizes Business Service

### Dependency Relationships

#### Serving

- **Symbol**: Arrow
- **Meaning**: Element provides services to another
- **Example**: Application Component serves Business Process

#### Access

- **Symbol**: Arrow with 'r', 'w', 'rw'
- **Meaning**: Data access (read, write, read-write)
- **Example**: Business Process accesses Data Object

#### Influence

- **Symbol**: Dashed arrow
- **Meaning**: Impact or effect on another element
- **Example**: Driver influences Goal

#### Triggering

- **Symbol**: Arrow with 't'
- **Meaning**: Temporal or causal relationship
- **Example**: Business Event triggers Business Process

### Dynamic Relationships

#### Flow

- **Symbol**: Solid arrow
- **Meaning**: Transfer of information, goods, or services
- **Example**: Information flow between Business Processes

#### Specialization

- **Symbol**: Line with empty triangle
- **Meaning**: Is-a relationship, inheritance
- **Example**: Specific Business Role specializes generic Business Role

#### Association

- **Symbol**: Simple line
- **Meaning**: Unspecified relationship
- **Example**: Business Actor associated with Business Object

## ArchiMate Tools and Platforms

### Archi (Open Source)

#### Installation & Setup

See [example-1](./examples/archimate/example-1.bash)

#### Basic Usage

See [example-2](./examples/archimate/example-2.yaml)

#### Key Features

- **Free and open source**
- **Cross-platform compatibility**
- **Model exchange (Open Exchange File format)**
- **CSV import/export**
- **Collaboration features**
- **Plugin ecosystem**

### BiZZdesign Enterprise Studio

#### Professional Features

- **Advanced modeling capabilities**
- **Enterprise repository**
- **Impact analysis**
- **Roadmap planning**
- **Portfolio management**
- **Compliance checking**

#### Integration Capabilities

See [example-3](./examples/archimate/example-3.yaml)

### Visual Paradigm

#### ArchiMate Support

- **Full ArchiMate 3.2 compliance**
- **Model validation**
- **Report generation**
- **Team collaboration**
- **Version control**

### Other Tools

#### Sparx Systems Enterprise Architect

- **UML and ArchiMate integration**
- **Requirements traceability**
- **Simulation capabilities**

#### ARIS

- **Process-centric modeling**
- **Governance integration**
- **Risk management**

## Modeling Best Practices

### Model Organization

#### Layered Approach

See [example-4](./examples/archimate/example-4.yaml)

#### Naming Conventions

See [example-5](./examples/archimate/example-5.yaml)

### View Development Strategy

#### Progressive Elaboration

1. **High-Level Context**: Start with stakeholder and capability views
2. **Business Architecture**: Develop business process and service views
3. **Application Architecture**: Model application landscape and data flows
4. **Technology Architecture**: Detail infrastructure and platform views
5. **Implementation Views**: Create migration and project views

#### Audience-Specific Views

See [example-6](./examples/archimate/example-6.yaml)

### Quality Guidelines

#### Model Consistency

- **Use consistent abstraction levels**
- **Apply naming conventions uniformly**
- **Validate relationship semantics**
- **Ensure cross-layer alignment**

#### Semantic Accuracy

- **Verify element purposes match their usage**
- **Check relationship types are appropriate**
- **Ensure no contradictory relationships**
- **Validate business logic representation**

## Common Modeling Patterns

### Service-Oriented Architecture (SOA) Pattern

See [example-7](./examples/archimate/example-7.yaml)

*Content optimized for conciseness. See external references for additional details.*

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
