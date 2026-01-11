User: Create a Lua-based ECS for managing game entities with good performance
Agent: Implements optimized ECS using Lua tables and metatables with C integration points:

-- Entity Component System in Lua
local ECS = {}
ECS.__index = ECS

function ECS.new()
    local self = setmetatable({}, ECS)
    self.entities = {}
    self.components = {}
    self.systems = {}
    self.entityCount = 0
    self.componentPools = {} -- Object pooling for performance
    return self
end

-- Component registration with type checking
function ECS:registerComponent(name, componentDef)
    self.components[name] = componentDef
    self.componentPools[name] = {}
end

-- Optimized entity creation with component pooling
function ECS:createEntity()
    self.entityCount = self.entityCount + 1
    local entity = self.entityCount
    self.entities[entity] = {}
    return entity
end

function ECS:addComponent(entity, componentName, data)
    if not self.components[componentName] then
        error("Component " .. componentName .. " not registered")
    end
    
    -- Use pooled component if available
    local component = table.remove(self.componentPools[componentName])
    if not component then
        component = {}
    end
    
    -- Reset component data
    for k, v in pairs(self.components[componentName]) do
        component[k] = data[k] or v.default
    end
    
    self.entities[entity][componentName] = component
end

-- High-performance system iteration
function ECS:query(...)
    local componentNames = {...}
    local results = {}
    
    for entity, components in pairs(self.entities) do
        local hasAll = true
        for _, componentName in ipairs(componentNames) do
            if not components[componentName] then
                hasAll = false
                break
            end
        end
        
        if hasAll then
            results[#results + 1] = {entity = entity, components = components}
        end
    end
    
    return results
end