---
applyTo: 'three.js, threejs, three, webgl, 3d'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on Three.js 3D graphics and WebGL development with modern JavaScript/TypeScript'
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
```bash
# Via npm (recommended for modern projects)
npm install three
npm install -D @types/three

# Via CDN (quick prototyping)
# <script src="https://cdn.jsdelivr.net/npm/three@0.160.0/build/three.min.js"></script>

# Create project with Vite (modern build tool)
npm create vite@latest my-threejs-app -- --template vanilla-ts
cd my-threejs-app
npm install
npm install three
npm install -D @types/three

# Additional useful packages
npm install @tweenjs/tween.js  # Animations
npm install cannon-es         # Physics engine
npm install lil-gui           # Debug GUI
npm install stats.js          # Performance monitoring
```

## Project Structure
```
threejs-app/
├── public/                    # Static assets
│   ├── models/               # 3D models (.gltf, .fbx, .obj)
│   ├── textures/             # Texture images
│   ├── environments/         # Environment maps
│   └── sounds/               # Audio files
├── src/                      # Source code
│   ├── scenes/               # Scene configurations
│   │   ├── MainScene.ts      # Main 3D scene
│   │   ├── UIScene.ts        # UI overlay
│   │   └── LoadingScene.ts   # Loading screen
│   ├── objects/              # 3D objects and components
│   │   ├── Player.ts         # Player character
│   │   ├── Environment.ts    # Environment objects
│   │   └── Interactables.ts  # Interactive elements
│   ├── systems/              # Game systems
│   │   ├── InputManager.ts   # Input handling
│   │   ├── CameraController.ts # Camera controls
│   │   ├── LightingManager.ts # Lighting setup
│   │   └── AudioManager.ts   # 3D audio
│   ├── utils/                # Utility functions
│   │   ├── Loaders.ts        # Asset loading
│   │   ├── Math.ts           # Math utilities
│   │   └── Performance.ts    # Performance monitoring
│   ├── shaders/              # Custom shaders
│   │   ├── vertex/           # Vertex shaders
│   │   └── fragment/         # Fragment shaders
│   └── main.ts               # Entry point
├── package.json
├── vite.config.js            # Build configuration
└── tsconfig.json             # TypeScript configuration
```

## Core Concepts

### Scene, Camera, and Renderer Setup
```typescript
// main.ts - Basic Three.js setup
import * as THREE from 'three';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls';
import Stats from 'stats.js';

export class ThreeJSApp {
    private scene!: THREE.Scene;
    private camera!: THREE.PerspectiveCamera;
    private renderer!: THREE.WebGLRenderer;
    private controls!: OrbitControls;
    private stats!: Stats;
    private animationId!: number;

    constructor(container: HTMLElement) {
        this.init(container);
        this.setupScene();
        this.setupLights();
        this.setupControls();
        this.setupStats();
        this.animate();
        this.setupEventListeners();
    }

    private init(container: HTMLElement): void {
        // Scene
        this.scene = new THREE.Scene();
        this.scene.background = new THREE.Color(0x111111);

        // Camera
        this.camera = new THREE.PerspectiveCamera(
            75, // Field of view
            window.innerWidth / window.innerHeight, // Aspect ratio
            0.1, // Near clipping plane
            1000 // Far clipping plane
        );
        this.camera.position.set(0, 5, 10);

        // Renderer
        this.renderer = new THREE.WebGLRenderer({ 
            antialias: true,
            powerPreference: 'high-performance'
        });
        this.renderer.setSize(window.innerWidth, window.innerHeight);
        this.renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
        this.renderer.shadowMap.enabled = true;
        this.renderer.shadowMap.type = THREE.PCFSoftShadowMap;
        this.renderer.toneMapping = THREE.ACESFilmicToneMapping;
        this.renderer.toneMappingExposure = 1;

        container.appendChild(this.renderer.domElement);
    }

    private setupScene(): void {
        // Add basic objects to demonstrate
        const geometry = new THREE.BoxGeometry(1, 1, 1);
        const material = new THREE.MeshStandardMaterial({ 
            color: 0x00ff00,
            roughness: 0.4,
            metalness: 0.6
        });
        const cube = new THREE.Mesh(geometry, material);
        cube.castShadow = true;
        cube.receiveShadow = true;
        this.scene.add(cube);

        // Ground plane
        const planeGeometry = new THREE.PlaneGeometry(20, 20);
        const planeMaterial = new THREE.MeshStandardMaterial({ 
            color: 0x808080,
            roughness: 0.8,
            metalness: 0.2
        });
        const plane = new THREE.Mesh(planeGeometry, planeMaterial);
        plane.rotation.x = -Math.PI / 2;
        plane.position.y = -1;
        plane.receiveShadow = true;
        this.scene.add(plane);
    }

    private setupLights(): void {
        // Ambient light
        const ambientLight = new THREE.AmbientLight(0x404040, 0.3);
        this.scene.add(ambientLight);

        // Directional light (sun)
        const directionalLight = new THREE.DirectionalLight(0xffffff, 1);
        directionalLight.position.set(5, 10, 5);
        directionalLight.castShadow = true;
        directionalLight.shadow.mapSize.width = 2048;
        directionalLight.shadow.mapSize.height = 2048;
        directionalLight.shadow.camera.near = 0.5;
        directionalLight.shadow.camera.far = 50;
        directionalLight.shadow.camera.left = -10;
        directionalLight.shadow.camera.right = 10;
        directionalLight.shadow.camera.top = 10;
        directionalLight.shadow.camera.bottom = -10;
        this.scene.add(directionalLight);

        // Point light
        const pointLight = new THREE.PointLight(0xff0000, 1, 100);
        pointLight.position.set(0, 5, 0);
        pointLight.castShadow = true;
        this.scene.add(pointLight);
    }

    private setupControls(): void {
        this.controls = new OrbitControls(this.camera, this.renderer.domElement);
        this.controls.enableDamping = true;
        this.controls.dampingFactor = 0.05;
        this.controls.maxPolarAngle = Math.PI / 2;
    }

    private setupStats(): void {
        this.stats = new Stats();
        this.stats.showPanel(0); // 0: fps, 1: ms, 2: mb
        document.body.appendChild(this.stats.dom);
    }

    private animate(): void {
        this.animationId = requestAnimationFrame(() => this.animate());
        
        this.stats.begin();
        
        // Update controls
        this.controls.update();
        
        // Render scene
        this.renderer.render(this.scene, this.camera);
        
        this.stats.end();
    }

    private setupEventListeners(): void {
        window.addEventListener('resize', this.onWindowResize.bind(this));
    }

    private onWindowResize(): void {
        this.camera.aspect = window.innerWidth / window.innerHeight;
        this.camera.updateProjectionMatrix();
        this.renderer.setSize(window.innerWidth, window.innerHeight);
    }

    public dispose(): void {
        cancelAnimationFrame(this.animationId);
        this.controls.dispose();
        this.renderer.dispose();
        document.body.removeChild(this.stats.dom);
        window.removeEventListener('resize', this.onWindowResize);
    }
}

// Initialize application
const container = document.getElementById('app')!;
const app = new ThreeJSApp(container);
```

