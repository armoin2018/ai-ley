---
title: 'Unreal Engine Game Development Instructions'
description: 'Comprehensive guide for Unreal Engine game development using Blueprint visual scripting and C++ programming for AAA game creation'
version: '1.0.0'
last_updated: '2025-08-15'

tags:
  [
    'game-engine',
    'unreal-engine',
    'blueprint',
    'cpp',
    'visual-scripting',
    'aaa-games',
    '3d-graphics',
    'cross-platform',
  ]
category: 'Framework'
subcategory: 'Gaming'
applies_to:
  - '**/*.uproject'
  - '**/Source/**/*.h'
  - '**/Source/**/*.cpp'
  - '**/Content/**/*.uasset'
  - '**/Blueprints/**/*.uasset'
  - '**/Config/**/*.ini'
  - '**/Plugins/**/*.uplugin'
---

# Unreal Engine Game Development Instructions

## Framework Overview

- **Framework Name**: Unreal Engine
- **Version**: 5.4+ (Latest LTS recommended)
- **Type**: AAA Game Engine and Development Platform
- **Languages**: Blueprint (Visual Scripting), C++, Python (Editor Scripting)
- **Use Cases**: AAA games, VR/AR applications, architectural visualization, film production, enterprise applications

## When to Use Unreal Engine

### ✅ **Choose Unreal Engine When:**

- Creating high-fidelity 3D games with photorealistic graphics
- Developing AAA or large-scale indie games
- Building VR/AR experiences requiring advanced rendering
- Need advanced physics, particle systems, and visual effects
- Team includes artists who prefer visual scripting (Blueprint)
- Targeting console platforms (PlayStation, Xbox, Nintendo Switch)
- Require built-in multiplayer networking and replication
- Need integrated version control and team collaboration tools

### ❌ **Avoid Unreal Engine When:**

- Creating simple 2D games or mobile-first applications
- Working with limited storage space (engine size 15GB+)
- Team lacks 3D graphics experience
- Targeting web deployment as primary platform
- Need lightweight deployment for educational games
- Budget constraints require free/open-source alternatives

## AI Agent Decision Matrix

| Project Criteria         | Unity      | Unreal Engine | Godot      | Custom Engine |
| ------------------------ | ---------- | ------------- | ---------- | ------------- |
| **AAA Game Development** | ⭐⭐⭐⭐   | ⭐⭐⭐⭐⭐    | ⭐⭐       | ⭐⭐⭐        |
| **Visual Scripting**     | ⭐⭐⭐     | ⭐⭐⭐⭐⭐    | ⭐⭐⭐⭐   | ⭐            |
| **Graphics Quality**     | ⭐⭐⭐⭐   | ⭐⭐⭐⭐⭐    | ⭐⭐⭐     | ⭐⭐⭐⭐      |
| **Learning Curve**       | ⭐⭐⭐⭐   | ⭐⭐          | ⭐⭐⭐⭐⭐ | ⭐            |
| **Mobile Performance**   | ⭐⭐⭐⭐⭐ | ⭐⭐⭐        | ⭐⭐⭐⭐   | ⭐⭐⭐⭐      |
| **Console Development**  | ⭐⭐⭐⭐   | ⭐⭐⭐⭐⭐    | ⭐⭐       | ⭐⭐⭐        |

## Installation & Setup

### Epic Games Launcher Installation

```bash
# Download Epic Games Launcher from official website
# https://www.unrealengine.com/download

# For Linux (via Lutris or Native):
sudo apt update
sudo apt install build-essential
git clone https://github.com/EpicGames/UnrealEngine.git --depth=1

# Generate project files (Linux)
./Setup.sh
./GenerateProjectFiles.sh
make
```

### Project Creation

```bash
# Create new project via Epic Games Launcher or command line
# Recommended project settings:
# - Blueprint or C++ (hybrid approach recommended)
# - 3D template for most games
# - Desktop/Console target platform
# - Maximum quality settings for AAA development
```

### Development Environment Setup

