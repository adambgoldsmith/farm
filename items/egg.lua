item = require("items.item")

egg = item:new()

function egg:new(o, x, y)
    o = o or item:new(o, x, y)
    o.x = x
    o.y = y
    o.name = "egg"
    o.type = "produce"
    o.sprite = love.graphics.newImage("res/egg.png")
    setmetatable(o, self)
    self.__index = self
    return o
end

return egg