### 3D Model Loading and Animation
```typescript
// utils/Loaders.ts - Asset loading utilities
import * as THREE from 'three';
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader';
import { FBXLoader } from 'three/examples/jsm/loaders/FBXLoader';
import { TextureLoader } from 'three';

export class AssetLoader {
    private loadingManager: THREE.LoadingManager;
    private gltfLoader: GLTFLoader;
    private fbxLoader: FBXLoader;
    private textureLoader: TextureLoader;

    constructor() {
        this.loadingManager = new THREE.LoadingManager();
        this.gltfLoader = new GLTFLoader(this.loadingManager);
        this.fbxLoader = new FBXLoader(this.loadingManager);
        this.textureLoader = new TextureLoader(this.loadingManager);

        this.setupLoadingManager();
    }

    private setupLoadingManager(): void {
        this.loadingManager.onLoad = () => {
            console.log('All assets loaded');
            document.dispatchEvent(new CustomEvent('assetsLoaded'));
        };

        this.loadingManager.onProgress = (url, loaded, total) => {
            const progress = (loaded / total) * 100;
            console.log(`Loading progress: ${progress.toFixed(2)}%`);
            document.dispatchEvent(new CustomEvent('loadingProgress', { 
                detail: { progress, url } 
            }));
        };

        this.loadingManager.onError = (url) => {
            console.error('Error loading:', url);
        };
    }

    public async loadGLTF(path: string): Promise<THREE.Group> {
        return new Promise((resolve, reject) => {
            this.gltfLoader.load(
                path,
                (gltf) => {
                    const model = gltf.scene;
                    
                    // Setup shadows
                    model.traverse((child) => {
                        if (child instanceof THREE.Mesh) {
                            child.castShadow = true;
                            child.receiveShadow = true;
                        }
                    });

                    resolve(model);
                },
                (progress) => {
                    console.log('GLTF loading progress:', progress);
                },
                (error) => {
                    console.error('Error loading GLTF:', error);
                    reject(error);
                }
            );
        });
    }

    public async loadTexture(path: string): Promise<THREE.Texture> {
        return new Promise((resolve, reject) => {
            this.textureLoader.load(
                path,
                (texture) => {
                    texture.wrapS = THREE.RepeatWrapping;
                    texture.wrapT = THREE.RepeatWrapping;
                    resolve(texture);
                },
                undefined,
                (error) => {
                    console.error('Error loading texture:', error);
                    reject(error);
                }
            );
        });
    }

    public async loadEnvironmentMap(path: string): Promise<THREE.Texture> {
        return new Promise((resolve, reject) => {
            const loader = new THREE.CubeTextureLoader(this.loadingManager);
            loader.load(
                [
                    `${path}/px.jpg`, `${path}/nx.jpg`,
                    `${path}/py.jpg`, `${path}/ny.jpg`,
                    `${path}/pz.jpg`, `${path}/nz.jpg`
                ],
                (texture) => {
                    resolve(texture);
                },
                undefined,
                (error) => {
                    console.error('Error loading environment map:', error);
                    reject(error);
                }
            );
        });
    }
}

// objects/AnimatedModel.ts - Animated 3D model
export class AnimatedModel {
    public group: THREE.Group;
    private mixer: THREE.AnimationMixer;
    private actions: Map<string, THREE.AnimationAction> = new Map();
    private currentAction: THREE.AnimationAction | null = null;

    constructor(gltf: any) {
        this.group = gltf.scene;
        this.mixer = new THREE.AnimationMixer(this.group);

        // Setup animations
        gltf.animations.forEach((clip: THREE.AnimationClip) => {
            const action = this.mixer.clipAction(clip);
            this.actions.set(clip.name, action);
        });
    }

    public playAnimation(name: string, loop: boolean = true): void {
        const action = this.actions.get(name);
        if (!action) {
            console.warn(`Animation "${name}" not found`);
            return;
        }

        // Fade out current animation
        if (this.currentAction && this.currentAction !== action) {
            this.currentAction.fadeOut(0.5);
        }

        // Play new animation
        action.reset();
        action.setLoop(loop ? THREE.LoopRepeat : THREE.LoopOnce, Infinity);
        action.fadeIn(0.5);
        action.play();

        this.currentAction = action;
    }

    public update(deltaTime: number): void {
        if (this.mixer) {
            this.mixer.update(deltaTime);
        }
    }

    public getAnimationNames(): string[] {
        return Array.from(this.actions.keys());
    }
}
```