```bash
# Recommended IDEs:
# - Visual Studio 2022 (Windows) - Primary recommendation
# - Rider (Cross-platform) - Excellent C++ support
# - Visual Studio Code (Cross-platform) - Lightweight option

# Essential Visual Studio extensions:
# - UnrealVS extension for UE integration
# - Visual Assist (optional, advanced IntelliSense)
```

## Project Structure

```
ProjectName/
├── Binaries/              # Compiled executables and libraries
├── Build/                 # Build configuration and intermediate files
├── Config/                # Configuration files (.ini)
│   ├── DefaultEngine.ini  # Engine configuration
│   ├── DefaultGame.ini    # Game-specific settings
│   └── DefaultInput.ini   # Input mappings
├── Content/               # Game assets and blueprints
│   ├── Blueprints/        # Blueprint classes
│   ├── Maps/              # Level files (.umap)
│   ├── Materials/         # Material assets
│   ├── Meshes/            # 3D models and static meshes
│   ├── Textures/          # Image assets
│   └── UI/                # User interface assets
├── Intermediate/          # Temporary build files
├── Plugins/               # Third-party and custom plugins
├── Saved/                 # Runtime generated files
└── Source/                # C++ source code
    ├── ProjectName/       # Main game module
    │   ├── Private/       # .cpp implementation files
    │   ├── Public/        # .h header files
    │   └── ProjectName.Build.cs
    └── ProjectNameEditor/ # Editor-only code
```

## Core Concepts

### Actor-Component Architecture

- **Purpose**: Foundation of all game objects in Unreal Engine
- **Usage**: Everything in the game world inherits from AActor
- **Example**: Pawns, Characters, StaticMeshActors, Lights

```cpp
// C++ Actor Example
UCLASS(BlueprintType, Blueprintable)
class MYGAME_API AMyActor : public AActor
{
    GENERATED_BODY()

public:
    AMyActor();

protected:
    virtual void BeginPlay() override;

    UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category = "Components")
    class UStaticMeshComponent* MeshComponent;

    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Settings")
    float Speed = 100.0f;

public:
    virtual void Tick(float DeltaTime) override;
};
```

### Blueprint Visual Scripting

- **Purpose**: Node-based visual programming system
- **Usage**: Rapid prototyping, designer-friendly logic, event handling
- **Example**: Event graphs, construction scripts, animation blueprints

**Blueprint Best Practices:**

- Use Blueprint for game logic, events, and UI
- Use C++ for performance-critical systems and complex algorithms
- Create Blueprint-callable C++ functions for heavy lifting
- Organize Blueprint graphs with comments and reroute nodes

### C++ Integration Patterns

- **Purpose**: Performance-critical code and complex systems
- **Usage**: Core systems, AI, physics, networking
- **Example**: Custom components, game modes, player controllers

```cpp
// Blueprint-callable C++ function
UFUNCTION(BlueprintCallable, Category = "Game Logic")
bool ProcessComplexCalculation(const TArray<float>& InputData, float& OutResult);

// Blueprint implementable event
UFUNCTION(BlueprintImplementableEvent, Category = "Events")
void OnPlayerScoreChanged(int32 NewScore);

// Blueprint native event (can be overridden in Blueprint)
UFUNCTION(BlueprintNativeEvent, Category = "Actions")
void PerformSpecialAttack();
virtual void PerformSpecialAttack_Implementation();
```

### Level Design and World Building

- **Purpose**: Creating game environments and level layouts
- **Usage**: Level streaming, world composition, landscape system
- **Example**: Open world games, seamless level transitions

```cpp
// Level streaming management
UCLASS()
class MYGAME_API AMyLevelManager : public AActor
{
    GENERATED_BODY()

public:
    UFUNCTION(BlueprintCallable, Category = "Level Management")
    void LoadLevel(const FString& LevelName);

    UFUNCTION(BlueprintCallable, Category = "Level Management")
    void UnloadLevel(const FString& LevelName);

private:
    UPROPERTY(EditAnywhere, Category = "Streaming")
    TArray<TSoftObjectPtr<UWorld>> LevelsToStream;
};
```

## Development Workflow

### 1. **Project Setup and Configuration**

