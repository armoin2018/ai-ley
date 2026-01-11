function dealCards(players, cardsPerPlayer)
    local deck = getObjectFromGUID("deck_guid")
    
    for i, player in ipairs(players) do
        local hand = {}
        for j = 1, cardsPerPlayer do
            local card = deck.takeObject({
                position = getPlayerHandPosition(player, j)
            })
            table.insert(hand, card)
        end
        playerHands[player] = hand
    end
end