### Camera Controls and Movement
```typescript
// systems/CameraController.ts - Advanced camera controls
import * as THREE from 'three';

export class CameraController {
    private camera: THREE.PerspectiveCamera;
    private target: THREE.Vector3 = new THREE.Vector3();
    private offset: THREE.Vector3 = new THREE.Vector3();
    private followTarget: THREE.Object3D | null = null;
    
    // Mouse controls
    private isMouseDown: boolean = false;
    private mouseX: number = 0;
    private mouseY: number = 0;
    private rotationSpeed: number = 0.002;
    
    // Movement
    private moveSpeed: number = 5;
    private keys: Record<string, boolean> = {};

    constructor(camera: THREE.PerspectiveCamera, domElement: HTMLElement) {
        this.camera = camera;
        this.setupEventListeners(domElement);
    }

    private setupEventListeners(domElement: HTMLElement): void {
        // Mouse controls
        domElement.addEventListener('mousedown', this.onMouseDown.bind(this));
        domElement.addEventListener('mousemove', this.onMouseMove.bind(this));
        domElement.addEventListener('mouseup', this.onMouseUp.bind(this));
        domElement.addEventListener('wheel', this.onWheel.bind(this));

        // Keyboard controls
        window.addEventListener('keydown', this.onKeyDown.bind(this));
        window.addEventListener('keyup', this.onKeyUp.bind(this));

        // Prevent context menu
        domElement.addEventListener('contextmenu', (e) => e.preventDefault());
    }

    private onMouseDown(event: MouseEvent): void {
        this.isMouseDown = true;
        this.mouseX = event.clientX;
        this.mouseY = event.clientY;
    }

    private onMouseMove(event: MouseEvent): void {
        if (!this.isMouseDown) return;

        const deltaX = event.clientX - this.mouseX;
        const deltaY = event.clientY - this.mouseY;

        // Rotate camera around target
        const spherical = new THREE.Spherical();
        spherical.setFromVector3(this.camera.position.clone().sub(this.target));
        
        spherical.theta -= deltaX * this.rotationSpeed;
        spherical.phi += deltaY * this.rotationSpeed;
        
        // Limit vertical rotation
        spherical.phi = Math.max(0.1, Math.min(Math.PI - 0.1, spherical.phi));

        this.camera.position.setFromSpherical(spherical).add(this.target);
        this.camera.lookAt(this.target);

        this.mouseX = event.clientX;
        this.mouseY = event.clientY;
    }

    private onMouseUp(): void {
        this.isMouseDown = false;
    }

    private onWheel(event: WheelEvent): void {
        const distance = this.camera.position.distanceTo(this.target);
        const newDistance = Math.max(1, Math.min(50, distance + event.deltaY * 0.01));
        
        const direction = this.camera.position.clone().sub(this.target).normalize();
        this.camera.position.copy(this.target).add(direction.multiplyScalar(newDistance));
    }

    private onKeyDown(event: KeyboardEvent): void {
        this.keys[event.code] = true;
    }

    private onKeyUp(event: KeyboardEvent): void {
        this.keys[event.code] = false;
    }

    public update(deltaTime: number): void {
        this.handleKeyboardMovement(deltaTime);
        this.updateFollowTarget();
    }

    private handleKeyboardMovement(deltaTime: number): void {
        const moveDistance = this.moveSpeed * deltaTime;
        const direction = new THREE.Vector3();

        if (this.keys['KeyW']) direction.z -= 1;
        if (this.keys['KeyS']) direction.z += 1;
        if (this.keys['KeyA']) direction.x -= 1;
        if (this.keys['KeyD']) direction.x += 1;
        if (this.keys['KeyQ']) direction.y -= 1;
        if (this.keys['KeyE']) direction.y += 1;

        if (direction.length() > 0) {
            direction.normalize();
            
            // Apply camera rotation to movement direction
            direction.applyQuaternion(this.camera.quaternion);
            direction.multiplyScalar(moveDistance);
            
            this.camera.position.add(direction);
            this.target.add(direction);
        }
    }

    private updateFollowTarget(): void {
        if (this.followTarget) {
            const targetPosition = this.followTarget.position.clone().add(this.offset);
            this.target.lerp(targetPosition, 0.1);
            this.camera.lookAt(this.target);
        }
    }

    public setTarget(target: THREE.Vector3): void {
        this.target.copy(target);
        this.camera.lookAt(this.target);
    }

    public followObject(object: THREE.Object3D, offset: THREE.Vector3 = new THREE.Vector3(0, 5, 10)): void {
        this.followTarget = object;
        this.offset.copy(offset);
    }

    public stopFollowing(): void {
        this.followTarget = null;
    }
}
```