```ini
; DefaultEngine.ini configuration examples
[/Script/Engine.Engine]
bUseFixedFrameRate=True
FixedFrameRate=60

[/Script/Engine.RendererSettings]
r.Mobile.EnableStaticAndCSMShadowReceivers=True
r.AllowStaticLighting=True

[/Script/UnrealEd.EditorExperimentalSettings]
bBlueprintPerformanceAnalysisTools=True
```

### 2. **Development and Iteration**

- **Live Coding**: Hot reload C++ changes during development
- **Blueprint Compilation**: Real-time visual script compilation
- **Play in Editor (PIE)**: Test gameplay without full builds
- **Simulate Mode**: Test physics and systems without player control

### 3. **Testing and Debugging**

```cpp
// Debug logging
UE_LOG(LogTemp, Warning, TEXT("Player health: %f"), PlayerHealth);

// Visual debugging
DrawDebugSphere(GetWorld(), GetActorLocation(), 100.0f, 12, FColor::Red, false, 1.0f);

// Blueprint debugging
// Use breakpoints in Blueprint graphs
// Print String nodes for runtime debugging
```

### 4. **Building and Packaging**

```bash
# Command line building
"C:\Program Files\Epic Games\UE_5.4\Engine\Build\BatchFiles\Build.bat" MyGameEditor Win64 Development

# Packaging for distribution
"C:\Program Files\Epic Games\UE_5.4\Engine\Build\BatchFiles\RunUAT.bat" BuildCookRun -project="MyGame.uproject" -platform=Win64 -configuration=Shipping -cook -stage -pak -archive
```

### 5. **Platform Deployment**

- **Windows**: Direct executable or Microsoft Store
- **Console**: Platform-specific SDKs and certification
- **Mobile**: Android APK or iOS App Store
- **VR**: Platform-specific VR runtimes

## Best Practices

### ✅ **Performance Optimization**

- Use object pooling for frequently spawned actors
- Implement level-of-detail (LOD) systems for meshes
- Optimize texture streaming and memory usage
- Profile regularly with Unreal's built-in profiler
- Use instanced static meshes for repeated objects

### ✅ **Code Organization**

- Separate game logic from presentation logic
- Use composition over inheritance where possible
- Create reusable component-based systems
- Follow Epic's coding standards and naming conventions
- Document complex systems with code comments

### ✅ **Asset Management**

- Organize content browser with clear folder structure
- Use consistent naming conventions for assets
- Create master materials with instances for variations
- Optimize texture sizes and compression settings
- Use reference viewer to track asset dependencies

### ❌ **Common Pitfalls to Avoid**

- Don't use Tick events excessively in Blueprints
- Avoid hard references between unrelated systems
- Don't ignore memory leaks and garbage collection
- Avoid monolithic Blueprint classes (break into components)
- Don't skip source control for project collaboration

## Common Patterns

### Game Mode and Game State Architecture

```cpp
// Custom Game Mode
UCLASS()
class MYGAME_API AMyGameMode : public AGameModeBase
{
    GENERATED_BODY()

public:
    AMyGameMode();

protected:
    virtual void BeginPlay() override;

    UFUNCTION(BlueprintCallable, Category = "Game Management")
    void StartNewRound();

    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Game Settings")
    int32 MaxPlayers = 4;
};
```

### Component-Based Entity System

```cpp
// Reusable Health Component
UCLASS(ClassGroup=(Custom), meta=(BlueprintSpawnableComponent))
class MYGAME_API UHealthComponent : public UActorComponent
{
    GENERATED_BODY()

public:
    UHealthComponent();

    UFUNCTION(BlueprintCallable, Category = "Health")
    void TakeDamage(float DamageAmount);

    UFUNCTION(BlueprintCallable, Category = "Health")
    void Heal(float HealAmount);

    DECLARE_DYNAMIC_MULTICAST_DELEGATE_OneParam(FOnHealthChanged, float, NewHealth);
    UPROPERTY(BlueprintAssignable, Category = "Events")
    FOnHealthChanged OnHealthChanged;

protected:
    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Health")
    float MaxHealth = 100.0f;

    UPROPERTY(BlueprintReadOnly, Category = "Health")
    float CurrentHealth;
};
```

