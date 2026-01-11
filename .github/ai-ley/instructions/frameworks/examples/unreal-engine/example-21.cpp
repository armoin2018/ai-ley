// LOD configuration example
UCLASS()
class MYGAME_API AOptimizedActor : public AActor
{
    GENERATED_BODY()

public:
    AOptimizedActor();

protected:
    UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category = "Mesh")
    UStaticMeshComponent* MeshComponent;

    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Optimization")
    float LODDistance = 1000.0f;

    virtual void Tick(float DeltaTime) override;

private:
    void UpdateLODBasedOnDistance();
};