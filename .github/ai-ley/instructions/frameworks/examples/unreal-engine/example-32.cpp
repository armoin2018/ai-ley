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