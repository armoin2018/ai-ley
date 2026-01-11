-- Essential object manipulation
object.setPosition({x, y, z})        # Move object
object.setRotation({x, y, z})        # Rotate object
object.setLock(true/false)           # Lock/unlock object
object.getName()                     # Get object name

-- Player interaction
broadcastToAll(message, color)       # Message all players
broadcastToColor(message, color)     # Message specific player
getSeatedPlayers()                   # Get list of active players

-- Game management
startLuaCoroutine(self, "function")  # Start async function
destroyObject(object)                # Remove object from game
spawnObject({type, position})        # Create new object

-- Data persistence
self.script_state                    # Save/load script data
JSON.encode(table)                   # Serialize data
JSON.decode(string)                  # Deserialize data