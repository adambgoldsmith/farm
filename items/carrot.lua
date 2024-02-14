item = require("items.item")

carrot = item:new()

function carrot:new(o, x, y)
    o = o or {}
    self.x = x
    self.y = y
    self.name = "carrot"
    self.type = "produce"
    self.sprite = love.graphics.newImage("res/carrot.png")
    setmetatable(o, self)
    self.__index = self
    return o  
end

return carrot