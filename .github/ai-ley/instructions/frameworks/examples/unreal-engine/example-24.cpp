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