function heavyOperation()
    local co = coroutine.create(function()
        for i = 1, 1000 do
            -- Heavy work here
            if i % 100 == 0 then
                coroutine.yield(0.1)  -- Yield every 100 iterations
            end
        end
    end)
    startLuaCoroutine(self, "co")
end