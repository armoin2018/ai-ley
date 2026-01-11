# Command line building
"C:\Program Files\Epic Games\UE_5.4\Engine\Build\BatchFiles\Build.bat" MyGameEditor Win64 Development

# Packaging for distribution
"C:\Program Files\Epic Games\UE_5.4\Engine\Build\BatchFiles\RunUAT.bat" BuildCookRun -project="MyGame.uproject" -platform=Win64 -configuration=Shipping -cook -stage -pak -archive