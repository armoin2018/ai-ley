function applyPhysicsEffect(object, force)
    object.addForce({
        x = force.x,
        y = force.y, 
        z = force.z
    })
    
    -- Add torque for spinning effect
    object.addTorque({
        x = 0,
        y = force.spin,
        z = 0
    })
end