## Common Patterns

### Material and Shader Management
```typescript
// utils/MaterialManager.ts - Material creation and management
import * as THREE from 'three';

export class MaterialManager {
    private materials: Map<string, THREE.Material> = new Map();
    private textures: Map<string, THREE.Texture> = new Map();

    public createPBRMaterial(options: {
        name: string;
        color?: number;
        metalness?: number;
        roughness?: number;
        normalMap?: string;
        roughnessMap?: string;
        metalnessMap?: string;
        emissiveMap?: string;
    }): THREE.MeshStandardMaterial {
        const material = new THREE.MeshStandardMaterial({
            color: options.color || 0xffffff,
            metalness: options.metalness || 0,
            roughness: options.roughness || 1
        });

        // Load and assign texture maps
        if (options.normalMap) {
            material.normalMap = this.getTexture(options.normalMap);
        }
        if (options.roughnessMap) {
            material.roughnessMap = this.getTexture(options.roughnessMap);
        }
        if (options.metalnessMap) {
            material.metalnessMap = this.getTexture(options.metalnessMap);
        }
        if (options.emissiveMap) {
            material.emissiveMap = this.getTexture(options.emissiveMap);
        }

        this.materials.set(options.name, material);
        return material;
    }

    public createCustomShaderMaterial(options: {
        name: string;
        vertexShader: string;
        fragmentShader: string;
        uniforms?: Record<string, THREE.IUniform>;
    }): THREE.ShaderMaterial {
        const material = new THREE.ShaderMaterial({
            vertexShader: options.vertexShader,
            fragmentShader: options.fragmentShader,
            uniforms: options.uniforms || {}
        });

        this.materials.set(options.name, material);
        return material;
    }

    private getTexture(path: string): THREE.Texture {
        if (this.textures.has(path)) {
            return this.textures.get(path)!;
        }

        const loader = new THREE.TextureLoader();
        const texture = loader.load(path);
        this.textures.set(path, texture);
        return texture;
    }

    public getMaterial(name: string): THREE.Material | undefined {
        return this.materials.get(name);
    }

    public dispose(): void {
        this.materials.forEach(material => material.dispose());
        this.textures.forEach(texture => texture.dispose());
        this.materials.clear();
        this.textures.clear();
    }
}

// Example custom shaders
export const WaveShader = {
    vertexShader: `
        uniform float uTime;
        uniform float uAmplitude;
        uniform float uFrequency;
        
        varying vec2 vUv;
        varying float vWave;
        
        void main() {
            vUv = uv;
            
            vec3 pos = position;
            float wave = sin(pos.x * uFrequency + uTime) * uAmplitude;
            pos.y += wave;
            vWave = wave;
            
            gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
        }
    `,
    fragmentShader: `
        uniform vec3 uColor1;
        uniform vec3 uColor2;
        
        varying vec2 vUv;
        varying float vWave;
        
        void main() {
            float mixStrength = (vWave + 1.0) * 0.5;
            vec3 color = mix(uColor1, uColor2, mixStrength);
            
            gl_FragColor = vec4(color, 1.0);
        }
    `
};
```

