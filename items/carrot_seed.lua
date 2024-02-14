item = require("items.item")
carrot = require("items.carrot")

carrot_seed = item:new()

function carrot_seed:new(o, x, y)
    o = o or item:new(o, x, y)
    o.x = x
    o.y = y
    o.name = "carrot seed"
    o.type = "seed"
    o.growth_time = 10
    o.produce = carrot
    setmetatable(o, self)
    self.__index = self
    return o
end

return carrot_seed