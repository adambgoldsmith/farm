item = require("items.item")

carrot_seed = item:new()

function carrot_seed:new(o, x, y)
    o = o or {}
    self.x = x
    self.y = y
    self.name = "carrot seed"
    self.type = "seed"
    self.growth_time = 10
    self.produce = "carrot"
    setmetatable(o, self)
    self.__index = self
    return o
end

return carrot_seed