### Physics Integration
```typescript
// systems/PhysicsWorld.ts - Physics integration with Cannon.js
import * as THREE from 'three';
import * as CANNON from 'cannon-es';

export class PhysicsWorld {
    public world: CANNON.World;
    private bodies: Map<THREE.Object3D, CANNON.Body> = new Map();

    constructor() {
        this.world = new CANNON.World();
        this.world.gravity.set(0, -9.82, 0);
        this.world.broadphase = new CANNON.NaiveBroadphase();
        this.world.solver.iterations = 10;

        // Ground
        const groundShape = new CANNON.Plane();
        const groundBody = new CANNON.Body({ mass: 0 });
        groundBody.addShape(groundShape);
        groundBody.quaternion.setFromAxisAngle(new CANNON.Vec3(1, 0, 0), -Math.PI / 2);
        this.world.addBody(groundBody);
    }

    public addBox(mesh: THREE.Mesh, mass: number = 1): CANNON.Body {
        const box = mesh.geometry.boundingBox;
        if (!box) {
            mesh.geometry.computeBoundingBox();
        }
        
        const size = new THREE.Vector3();
        mesh.geometry.boundingBox!.getSize(size);
        
        const shape = new CANNON.Box(new CANNON.Vec3(size.x / 2, size.y / 2, size.z / 2));
        const body = new CANNON.Body({ mass });
        body.addShape(shape);
        body.position.copy(mesh.position as any);
        body.quaternion.copy(mesh.quaternion as any);
        
        this.world.addBody(body);
        this.bodies.set(mesh, body);
        
        return body;
    }

    public addSphere(mesh: THREE.Mesh, mass: number = 1): CANNON.Body {
        const sphere = mesh.geometry.boundingSphere;
        if (!sphere) {
            mesh.geometry.computeBoundingSphere();
        }
        
        const radius = mesh.geometry.boundingSphere!.radius;
        const shape = new CANNON.Sphere(radius);
        const body = new CANNON.Body({ mass });
        body.addShape(shape);
        body.position.copy(mesh.position as any);
        
        this.world.addBody(body);
        this.bodies.set(mesh, body);
        
        return body;
    }

    public update(deltaTime: number): void {
        this.world.step(deltaTime);
        
        // Update mesh positions from physics bodies
        this.bodies.forEach((body, mesh) => {
            mesh.position.copy(body.position as any);
            mesh.quaternion.copy(body.quaternion as any);
        });
    }

    public removeBody(mesh: THREE.Object3D): void {
        const body = this.bodies.get(mesh);
        if (body) {
            this.world.removeBody(body);
            this.bodies.delete(mesh);
        }
    }

    public dispose(): void {
        this.bodies.clear();
        // Clean up Cannon.js world
        this.world.bodies.forEach(body => {
            this.world.removeBody(body);
        });
    }
}
```

## Advanced Usage

### VR/AR Integration with WebXR
```typescript
// systems/XRManager.ts - VR/AR support
import * as THREE from 'three';
import { VRButton } from 'three/examples/jsm/webxr/VRButton';
import { ARButton } from 'three/examples/jsm/webxr/ARButton';

export class XRManager {
    private renderer: THREE.WebGLRenderer;
    private scene: THREE.Scene;
    private camera: THREE.Camera;
    private controllers: THREE.Group[] = [];

    constructor(renderer: THREE.WebGLRenderer, scene: THREE.Scene, camera: THREE.Camera) {
        this.renderer = renderer;
        this.scene = scene;
        this.camera = camera;
    }

    public enableVR(container: HTMLElement): void {
        this.renderer.xr.enabled = true;
        
        const button = VRButton.createButton(this.renderer);
        container.appendChild(button);
        
        this.setupVRControllers();
    }

    public enableAR(container: HTMLElement): void {
        this.renderer.xr.enabled = true;
        
        const button = ARButton.createButton(this.renderer, {
            requiredFeatures: ['hit-test']
        });
        container.appendChild(button);
        
        this.setupARHitTest();
    }

    private setupVRControllers(): void {
        // Controller 0
        const controller1 = this.renderer.xr.getController(0);
        controller1.addEventListener('connected', (event) => {
            this.buildController(controller1, event.data);
        });
        controller1.addEventListener('disconnected', () => {
            controller1.remove(controller1.children[0]);
        });
        this.scene.add(controller1);
        this.controllers.push(controller1);

        // Controller 1
        const controller2 = this.renderer.xr.getController(1);
        controller2.addEventListener('connected', (event) => {
            this.buildController(controller2, event.data);
        });
        controller2.addEventListener('disconnected', () => {
            controller2.remove(controller2.children[0]);
        });
        this.scene.add(controller2);
        this.controllers.push(controller2);

        // Controller grips
        const controllerGrip1 = this.renderer.xr.getControllerGrip(0);
        this.scene.add(controllerGrip1);

        const controllerGrip2 = this.renderer.xr.getControllerGrip(1);
        this.scene.add(controllerGrip2);
    }

    private buildController(controller: THREE.Group, data: any): void {
        const geometry = new THREE.BufferGeometry().setFromPoints([
            new THREE.Vector3(0, 0, 0),
            new THREE.Vector3(0, 0, -1)
        ]);

        const line = new THREE.Line(geometry);
        line.name = 'line';
        line.scale.z = 5;

        controller.add(line.clone());
    }

    private setupARHitTest(): void {
        // AR hit testing implementation
        let hitTestSource: XRHitTestSource | null = null;
        let hitTestSourceRequested = false;

        const onSessionStart = async () => {
            const session = this.renderer.xr.getSession();
            if (session && !hitTestSourceRequested) {
                const referenceSpace = await session.requestReferenceSpace('viewer');
                hitTestSource = await session.requestHitTestSource!({ space: referenceSpace });
                hitTestSourceRequested = true;
            }
        };

        this.renderer.xr.addEventListener('sessionstart', onSessionStart);
    }

    public getControllers(): THREE.Group[] {
        return this.controllers;
    }

    public isPresenting(): boolean {
        return this.renderer.xr.isPresenting;
    }
}
```

