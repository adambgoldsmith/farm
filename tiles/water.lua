water = {
    x = 0,
    y = 0,
    name = "water",
    type = "tile",
    sprite = love.graphics.newImage("res/missing_texture.png")
}

function water:new(o, x, y)
    o = o or {}
    o.x = x or 0
    o.y = y or 0
    o.sprite = love.graphics.newImage("res/water.png")
    setmetatable(o, self)
    self.__index = self
    return o
end

function water:draw()
    love.graphics.draw(self.sprite, self.x, self.y)
end

return water