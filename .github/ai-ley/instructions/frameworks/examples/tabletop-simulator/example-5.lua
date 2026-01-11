function onObjectPickUp(player_color, picked_up_object)
    print(player_color .. " picked up " .. picked_up_object.getName())
    
    -- Validate pickup rules
    if not canPickUp(player_color, picked_up_object) then
        picked_up_object.setLock(true)
        broadcastToColor("Cannot pick up this object!", player_color, "Red")
        return false
    end
    
    return true
end