### Procedural Generation
```typescript
// utils/ProceduralGeneration.ts - Procedural content generation
import * as THREE from 'three';

export class TerrainGenerator {
    public generateTerrain(width: number, height: number, segments: number = 64): THREE.Mesh {
        const geometry = new THREE.PlaneGeometry(width, height, segments, segments);
        
        // Generate height map using noise
        const vertices = geometry.attributes.position.array as Float32Array;
        
        for (let i = 0; i < vertices.length; i += 3) {
            const x = vertices[i];
            const z = vertices[i + 2];
            
            // Multi-octave noise for realistic terrain
            vertices[i + 1] = this.generateHeight(x, z);
        }
        
        geometry.attributes.position.needsUpdate = true;
        geometry.computeVertexNormals();
        
        const material = new THREE.MeshStandardMaterial({
            color: 0x3e7b3e,
            roughness: 0.8,
            metalness: 0.1
        });
        
        return new THREE.Mesh(geometry, material);
    }

    private generateHeight(x: number, z: number): number {
        // Simple noise function (replace with proper noise library for production)
        const scale = 0.01;
        const amplitude = 10;
        
        return Math.sin(x * scale) * Math.cos(z * scale) * amplitude +
               Math.sin(x * scale * 2) * Math.cos(z * scale * 2) * amplitude * 0.5 +
               Math.sin(x * scale * 4) * Math.cos(z * scale * 4) * amplitude * 0.25;
    }
}

export class CityGenerator {
    public generateCity(size: number): THREE.Group {
        const city = new THREE.Group();
        const buildingCount = 50;
        
        for (let i = 0; i < buildingCount; i++) {
            const building = this.createBuilding();
            
            // Random position within city bounds
            building.position.x = (Math.random() - 0.5) * size;
            building.position.z = (Math.random() - 0.5) * size;
            
            city.add(building);
        }
        
        return city;
    }

    private createBuilding(): THREE.Mesh {
        const width = Math.random() * 4 + 2;
        const height = Math.random() * 20 + 5;
        const depth = Math.random() * 4 + 2;
        
        const geometry = new THREE.BoxGeometry(width, height, depth);
        const material = new THREE.MeshStandardMaterial({
            color: new THREE.Color().setHSL(Math.random(), 0.5, 0.6),
            roughness: 0.7,
            metalness: 0.3
        });
        
        const building = new THREE.Mesh(geometry, material);
        building.position.y = height / 2;
        building.castShadow = true;
        building.receiveShadow = true;
        
        return building;
    }
}
```

## Integration Examples

