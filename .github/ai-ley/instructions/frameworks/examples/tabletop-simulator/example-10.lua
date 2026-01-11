-- Save game state to external file
function saveGameState()
    local data = JSON.encode(gameState)
    self.script_state = data
end

function loadGameState()
    if self.script_state ~= "" then
        gameState = JSON.decode(self.script_state)
    end
end