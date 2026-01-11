function safeExecute(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        print("Error: " .. result)
        broadcastToAll("Script error occurred - check console", "Red")
    end
    return success, result
end