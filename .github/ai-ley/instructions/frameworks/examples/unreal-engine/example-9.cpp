// Debug logging
UE_LOG(LogTemp, Warning, TEXT("Player health: %f"), PlayerHealth);

// Visual debugging
DrawDebugSphere(GetWorld(), GetActorLocation(), 100.0f, 12, FColor::Red, false, 1.0f);

// Blueprint debugging
// Use breakpoints in Blueprint graphs
// Print String nodes for runtime debugging