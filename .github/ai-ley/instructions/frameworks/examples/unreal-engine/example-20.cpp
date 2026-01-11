// Properly clean up dynamic objects
UFUNCTION(BlueprintCallable, Category = "Cleanup")
void CleanupDynamicObjects()
{
    for (AActor* Actor : ActorsToCleanup)
    {
        if (IsValid(Actor))
        {
            Actor->Destroy();
        }
    }
    ActorsToCleanup.Empty();
}

// Use weak pointers for optional references
UPROPERTY()
TWeakObjectPtr<AActor> OptionalActorReference;