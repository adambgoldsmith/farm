item = require("items.item")

hoe = item:new()

function hoe:new(o, x, y)
    o = o or {}
    self.x = x
    self.y = y
    self.name = "hoe"
    self.type = "tool"
    self.sprite = love.graphics.newImage("res/hoe.png")
    setmetatable(o, self)
    self.__index = self
    return o
end

return hoe