### React Integration
```typescript
// components/ThreeScene.tsx - React component wrapper
import React, { useEffect, useRef, useState } from 'react';
import { ThreeJSApp } from '../three/ThreeJSApp';

interface ThreeSceneProps {
    onLoadingProgress?: (progress: number) => void;
    onSceneReady?: () => void;
}

export const ThreeScene: React.FC<ThreeSceneProps> = ({
    onLoadingProgress,
    onSceneReady
}) => {
    const containerRef = useRef<HTMLDivElement>(null);
    const appRef = useRef<ThreeJSApp | null>(null);
    const [isLoading, setIsLoading] = useState(true);

    useEffect(() => {
        if (containerRef.current && !appRef.current) {
            appRef.current = new ThreeJSApp(containerRef.current);
            
            // Listen for loading events
            const handleLoadingProgress = (event: CustomEvent) => {
                onLoadingProgress?.(event.detail.progress);
            };
            
            const handleAssetsLoaded = () => {
                setIsLoading(false);
                onSceneReady?.();
            };
            
            document.addEventListener('loadingProgress', handleLoadingProgress as EventListener);
            document.addEventListener('assetsLoaded', handleAssetsLoaded);
            
            return () => {
                document.removeEventListener('loadingProgress', handleLoadingProgress as EventListener);
                document.removeEventListener('assetsLoaded', handleAssetsLoaded);
                
                if (appRef.current) {
                    appRef.current.dispose();
                    appRef.current = null;
                }
            };
        }
    }, [onLoadingProgress, onSceneReady]);

    return (
        <div className="three-scene-container">
            <div 
                ref={containerRef} 
                style={{ 
                    width: '100vw', 
                    height: '100vh',
                    position: 'relative'
                }} 
            />
            {isLoading && (
                <div className="loading-overlay">
                    <div className="loading-spinner">Loading 3D Scene...</div>
                </div>
            )}
        </div>
    );
};

// App.tsx - Main React application
import React, { useState } from 'react';
import { ThreeScene } from './components/ThreeScene';

export const App: React.FC = () => {
    const [loadingProgress, setLoadingProgress] = useState(0);
    const [sceneReady, setSceneReady] = useState(false);

    return (
        <div className="app">
            <ThreeScene 
                onLoadingProgress={setLoadingProgress}
                onSceneReady={() => setSceneReady(true)}
            />
            
            {!sceneReady && (
                <div className="ui-overlay">
                    <div className="progress-bar">
                        <div 
                            className="progress-fill"
                            style={{ width: `${loadingProgress}%` }}
                        />
                    </div>
                    <p>Loading: {Math.round(loadingProgress)}%</p>
                </div>
            )}
            
            {sceneReady && (
                <div className="ui-controls">
                    <button onClick={() => console.log('Reset scene')}>
                        Reset
                    </button>
                    <button onClick={() => console.log('Screenshot')}>
                        Screenshot
                    </button>
                </div>
            )}
        </div>
    );
};
```

### Node.js Backend Integration
```typescript
// server/3d-api.ts - Server-side 3D operations
import express from 'express';
import * as THREE from 'three';
import { GLTFExporter } from 'three/examples/jsm/exporters/GLTFExporter';

const router = express.Router();

// Generate and export 3D models
router.post('/generate-model', async (req, res) => {
    try {
        const { type, parameters } = req.body;
        
        let geometry: THREE.BufferGeometry;
        
        switch (type) {
            case 'box':
                geometry = new THREE.BoxGeometry(
                    parameters.width || 1,
                    parameters.height || 1,
                    parameters.depth || 1
                );
                break;
            case 'sphere':
                geometry = new THREE.SphereGeometry(
                    parameters.radius || 1,
                    parameters.widthSegments || 32,
                    parameters.heightSegments || 32
                );
                break;
            default:
                return res.status(400).json({ error: 'Invalid geometry type' });
        }
        
        const material = new THREE.MeshStandardMaterial({
            color: parameters.color || 0xffffff
        });
        
        const mesh = new THREE.Mesh(geometry, material);
        const scene = new THREE.Scene();
        scene.add(mesh);
        
        // Export as GLTF
        const exporter = new GLTFExporter();
        const gltf = await new Promise((resolve, reject) => {
            exporter.parse(scene, resolve, { binary: false }, reject);
        });
        
        res.json({ model: gltf });
    } catch (error) {
        console.error('Error generating model:', error);
        res.status(500).json({ error: 'Failed to generate model' });
    }
});

// Optimize models
router.post('/optimize-model', async (req, res) => {
    try {
        const { modelData, optimizations } = req.body;
        
        // Load model from data
        const loader = new THREE.ObjectLoader();
        const scene = loader.parse(modelData);
        
        // Apply optimizations
        if (optimizations.reducePoly) {
            scene.traverse((child) => {
                if (child instanceof THREE.Mesh) {
                    // Implement polygon reduction
                    // This would require additional libraries like three-mesh-simplifier
                }
            });
        }
        
        if (optimizations.mergeGeometries) {
            // Merge geometries for better performance
            // Implementation would depend on specific requirements
        }
        
        res.json({ optimizedModel: scene.toJSON() });
    } catch (error) {
        console.error('Error optimizing model:', error);
        res.status(500).json({ error: 'Failed to optimize model' });
    }
});

export default router;
```

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
```typescript
// Mobile optimization configuration
const isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);

if (isMobile) {
    // Reduce quality settings
    renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
    renderer.shadowMap.enabled = false;
    
    // Use simpler materials
    scene.traverse((child) => {
        if (child instanceof THREE.Mesh) {
            if (child.material instanceof THREE.MeshStandardMaterial) {
                child.material = new THREE.MeshLambertMaterial({
                    color: child.material.color
                });
            }
        }
    });
    
    // Reduce geometry complexity
    // Use LOD (Level of Detail) systems
}
```

