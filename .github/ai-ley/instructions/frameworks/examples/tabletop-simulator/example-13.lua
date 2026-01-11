function generateRandomBoard(width, height)
    for x = 1, width do
        for y = 1, height do
            local tileType = math.random(1, 4)
            local position = {x * 2, 1, y * 2}
            
            spawnObject({
                type = "Custom_Tile",
                position = position,
                callback_function = function(tile)
                    tile.setCustomObject({
                        image = getTileImage(tileType),
                        thickness = 0.2
                    })
                end
            })
        end
    end
end