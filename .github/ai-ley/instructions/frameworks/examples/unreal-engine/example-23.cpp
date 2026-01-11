// VR-specific functionality
UCLASS()
class MYGAME_API AVRPlayerController : public APlayerController
{
    GENERATED_BODY()

public:
    virtual void BeginPlay() override;

protected:
    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "VR")
    class UMotionControllerComponent* LeftMotionController;

    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "VR")
    class UMotionControllerComponent* RightMotionController;

    UFUNCTION(BlueprintCallable, Category = "VR")
    void HandleVRInput();
};