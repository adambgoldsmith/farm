house = {
    x = 0,
    y = 0,
    name = "house",
    type = "building",
    sprite = love.graphics.newImage("res/missing_texture.png")
}

function house:new(o, x, y)
    o = o or {}
    o.x = x or 0
    o.y = y or 0
    o.sprite = love.graphics.newImage("res/house.png")
    setmetatable(o, self)
    self.__index = self
    return o
end

function house:draw()
    love.graphics.draw(self.sprite, self.x, self.y)
end

return house