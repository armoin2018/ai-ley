function createCustomPiece(data)
    spawnObject({
        type = "Custom_Model",
        position = data.position,
        callback_function = function(obj)
            obj.setCustomObject({
                mesh = data.meshURL,
                diffuse = data.textureURL,
                material = 3,  -- Plastic material
                specular_intensity = 0.1
            })
            
            obj.setLuaScript(data.script)
            obj.setState(data.initialState)
        end
    })
end