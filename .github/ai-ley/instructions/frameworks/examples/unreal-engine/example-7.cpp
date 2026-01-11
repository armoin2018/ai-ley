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