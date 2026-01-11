// Close editor before major header changes
// Use UPROPERTY() meta tags properly
UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Settings", meta = (ClampMin = "0.0", ClampMax = "100.0"))
float MyValue = 50.0f;

// Rebuild entire project if hot reload fails
// Use "Refresh Visual Studio Project" if IntelliSense breaks