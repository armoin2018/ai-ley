// Server-side validation example
UFUNCTION(Server, Reliable, WithValidation)
void ServerProcessPlayerAction(const FPlayerAction& Action);

bool ServerProcessPlayerAction_Validate(const FPlayerAction& Action)
{
    // Validate action is possible/legal
    return Action.IsValid() && CanPlayerPerformAction(Action);
}

void ServerProcessPlayerAction_Implementation(const FPlayerAction& Action)
{
    // Process validated action on server
    ProcessPlayerAction(Action);
}