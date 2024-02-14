item = require("items.item")

watering_can = item:new()

function watering_can:new(o, x, y)
    o = o or item:new(o, x, y)
    o.x = x
    o.y = y
    o.name = "watering can"
    o.type = "tool"
    o.sprite = love.graphics.newImage("res/watering_can.png")
    setmetatable(o, self)
    self.__index = self
    return o
end

return watering_can
