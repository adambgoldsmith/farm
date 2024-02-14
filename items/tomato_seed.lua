item = require("items.item")

tomato_seed = item:new()

function tomato_seed:new(o, x, y)
    o = o or {}
    self.x = x
    self.y = y
    self.name = "tomato seed"
    self.type = "seed"
    self.growth_time = 15
    self.produce = "tomato"
    setmetatable(o, self)
    self.__index = self
    return o
end

return tomato_seed