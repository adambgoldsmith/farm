tomato_seed = {
    x = 0,
    y = 0,
    name = "tomato seed",
    type = "seed",
    growth_time = 20,
    produce = "tomato"
}

function tomato_seed:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function tomato_seed:draw()
    love.graphics.setColor(255, 0, 0)
    love.graphics.print(self.name, self.x, self.y)
end

function tomato_seed:drop(x, y)
    self.x = x
    self.y = y
end

return tomato_seed