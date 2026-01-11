---
name: 'Three Js.Instructions'
description: 'Use Three.'
keywords: [animation, agent, architecture, api, advanced, backend, agents, avoid, camera, camera,]
---



# Three.js Framework Instructions for AI Agents

## When to Use Three.js

Use Three.js when you need:

- 3D graphics and visualizations in web browsers
- WebGL-based rendering with cross-platform compatibility
- Interactive 3D experiences and applications
- Data visualization with 3D elements
- VR/AR web applications using WebXR
- 3D animations and artistic projects
- Product configurators and 3D viewers
- Architectural or engineering visualizations

## When to Avoid Three.js

Consider alternatives when:

- Simple 2D games or animations (Phaser, Canvas API)
- High-performance native 3D applications (Unity, Unreal Engine)
- Mobile-first applications requiring extensive optimization
- Complex physics simulations (dedicated physics engines)
- Enterprise desktop applications (Qt, Electron with native libraries)
- Real-time multiplayer 3D games requiring server-side physics

## Framework Overview
- **Framework Name**: Three.js
- **Version**: r160+ (Latest stable with modern WebGL features)
- **Type**: 3D graphics library for web browsers
- **Language**: JavaScript/TypeScript (TypeScript recommended)
- **Use Cases**: 3D visualizations, WebGL applications, VR/AR experiences, interactive graphics

## Installation & Setup
See [example-1](./examples/three-js/example-1.bash)

## Project Structure
See [example-2](./examples/three-js/example-2.txt)

## Core Concepts

### Scene, Camera, and Renderer Setup
See [example-3](./examples/three-js/example-3.typescript)

### 3D Model Loading and Animation
See [example-4](./examples/three-js/example-4.typescript)

### Camera Controls and Movement
See [example-5](./examples/three-js/example-5.typescript)

## Common Patterns

### Material and Shader Management
See [example-6](./examples/three-js/example-6.typescript)

### Physics Integration
See [example-7](./examples/three-js/example-7.typescript)

## Advanced Usage

### VR/AR Integration with WebXR
See [example-8](./examples/three-js/example-8.typescript)

### Procedural Generation
See [example-9](./examples/three-js/example-9.typescript)

## Integration Examples

### React Integration
See [example-10](./examples/three-js/example-10.typescript)

### Node.js Backend Integration
See [example-11](./examples/three-js/example-11.typescript)

### AI Agent Decision Matrix

| Scenario | Recommended Approach | Three.js Solution |
|----------|---------------------|-------------------|
| **3D Data Visualization** | WebGL-based rendering with interactive controls | Three.js with custom geometries and materials |
| **Product Configurators** | Real-time 3D model updates with material changes | GLTF model loading with dynamic material switching |
| **Architectural Visualization** | High-quality rendering with realistic lighting | PBR materials, environment mapping, advanced lighting |
| **VR/AR Web Experiences** | WebXR integration with controller support | Three.js WebXR integration with hand tracking |
| **Educational 3D Content** | Interactive 3D models with animations | Animated GLTF models with UI controls |
| **Game Development** | Physics simulation with 3D graphics | Three.js + Cannon.js physics engine |
| **Scientific Visualization** | Large dataset rendering with performance optimization | Instanced rendering, LOD systems, custom shaders |
| **3D Web Applications** | Framework integration with component lifecycle | React/Vue components wrapping Three.js scenes |

## Best Practices
1. **Performance Optimization**: Use instanced rendering, LOD systems, and object pooling
2. **Memory Management**: Dispose of geometries, materials, and textures properly
3. **Asset Optimization**: Use compressed textures, optimized models, and progressive loading
4. **Cross-platform Compatibility**: Test on various devices and browsers
5. **Accessibility**: Provide alternative experiences for users with disabilities
6. **Error Handling**: Implement robust error handling for asset loading and WebGL context loss
7. **Code Organization**: Use modular architecture with clear separation of concerns

## Common Issues & Solutions

### Issue 1: Poor Performance on Mobile Devices
**Problem**: 3D scenes run slowly on mobile devices
**Solution**: 
See [example-12](./examples/three-js/example-12.typescript)

### Issue 2: WebGL Context Loss
**Problem**: WebGL context can be lost, causing rendering to stop
**Solution**: 
See [example-13](./examples/three-js/example-13.typescript)

### Issue 3: Memory Leaks with Large Scenes
**Problem**: Memory usage grows over time in dynamic scenes
**Solution**: 
See [example-14](./examples/three-js/example-14.typescript)

## Testing
See [example-15](./examples/three-js/example-15.typescript)

## Deployment
See [example-16](./examples/three-js/example-16.bash)

## Performance Optimization
1. **Level of Detail (LOD)**: Use different model complexities based on distance
2. **Frustum Culling**: Only render objects visible to the camera
3. **Instanced Rendering**: Render many similar objects efficiently
4. **Texture Optimization**: Use compressed textures and mipmaps
5. **Geometry Optimization**: Merge geometries, reduce vertex count
6. **Shader Optimization**: Write efficient custom shaders
7. **Asset Streaming**: Load assets progressively based on need

## Security Considerations
- **Content Security Policy**: Configure CSP for WebGL applications
- **Asset Validation**: Validate 3D models and textures before loading
- **Memory Limits**: Implement memory usage monitoring
- **Origin Restrictions**: Restrict loading of external assets
- **User Input Sanitization**: Sanitize user inputs in 3D applications
- **Performance Limits**: Prevent resource exhaustion attacks

## Resources & Documentation
- [Three.js Official Documentation](https://threejs.org/docs/)
- [Three.js Examples](https://threejs.org/examples/)
- [Three.js Editor](https://threejs.org/editor/)
- [WebGL Fundamentals](https://webglfundamentals.org/)
- [Three.js Journey Course](https://threejs-journey.com/)
- [Three.js GitHub Repository](https://github.com/mrdoob/three.js/)
- [WebXR Device API](https://developer.mozilla.org/en-US/docs/Web/API/WebXR_Device_API)

---

*Optimized for Three.js r160+ with TypeScript, focusing on modern 3D web development, WebGL optimization, and cross-platform compatibility.*

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
