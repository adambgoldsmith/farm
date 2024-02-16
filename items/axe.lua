item = require("items.item")

axe = item:new()

function axe:new(o, x, y)
    o = o or item:new(o, x, y)
    o.x = x
    o.y = y
    o.name = "axe"
    o.type = "tool"
    o.sprite = love.graphics.newImage("res/axe.png")
    setmetatable(o, self)
    self.__index = self
    return o
end

return axe