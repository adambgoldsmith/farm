carrot = require("items.carrot")

caravan = {
    x = 0,
    y = 0,
    name = "caravan",
    type = "building",
    sprite = love.graphics.newImage("res/missing_texture.png")
}

function caravan:new(o, x, y)
    o = o or {}
    o.x = x or 0
    o.y = y or 0
    o.name = "caravan"
    o.type = "building"
    o.sprite = love.graphics.newImage("res/caravan.png")
    o.items = {carrot, "nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing"}
    setmetatable(o, self)
    self.__index = self
    return o
end

function caravan:draw()
    self.sprite:setFilter("nearest", "nearest")
    love.graphics.draw(self.sprite, self.x, self.y)
end

return caravan