### Singleton Pattern for Managers

```cpp
// Game Instance Singleton
UCLASS()
class MYGAME_API UMyGameInstance : public UGameInstance
{
    GENERATED_BODY()

public:
    virtual void Init() override;

    UFUNCTION(BlueprintCallable, Category = "Save System")
    void SaveGame();

    UFUNCTION(BlueprintCallable, Category = "Save System")
    void LoadGame();

    // Singleton access
    UFUNCTION(BlueprintCallable, Category = "Game Instance")
    static UMyGameInstance* GetMyGameInstance(const UObject* WorldContext);

protected:
    UPROPERTY(BlueprintReadOnly, Category = "Managers")
    class UAudioManager* AudioManager;

    UPROPERTY(BlueprintReadOnly, Category = "Managers")
    class UScoreManager* ScoreManager;
};
```

## Configuration

### Engine Configuration (DefaultEngine.ini)

```ini
[/Script/Engine.Engine]
+ActiveGameNameRedirects=(OldGameName="MyOldGame",NewGameName="/Script/MyGame")
bSmoothFrameRate=true
SmoothedFrameRateRange=(LowerBound=(Type=Inclusive,Value=22.000000),UpperBound=(Type=Exclusive,Value=62.000000))

[/Script/Engine.RendererSettings]
r.Mobile.DisableVertexFog=True
r.Shadow.CSM.MaxCascades=10
r.MobileMSAA=1
r.Mobile.AllowDitheredLODTransition=False

[/Script/Engine.NetworkSettings]
n.VerifyPeer=False
```

### Game Configuration (DefaultGame.ini)

```ini
[/Script/EngineSettings.GeneralProjectSettings]
ProjectID=12345678-1234-5678-9012-123456789012
ProjectName=MyAwesomeGame
ProjectVersion=1.0.0.0
CompanyName=MyGameCompany
CompanyDistinguishedName=MyGameCompany
ProjectDisplayedTitle=My Awesome Game

[/Script/UnrealEd.ProjectPackagingSettings]
Build=IfProjectHasCode
BuildConfiguration=PPBC_Shipping
StagingDirectory=(Path="C:/MyGameBuilds")
```

### Input Configuration (DefaultInput.ini)

```ini
[/Script/Engine.InputSettings]
-AxisConfig=(AxisKeyName="Gamepad_LeftX",AxisProperties=(DeadZone=0.25,Exponent=1.f,Sensitivity=1.f))
+AxisConfig=(AxisKeyName="Gamepad_LeftX",AxisProperties=(DeadZone=0.25,Exponent=1.f,Sensitivity=1.f))

-ActionMappings=(ActionName="Jump",bShift=False,bCtrl=False,bAlt=False,bCmd=False,Key=SpaceBar)
+ActionMappings=(ActionName="Jump",bShift=False,bCtrl=False,bAlt=False,bCmd=False,Key=SpaceBar)
+ActionMappings=(ActionName="Jump",bShift=False,bCtrl=False,bAlt=False,bCmd=False,Key=Gamepad_FaceButton_Bottom)

-AxisMappings=(AxisName="MoveForward",Scale=1.f,Key=W)
+AxisMappings=(AxisName="MoveForward",Scale=1.f,Key=W)
+AxisMappings=(AxisName="MoveForward",Scale=-1.f,Key=S)
+AxisMappings=(AxisName="MoveForward",Scale=1.f,Key=Gamepad_LeftY)
```

## Essential Development Commands

### Editor Console Commands

```bash
# Performance profiling
stat fps              # Show FPS counter
stat unit             # Show frame time breakdown
stat memory           # Memory usage statistics
stat streaming        # Texture streaming stats

# Rendering debugging
show collision        # Display collision meshes
show bounds          # Show bounding boxes
show bones           # Display skeletal mesh bones
viewmode lit         # Standard lit rendering
viewmode unlit       # Unlit rendering mode
viewmode wireframe   # Wireframe view

# Gameplay debugging
showdebug ai         # AI debugging information
showdebug animation  # Animation debugging
showdebug physics    # Physics debugging
```

