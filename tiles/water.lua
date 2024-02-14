water = {
    x = 0,
    y = 0,
}

function water:new(o, x, y)
    o = o or {}
    o.x = x or 0
    o.y = y or 0
    setmetatable(o, self)
    self.__index = self
    return o
end

function water:draw()
    love.graphics.setColor(0, 0, 255)
    love.graphics.rectangle("fill", self.x, self.y, 32, 32)
end

return water