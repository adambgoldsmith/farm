item = require("items.item")

tomato = item:new()

function tomato:new(o, x, y)
    o = o or item:new(o, x, y)
    o.x = x
    o.y = y
    o.name = "tomato"
    o.type = "produce"
    o.sprite = love.graphics.newImage("res/tomato.png")
    setmetatable(o, self)
    self.__index = self
    return o  
end

return tomato