### Build and Packaging Commands

```bash
# Hot reload (during development)
Ctrl+Alt+F11         # Compile and hot reload C++ changes

# Cook content for platform
"UnrealEditor.exe" "MyGame.uproject" -run=cook -targetplatform=WindowsNoEditor

# Package game
"UnrealEditor.exe" "MyGame.uproject" -run=package -targetplatform=Win64 -configuration=Shipping
```

## Common Issues & Solutions

### Blueprint Compilation Errors

**Problem**: "Blueprint could not be compiled" with cryptic error messages
**Solution**:

- Check for circular dependencies between Blueprint classes
- Verify all referenced assets exist and are not corrupted
- Use "Compile" button instead of "Compile on Save" for debugging
- Clear intermediate and saved folders if corruption is suspected

### C++ Hot Reload Failures

**Problem**: Changes to C++ code not reflecting in editor
**Solution**:

```cpp
// Close editor before major header changes
// Use UPROPERTY() meta tags properly
UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Settings", meta = (ClampMin = "0.0", ClampMax = "100.0"))
float MyValue = 50.0f;

// Rebuild entire project if hot reload fails
// Use "Refresh Visual Studio Project" if IntelliSense breaks
```

### Performance Issues

**Problem**: Low frame rate and stuttering during gameplay
**Solution**:

- Profile with Stat commands to identify bottlenecks
- Reduce draw calls using instanced static meshes
- Optimize texture streaming settings
- Use LOD (Level of Detail) systems for complex meshes
- Implement object pooling for frequently spawned actors

### Memory Leaks

**Problem**: Memory usage increasing over time during gameplay
**Solution**:

```cpp
// Properly clean up dynamic objects
UFUNCTION(BlueprintCallable, Category = "Cleanup")
void CleanupDynamicObjects()
{
    for (AActor* Actor : ActorsToCleanup)
    {
        if (IsValid(Actor))
        {
            Actor->Destroy();
        }
    }
    ActorsToCleanup.Empty();
}

// Use weak pointers for optional references
UPROPERTY()
TWeakObjectPtr<AActor> OptionalActorReference;
```

## Performance Optimization

### Rendering Optimization

- **LOD Systems**: Automatically reduce polygon count based on distance
- **Instanced Static Meshes**: Render many identical objects efficiently
- **Occlusion Culling**: Hide objects blocked by other geometry
- **Texture Streaming**: Load textures on-demand based on distance

```cpp
// LOD configuration example
UCLASS()
class MYGAME_API AOptimizedActor : public AActor
{
    GENERATED_BODY()

public:
    AOptimizedActor();

protected:
    UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category = "Mesh")
    UStaticMeshComponent* MeshComponent;

    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Optimization")
    float LODDistance = 1000.0f;

    virtual void Tick(float DeltaTime) override;

private:
    void UpdateLODBasedOnDistance();
};
```

### Memory Management

- **Object Pooling**: Reuse objects instead of creating/destroying
- **Garbage Collection**: Understand UE's automatic memory management
- **Asset Streaming**: Load/unload content based on player location

### CPU Optimization

- **Reduce Tick Events**: Use timers instead of constant ticking
- **Efficient Algorithms**: Use appropriate data structures (TMap, TArray)
- **Threading**: Utilize background tasks for heavy computations

## Security Considerations

### Code Protection

- **Obfuscation**: Use shipping builds with optimized code
- **Asset Encryption**: Encrypt sensitive game assets
- **Anti-Cheat**: Implement server-side validation for multiplayer

### Network Security

```cpp
// Server-side validation example
UFUNCTION(Server, Reliable, WithValidation)
void ServerProcessPlayerAction(const FPlayerAction& Action);

bool ServerProcessPlayerAction_Validate(const FPlayerAction& Action)
{
    // Validate action is possible/legal
    return Action.IsValid() && CanPlayerPerformAction(Action);
}

void ServerProcessPlayerAction_Implementation(const FPlayerAction& Action)
{
    // Process validated action on server
    ProcessPlayerAction(Action);
}
```

