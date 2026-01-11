-- Exposed Game API for Mods
GameAPI = {
    -- Entity management
    createEntity = function(template) end,
    destroyEntity = function(id) end,
    getEntity = function(id) end,
    
    -- Component access
    addComponent = function(entityId, componentType, data) end,
    getComponent = function(entityId, componentType) end,
    removeComponent = function(entityId, componentType) end,
    
    -- Event system
    registerEvent = function(eventName, callback) end,
    triggerEvent = function(eventName, data) end,
    
    -- Resource access (controlled)
    loadTexture = function(path) end,
    loadSound = function(path) end,
    
    -- Safe utility functions
    utils = {
        math = require("utils.math"),
        random = math.random,
        time = os.time
    }
}