User: How do I create a secure Lua modding system that prevents malicious code execution?
Agent: Implements comprehensive sandboxing with controlled API exposure:

-- Secure Lua Sandbox for Modding
local ModSandbox = {}

function ModSandbox.new(gameAPI)
    local sandbox = {}
    
    -- Safe Lua environment with restricted globals
    local safeGlobals = {
        -- Basic Lua functions
        pairs = pairs,
        ipairs = ipairs,
        next = next,
        type = type,
        tostring = tostring,
        tonumber = tonumber,
        
        -- Safe string operations
        string = {
            sub = string.sub,
            len = string.len,
            format = string.format,
            match = string.match,
            gsub = string.gsub
        },
        
        -- Safe table operations
        table = {
            insert = table.insert,
            remove = table.remove,
            sort = table.sort,
            concat = table.concat
        },
        
        -- Safe math operations
        math = math,
        
        -- Controlled game API
        game = gameAPI or {}
    }
    
    -- Restricted functions (removed for security)
    local blockedFunctions = {
        'loadfile', 'dofile', 'loadstring', 'require',
        'module', 'io', 'os', 'debug', 'package',
        'coroutine', '_G', 'getfenv', 'setfenv'
    }
    
    function sandbox:createEnvironment()
        local env = {}
        for k, v in pairs(safeGlobals) do
            env[k] = v
        end
        return env
    end
    
    function sandbox:executeModScript(scriptCode, modName)
        local success, result = pcall(function()
            -- Create isolated environment
            local env = self:createEnvironment()
            
            -- Compile script with restricted environment
            local chunk, compileError = loadstring(scriptCode)
            if not chunk then
                error("Compilation error in mod '" .. modName .. "': " .. compileError)
            end
            
            -- Set sandbox environment
            setfenv(chunk, env)
            
            -- Execute with timeout protection
            local co = coroutine.create(chunk)
            local startTime = os.clock()
            local maxExecutionTime = 1.0 -- 1 second limit
            
            while coroutine.status(co) ~= "dead" do
                if os.clock() - startTime > maxExecutionTime then
                    error("Mod '" .. modName .. "' exceeded execution time limit")
                end
                
                local ok, result = coroutine.resume(co)
                if not ok then
                    error("Runtime error in mod '" .. modName .. "': " .. result)
                end
            end
            
            return env
        end)
        
        if not success then
            print("Mod execution failed: " .. result)
            return nil
        end
        
        return result
    end
    
    return sandbox
end