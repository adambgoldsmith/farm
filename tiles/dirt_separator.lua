dirt_separator = {
    x = 0,
    y = 0,
    name = "dirt_separator",
    type = "tile",
    sprite = love.graphics.newImage("res/missing_texture.png")
}

function dirt_separator:new(o, x, y, sprite)
    o = o or {}
    o.x = x or 0
    o.y = y or 0
    o.sprite = sprite or love.graphics.newImage("res/dirt_separator.png")
    setmetatable(o, self)
    self.__index = self
    return o
end

function dirt_separator:draw()
    love.graphics.draw(self.sprite, self.x, self.y)
end

return dirt_separator