item = require("items.item")
cabbage = require("items.cabbage")

cabbage_seed = item:new()

function cabbage_seed:new(o, x, y)
    o = o or item:new(o, x, y)
    o.x = x
    o.y = y
    o.name = "cabbage seed"
    o.type = "seed"
    o.sprite = love.graphics.newImage("res/cabbage_seed.png")
    o.growth_time = 20
    o.produce = cabbage
    setmetatable(o, self)
    self.__index = self
    return o
end

return cabbage_seed