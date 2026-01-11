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