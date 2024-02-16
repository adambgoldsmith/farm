grass = {
    x = 0,
    y = 0,
    name = "grass",
    type = "tile",
    sprite =  love.graphics.newImage("res/missing_texture.png")
}

function grass:new(o, x, y, sprite)
    o = o or {}
    o.x = x or 0
    o.y = y or 0
    o.sprite = sprite or love.graphics.newImage("res/missing_texture.png")
    setmetatable(o, self)
    self.__index = self
    return o
end

function grass:draw()
    love.graphics.draw(self.sprite, self.x, self.y)
end

return grass

