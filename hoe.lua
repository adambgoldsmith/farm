hoe = {
    x = 0,
    y = 0,
    name = "hoe",
    type = "tool"
}

function hoe:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function hoe:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(self.name, self.x, self.y)
end

function hoe:drop(x, y)
    self.x = x
    self.y = y
end

return hoe