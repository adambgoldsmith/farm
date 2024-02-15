fence = {
    x = 0,
    y = 0,
    name = "fence",
    type = "structure",
    sprite = love.graphics.newImage("res/missing_texture.png")
}

function fence:new(o, x, y)
    o = o or {}
    o.x = x
    o.y = y
    o.sprite = love.graphics.newImage("res/fence_front.png")
    setmetatable(o, self)
    self.__index = self
    return o
end

function fence:draw()
    love.graphics.draw(self.sprite, self.x, self.y)
end

return fence