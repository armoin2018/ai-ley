// Blueprint-callable C++ function
UFUNCTION(BlueprintCallable, Category = "Game Logic")
bool ProcessComplexCalculation(const TArray<float>& InputData, float& OutResult);

// Blueprint implementable event
UFUNCTION(BlueprintImplementableEvent, Category = "Events")
void OnPlayerScoreChanged(int32 NewScore);

// Blueprint native event (can be overridden in Blueprint)
UFUNCTION(BlueprintNativeEvent, Category = "Actions")
void PerformSpecialAttack();
virtual void PerformSpecialAttack_Implementation();