item = require("items.item")

hoe = item:new()

function hoe:new(o, x, y)
    o = o or item:new(o, x, y)
    o.x = x
    o.y = y
    o.name = "hoe"
    o.type = "tool"
    o.sprite = love.graphics.newImage("res/hoe.png")
    setmetatable(o, self)
    self.__index = self
    return o
end

return hoe