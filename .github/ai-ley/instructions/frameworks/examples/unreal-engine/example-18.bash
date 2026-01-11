# Hot reload (during development)
Ctrl+Alt+F11         # Compile and hot reload C++ changes

# Cook content for platform
"UnrealEditor.exe" "MyGame.uproject" -run=cook -targetplatform=WindowsNoEditor

# Package game
"UnrealEditor.exe" "MyGame.uproject" -run=package -targetplatform=Win64 -configuration=Shipping