### Data Protection

- **Save Game Encryption**: Encrypt player save data
- **Config File Validation**: Verify configuration files haven't been tampered with
- **Asset Integrity**: Checksum important game assets

## Advanced Features

### Virtual Reality Development

```cpp
// VR-specific functionality
UCLASS()
class MYGAME_API AVRPlayerController : public APlayerController
{
    GENERATED_BODY()

public:
    virtual void BeginPlay() override;

protected:
    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "VR")
    class UMotionControllerComponent* LeftMotionController;

    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "VR")
    class UMotionControllerComponent* RightMotionController;

    UFUNCTION(BlueprintCallable, Category = "VR")
    void HandleVRInput();
};
```

### Multiplayer Networking

```cpp
// Replicated actor for multiplayer
UCLASS()
class MYGAME_API AMultiplayerActor : public AActor
{
    GENERATED_BODY()

public:
    AMultiplayerActor();

    virtual void GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const override;

protected:
    UPROPERTY(Replicated, BlueprintReadOnly, Category = "Networking")
    float ReplicatedValue;

    UFUNCTION(NetMulticast, Reliable)
    void MulticastFunction();

    UFUNCTION(Server, Reliable, WithValidation)
    void ServerFunction(float NewValue);
};
```

### Plugin Development

```cpp
// Custom plugin module
class FMyGamePluginModule : public IModuleInterface
{
public:
    virtual void StartupModule() override;
    virtual void ShutdownModule() override;

    static inline FMyGamePluginModule& Get()
    {
        return FModuleManager::LoadModuleChecked<FMyGamePluginModule>("MyGamePlugin");
    }
};
```

## Useful Resources

- **Official Documentation**: https://docs.unrealengine.com/
- **Unreal Engine Source Code**: https://github.com/EpicGames/UnrealEngine
- **Community Hub**: https://unrealengine.com/community
- **Learning Resources**:
  - Unreal Engine Online Learning Platform
  - GameDev.tv Unreal Engine Courses
  - Epic Games' Official YouTube Channel
- **Tools & Extensions**:
  - UnrealVS (Visual Studio integration)
  - Unreal Build Tool (UBT)
  - Unreal Header Tool (UHT)
  - Blueprint Visual Scripting
  - Material Editor
  - Animation Blueprint Editor
  - Level Editor with World Composition

## Framework-Specific Guidelines

### Code Style and Conventions

```cpp
// Epic Games coding standards
class MYGAME_API UMyClass : public UObject  // API macro for DLL export
{
    GENERATED_BODY()  // Required macro for Unreal reflection

public:
    // Function naming: PascalCase
    UFUNCTION(BlueprintCallable, Category = "My Category")
    void DoSomething();

protected:
    // Variable naming: PascalCase with descriptive names
    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Settings")
    float MovementSpeed = 100.0f;

    // Private variables: PascalCase (not camelCase)
    bool bIsActive = true;  // Boolean prefix 'b'
    int32 CurrentHealth = 100;  // Use int32 instead of int
    float DeltaTime = 0.0f;  // Use float, not double unless needed
};
```

### Project Organization Patterns

- **Content Browser Structure**: Organize by feature, not by asset type
- **Code Modules**: Separate game logic, UI, and platform-specific code
- **Blueprint Hierarchy**: Use parent classes for shared functionality
- **Asset Naming**: Consistent prefixes (BP* for Blueprints, M* for Materials)

### Architecture Patterns

- **Model-View-Controller**: Separate data, presentation, and logic
- **Component-Entity-System**: Use composition over inheritance
- **Event-Driven Architecture**: Use delegates and event dispatchers
- **State Machines**: Implement complex behaviors with clear state transitions

## Integration Points

### Version Control (Perforce/Git)

- **Purpose**: Source control optimized for binary assets
- **Setup**: Configure .uproject and .gitignore/.p4ignore files
- **Usage**: Binary asset handling, large file support

```bash
# Git LFS configuration for Unreal Engine
git lfs track "*.uasset"
git lfs track "*.umap"
git lfs track "*.ubulk"
git lfs track "*.upk"
```

