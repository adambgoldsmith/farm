item = require("items.item")

cabbage = item:new()

function cabbage:new(o, x, y)
    o = o or {}
    self.x = x
    self.y = y
    self.name = "cabbage"
    self.type = "produce"
    self.sprite = love.graphics.newImage("res/cabbage.png")
    setmetatable(o, self)
    self.__index = self
    return o
end

return cabbage