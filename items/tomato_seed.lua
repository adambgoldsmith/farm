item = require("items.item")
tomato = require("items.tomato")

tomato_seed = item:new()

function tomato_seed:new(o, x, y)
    o = o or item:new(o, x, y)
    o.x = x
    o.y = y
    o.name = "tomato seed"
    o.type = "seed"
    o.sprite = love.graphics.newImage("res/tomato_seed.png")
    o.growth_time = 15
    o.produce = tomato
    setmetatable(o, self)
    self.__index = self
    return o
end

return tomato_seed