### Continuous Integration

- **Purpose**: Automated building and testing
- **Setup**: BuildGraph scripts for complex build pipelines
- **Usage**: Platform-specific builds, automated testing

```xml
<!-- Example BuildGraph script -->
<BuildGraph xmlns="http://www.epicgames.com/BuildGraph">
  <Agent Name="Default" Type="Win64">
    <Node Name="Compile Editor">
      <Compile Target="UnrealEditor" Platform="Win64" Configuration="Development"/>
    </Node>
    <Node Name="Cook Content" Requires="Compile Editor">
      <Cook Project="$(ProjectFile)" Platform="WindowsNoEditor"/>
    </Node>
  </Agent>
</BuildGraph>
```

### External Libraries

- **Purpose**: Integrate third-party C++ libraries
- **Setup**: Create plugin wrappers for external dependencies
- **Usage**: Physics engines, audio systems, analytics

## Platform Compatibility

### Engine Requirements

- **Windows**: Windows 10/11, Visual Studio 2019/2022
- **Mac**: macOS 10.15+, Xcode 12+
- **Linux**: Ubuntu 18.04+, GCC 9+
- **Mobile**: Android SDK 28+, iOS 13+
- **Console**: Platform-specific SDKs required

### Target Platform Support

- **Desktop**: Windows, macOS, Linux
- **Mobile**: iOS, Android
- **Console**: PlayStation 4/5, Xbox One/Series X|S, Nintendo Switch
- **VR**: Oculus, SteamVR, PlayStation VR, Magic Leap
- **Web**: Limited experimental support

## Troubleshooting

### Debug Configuration

```ini
; Development debug settings
[/Script/Engine.Engine]
bUseFixedFrameRate=False
GameViewportClientClassName=/Script/Engine.GameViewportClient

[Core.Log]
LogTemp=Verbose
LogBlueprintUserMessages=Verbose
LogExec=Warning
```

### Common Error Messages

**Error**: `Assertion failed: IsInGameThread()`
**Cause**: Attempting to modify UObject from non-game thread
**Solution**: Use `AsyncTask(ENamedThreads::GameThread, []() { /* Your code */ });`

**Error**: `Blueprint compilation failed`
**Cause**: Circular dependency or missing asset reference
**Solution**: Check Blueprint references, break circular dependencies

**Error**: `Module 'MyGame' could not be loaded`
**Cause**: C++ compilation errors or missing dependencies
**Solution**: Rebuild project, check Build.cs file dependencies

**Error**: `Cook failed` during packaging
**Cause**: Invalid asset references or platform-specific issues
**Solution**: Validate all asset references, check platform-specific settings

### Performance Debugging Tools

```bash
# Profiling commands
stat startfile        # Start recording performance data
stat stopfile         # Stop recording
profilegpu            # GPU performance analysis
dumpticks             # Analyze tick performance
memreport             # Detailed memory analysis
```

## Advanced Integration Patterns

### Custom Blueprint Nodes

```cpp
// Custom Blueprint function library
UCLASS()
class MYGAME_API UMyBlueprintFunctionLibrary : public UBlueprintFunctionLibrary
{
    GENERATED_BODY()

public:
    UFUNCTION(BlueprintCallable, Category = "Math", CallInEditor = true)
    static float ComplexMathOperation(float A, float B, float C);

    UFUNCTION(BlueprintCallable, Category = "Utilities")
    static bool IsValidGameplayTag(const FGameplayTag& Tag);
};
```

### Editor Scripting and Automation

```cpp
// Editor utility widget for content creation
UCLASS()
class MYGAMEEDITOR_API UMyEditorUtilityWidget : public UEditorUtilityWidget
{
    GENERATED_BODY()

public:
    UFUNCTION(BlueprintCallable, Category = "Content Creation")
    void BatchProcessAssets();

    UFUNCTION(BlueprintCallable, Category = "Level Tools")
    void AutoGenerateNavMesh();
};
```

This comprehensive guide provides production-ready patterns for Unreal Engine development, focusing on practical AI agent decision-making for AAA game development projects.
