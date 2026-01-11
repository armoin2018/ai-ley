---
name: 'Tabletop Simulator'
description: 'See [example-1](./examples/tabletop-simulator/example-1.'
keywords: [common, cli, api, cases, based, advanced, configuration, board, assistant, commands]
---



# Tabletop Simulator Lua Scripting Instructions

## Tool Overview

- **Tool Name**: Tabletop Simulator
- **Version**: 13.3+ (Steam Workshop API 2.0)
- **Category**: Game Development, Lua Scripting
- **Purpose**: Create interactive board games, card games, and tabletop experiences with Lua scripting
- **Prerequisites**: Tabletop Simulator (Steam), basic Lua programming knowledge

## Installation & Setup

### Tabletop Simulator Setup

See [example-1](./examples/tabletop-simulator/example-1.bash)

### Development Environment

See [example-2](./examples/tabletop-simulator/example-2.bash)

## Configuration

### Script Organization

See [example-3](./examples/tabletop-simulator/example-3.lua)

### Project Structure

See [example-4](./examples/tabletop-simulator/example-4.txt)

## Core Features

### Object Interaction System

- **Purpose**: Handle player interactions with game objects
- **Usage**: Respond to clicks, selections, and manipulations
- **Example**:

See [example-5](./examples/tabletop-simulator/example-5.lua)

### UI Management

- **Purpose**: Create custom interfaces and player dashboards
- **Usage**: Build panels, buttons, input fields, and information displays
- **Example**:

See [example-6](./examples/tabletop-simulator/example-6.lua)

### Game State Management

- **Purpose**: Track game progress, player states, and rule enforcement
- **Usage**: Maintain persistent game data and validate player actions
- **Example**:

See [example-7](./examples/tabletop-simulator/example-7.lua)

## Common Commands

See [example-8](./examples/tabletop-simulator/example-8.lua)

## Integration & Workflow

### Development Workflow Integration

1. **Setup**: Create Vagrantfile with object hierarchy and initial scripts
2. **Development**: Use external editor with live reload for rapid iteration
3. **Testing**: Test in multiplayer mode with multiple Steam accounts or AI players
4. **Version Control**: Save scripts and assets to Git repository
5. **Publishing**: Upload to Steam Workshop for community sharing

### External Tool Integration

#### Steam Workshop

See [example-9](./examples/tabletop-simulator/example-9.lua)

#### JSON Data Management

See [example-10](./examples/tabletop-simulator/example-10.lua)

## Best Practices

### Script Organization

- Use modular design with separate scripts for different game systems
- Implement proper error handling and input validation for all player interactions
- Create reusable utility functions in included scripts for common operations
- Use consistent naming conventions for objects, variables, and functions

### Performance Optimization

- Minimize use of expensive operations in frequently called functions (like onUpdate)
- Use coroutines for complex calculations that might cause frame drops
- Cache frequently accessed objects and data rather than repeated API calls
- Implement efficient collision detection and proximity checking for interactive elements

### User Experience Design

- Provide clear visual feedback for all player actions and game state changes
- Implement comprehensive tutorial or help system for complex games
- Use consistent UI design patterns and color schemes throughout the experience
- Include accessibility features like colorblind-friendly indicators and text scaling

## Common Use Cases

### Card Game Implementation

**Scenario**: Create automated card dealing and hand management system
**Implementation**:

See [example-11](./examples/tabletop-simulator/example-11.lua)

**Expected Result**: Automated card distribution with proper hand positioning

### Turn-Based Game Logic

**Scenario**: Implement turn management with action validation
**Implementation**:

See [example-12](./examples/tabletop-simulator/example-12.lua)

**Expected Result**: Smooth turn progression with clear player notifications

### Dynamic Board Generation

**Scenario**: Generate randomized game boards with procedural content
**Implementation**:

See [example-13](./examples/tabletop-simulator/example-13.lua)

**Expected Result**: Procedurally generated board layout for enhanced replayability

## Troubleshooting

### Common Issues

#### Script Execution Errors

**Problem**: Lua runtime errors causing script failures
**Symptoms**: Error messages in chat, scripts not responding to events
**Solution**: Use try-catch patterns and comprehensive error logging

See [example-14](./examples/tabletop-simulator/example-14.lua)

#### Performance Issues

**Problem**: Game slowing down or freezing during script execution
**Symptoms**: Frame rate drops, delayed responses, timeout errors
**Solution**: Optimize scripts and use coroutines for heavy operations

See [example-15](./examples/tabletop-simulator/example-15.lua)

#### Object Reference Issues

**Problem**: Objects become invalid or references break
**Symptoms**: Nil object errors, objects not responding to commands
**Solution**: Implement robust object validation and re-referencing

See [example-16](./examples/tabletop-simulator/example-16.lua)

## Security Considerations

### Script Safety

- Validate all player inputs to prevent exploitation or griefing
- Implement proper access controls for administrative functions
- Use sandboxed environments for testing untrusted scripts
- Regular backup of game saves and script files

### Workshop Security

- Review community scripts before integration
- Test scripts in isolated environments before production use
- Monitor script behavior for unexpected network activity or file access

## Advanced Configuration

### Custom Object Creation

See [example-17](./examples/tabletop-simulator/example-17.lua)

### Physics Integration

See [example-18](./examples/tabletop-simulator/example-18.lua)

## AI Assistant Guidelines

When helping with Tabletop Simulator development:

1. **Always include error handling** in Lua script examples
2. **Provide complete script examples** that can be copied directly
3. **Explain object GUID management** for persistent object references
4. **Include UI examples** for player interaction design
5. **Suggest performance optimizations** for complex game logic
6. **Reference official documentation** for API details
7. **Include multiplayer considerations** for all game mechanics
8. **Provide testing strategies** for script validation

### Code Generation Rules

- Generate Lua scripts following Tabletop Simulator API conventions
- Include comprehensive error handling and input validation
- Provide modular, reusable function designs
- Include detailed comments explaining game logic and mechanics
- Follow object-oriented patterns where appropriate for complex systems

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

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
