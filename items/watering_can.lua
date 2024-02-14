item = require("items.item")

watering_can = item:new()

function watering_can:new(o, x, y)
    o = o or {}
    self.x = x
    self.y = y
    self.name = "watering can"
    self.type = "tool"
    self.sprite = love.graphics.newImage("res/watering_can.png")
    setmetatable(o, self)
    self.__index = self
    return o
end

return watering_can