### Issue 2: WebGL Context Loss
**Problem**: WebGL context can be lost, causing rendering to stop
**Solution**: 
```typescript
// Handle WebGL context loss
renderer.domElement.addEventListener('webglcontextlost', (event) => {
    event.preventDefault();
    console.log('WebGL context lost');
    
    // Stop animation loop
    cancelAnimationFrame(animationId);
    
    // Show user message
    showContextLostMessage();
});

renderer.domElement.addEventListener('webglcontextrestored', () => {
    console.log('WebGL context restored');
    
    // Reinitialize scene
    initializeScene();
    
    // Restart animation loop
    animate();
    
    // Hide message
    hideContextLostMessage();
});
```

### Issue 3: Memory Leaks with Large Scenes
**Problem**: Memory usage grows over time in dynamic scenes
**Solution**: 
```typescript
// Proper cleanup and memory management
class SceneManager {
    private objectsToCleanup: THREE.Object3D[] = [];
    
    public addObject(object: THREE.Object3D): void {
        scene.add(object);
        this.objectsToCleanup.push(object);
    }
    
    public removeObject(object: THREE.Object3D): void {
        scene.remove(object);
        
        // Dispose of geometries and materials
        object.traverse((child) => {
            if (child instanceof THREE.Mesh) {
                child.geometry.dispose();
                
                if (Array.isArray(child.material)) {
                    child.material.forEach(material => material.dispose());
                } else {
                    child.material.dispose();
                }
            }
        });
        
        // Remove from cleanup list
        const index = this.objectsToCleanup.indexOf(object);
        if (index > -1) {
            this.objectsToCleanup.splice(index, 1);
        }
    }
    
    public dispose(): void {
        this.objectsToCleanup.forEach(object => this.removeObject(object));
        this.objectsToCleanup.length = 0;
    }
}
```

## Testing
```typescript
// tests/ThreeJSApp.test.ts - Unit testing Three.js components
import * as THREE from 'three';
import { ThreeJSApp } from '../src/ThreeJSApp';

// Mock Three.js for testing
jest.mock('three', () => ({
    Scene: jest.fn().mockImplementation(() => ({
        add: jest.fn(),
        remove: jest.fn(),
        traverse: jest.fn()
    })),
    PerspectiveCamera: jest.fn().mockImplementation(() => ({
        position: { set: jest.fn() },
        updateProjectionMatrix: jest.fn()
    })),
    WebGLRenderer: jest.fn().mockImplementation(() => ({
        setSize: jest.fn(),
        setPixelRatio: jest.fn(),
        render: jest.fn(),
        domElement: document.createElement('canvas')
    }))
}));

describe('ThreeJSApp', () => {
    let container: HTMLElement;
    let app: ThreeJSApp;

    beforeEach(() => {
        container = document.createElement('div');
        document.body.appendChild(container);
    });

    afterEach(() => {
        if (app) {
            app.dispose();
        }
        document.body.removeChild(container);
    });

    test('should initialize properly', () => {
        app = new ThreeJSApp(container);
        
        expect(THREE.Scene).toHaveBeenCalled();
        expect(THREE.PerspectiveCamera).toHaveBeenCalled();
        expect(THREE.WebGLRenderer).toHaveBeenCalled();
    });

    test('should handle window resize', () => {
        app = new ThreeJSApp(container);
        
        // Simulate window resize
        Object.defineProperty(window, 'innerWidth', { value: 1920 });
        Object.defineProperty(window, 'innerHeight', { value: 1080 });
        
        window.dispatchEvent(new Event('resize'));
        
        // Verify camera and renderer updates
        // Add specific assertions based on your implementation
    });
});

// tests/MaterialManager.test.ts - Testing material management
describe('MaterialManager', () => {
    let materialManager: MaterialManager;

    beforeEach(() => {
        materialManager = new MaterialManager();
    });

    afterEach(() => {
        materialManager.dispose();
    });

    test('should create PBR material', () => {
        const material = materialManager.createPBRMaterial({
            name: 'test-material',
            color: 0xff0000,
            metalness: 0.5,
            roughness: 0.3
        });

        expect(material).toBeInstanceOf(THREE.MeshStandardMaterial);
        expect(material.color.getHex()).toBe(0xff0000);
        expect(material.metalness).toBe(0.5);
        expect(material.roughness).toBe(0.3);
    });

    test('should cache and retrieve materials', () => {
        const material1 = materialManager.createPBRMaterial({
            name: 'cached-material',
            color: 0x00ff00
        });

        const material2 = materialManager.getMaterial('cached-material');
        
        expect(material1).toBe(material2);
    });
});
```

## Deployment
```bash
# Build for production
npm run build

# Deploy to static hosting
npm install -g serve
serve -s dist

# Deploy to Netlify
npm install -g netlify-cli
netlify deploy --prod --dir=dist

# Deploy to Vercel
npm install -g vercel
vercel --prod

# Optimize for production
# Use webpack-bundle-analyzer to analyze bundle size
npm install -D webpack-bundle-analyzer
npx webpack-bundle-analyzer dist/assets/*.js

# Enable compression
# Configure server to serve compressed assets
# Use CDN for Three.js and large assets
```

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
