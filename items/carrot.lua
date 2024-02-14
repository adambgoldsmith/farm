item = require("items.item")

carrot = item:new()

function carrot:new(o, x, y)
    o = o or item:new(o, x, y)
    o.x = x
    o.y = y
    o.name = "carrot"
    o.type = "produce"
    o.sprite = love.graphics.newImage("res/carrot.png")
    setmetatable(o, self)
    self.__index = self
    return o
end

return carrot