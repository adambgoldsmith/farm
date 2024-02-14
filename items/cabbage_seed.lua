item = require("items.item")

cabbage_seed = item:new()

function cabbage_seed:new(o, x, y)
    o = o or {}
    self.x = x
    self.y = y
    self.name = "cabbage seed"
    self.type = "seed"
    self.growth_time = 20
    self.produce = "cabbage"
    setmetatable(o, self)
    self.__index = self
    return o
end

return cabbage_seed