gameState = {
    players = {},
    currentPlayer = 1,
    phase = "setup",
    round = 1
}

function advanceGamePhase()
    if gameState.phase == "setup" then
        gameState.phase = "play"
        broadcastToAll("Game has started!", "Green")
    elseif gameState.phase == "play" then
        gameState.phase = "scoring"
        calculateScores()
    end
    
    updateGameStateUI()
end