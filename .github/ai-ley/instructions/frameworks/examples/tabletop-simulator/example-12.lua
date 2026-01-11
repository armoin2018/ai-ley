function nextTurn()
    gameState.currentPlayer = (gameState.currentPlayer % #getSeatedPlayers()) + 1
    local currentPlayerColor = getSeatedPlayers()[gameState.currentPlayer]
    
    updateTurnIndicator(currentPlayerColor)
    broadcastToColor("Your turn!", currentPlayerColor, "Green")
    
    -- Reset turn-specific variables
    actionsThisTurn = 0
    maxActions = 3
end