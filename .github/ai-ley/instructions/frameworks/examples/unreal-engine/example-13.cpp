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