item = require("items.item")

tomato = item:new()

function tomato:new(o, x, y)
    o = o or {}
    self.x = x
    self.y = y
    self.name = "tomato"
    self.type = "produce"
    self.sprite = love.graphics.newImage("res/tomato.png")
    setmetatable(o, self)
    self.__index = self
    return o  
end

return tomato