carrot_seed = {
    x = 0,
    y = 0,
    name = "carrot seed",
    type = "seed",
    growth_time = 10,
    produce = "carrot"
}

function carrot_seed:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function carrot_seed:draw()
    love.graphics.setColor(255, 255, 0)
    love.graphics.print(self.name, self.x, self.y)
end

function carrot_seed:drop(x, y)
    self.x = x
    self.y = y
end

return carrot_seed