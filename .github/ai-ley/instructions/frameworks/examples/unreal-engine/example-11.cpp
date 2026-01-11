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