function validateObject(obj)
    if obj == nil or obj.isDestroyed() then
        return false
    end
    return true
end