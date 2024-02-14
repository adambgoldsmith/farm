item = require("items.item")

cabbage = item:new()

function cabbage:new(o, x, y)
    o = o or item:new(o, x, y)
    o.x = x
    o.y = y
    o.name = "cabbage"
    o.type = "produce"
    o.sprite = love.graphics.newImage("res/cabbage.png")
    setmetatable(o, self)
    self.__index = self
    return o
end

return cabbage