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