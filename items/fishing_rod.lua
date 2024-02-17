item = require("items.item")

fishing_rod = item:new()

function fishing_rod:new(o, x, y)
    o = o or item:new(o, x, y)
    o.x = x
    o.y = y
    o.name = "fishing_rod"
    o.type = "tool"
    o.sprite = love.graphics.newImage("res/fishing_rod.png")
    setmetatable(o, self)
    self.__index = self
    return o
end

return fishing_rod