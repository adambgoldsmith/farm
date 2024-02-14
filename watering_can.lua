watering_can = {
    x = 0,
    y = 0,
    name = "watering can",
    type = "tool"
}

function watering_can:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function watering_can:draw()
    love.graphics.setColor(0, 0, 255)
    love.graphics.print(self.name, self.x, self.y)
end

function watering_can:drop(x, y)
    self.x = x
    self.y = y
end

return watering_can
