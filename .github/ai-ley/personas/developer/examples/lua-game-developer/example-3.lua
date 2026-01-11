User: Create a Love2D game structure with hot-reloading for rapid development
Agent: Implements comprehensive hot-reload system with state preservation:

-- Hot-Reload System for Love2D
local HotReload = {}

function HotReload.new()
    local self = {}
    self.watchedFiles = {}
    self.lastModified = {}
    self.reloadCallbacks = {}
    
    function self:watchFile(filename, callback)
        self.watchedFiles[filename] = true
        self.reloadCallbacks[filename] = callback
        self.lastModified[filename] = love.filesystem.getInfo(filename).modtime
    end
    
    function self:update(dt)
        for filename in pairs(self.watchedFiles) do
            local info = love.filesystem.getInfo(filename)
            if info and info.modtime > self.lastModified[filename] then
                self:reloadFile(filename)
                self.lastModified[filename] = info.modtime
            end
        end
    end
    
    function self:reloadFile(filename)
        print("Reloading: " .. filename)
        
        -- Clear package cache
        package.loaded[filename:gsub("%.lua$", "")] = nil
        
        -- Execute reload callback
        if self.reloadCallbacks[filename] then
            local success, error = pcall(self.reloadCallbacks[filename])
            if not success then
                print("Reload error in " .. filename .. ": " .. error)
            end
        end
    end
    
    return self
end

-- Main game structure with hot-reload support
local Game = {}

function Game.new()
    local self = {}
    self.hotReload = HotReload.new()
    self.entities = {}
    self.systems = {}
    
    -- Watch game files for changes
    self.hotReload:watchFile("player.lua", function()
        -- Preserve player state during reload
        local playerData = self.player and self.player:serialize() or nil
        self.player = require("player").new()
        if playerData then
            self.player:deserialize(playerData)
        end
    end)
    
    return self
end

function love.update(dt)
    if game then
        game.hotReload:update(dt)
        -- Update game systems
    end
end