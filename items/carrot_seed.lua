Class = require("class")
Item = require("items.item")
Carrot = require("items.carrot")

CarrotSeed = Class {
    __includes = Item,
    init = function(self, x, y)
        Item.init(self)
        self.pos = {x = x, y = y}
        self.size = {w = 32, h = 32}
        self.name = "carrot_seed"
        self.type = "seed"
        self.img = love.graphics.newImage("res/carrot_seed.png")
        self.growth_time = 5
        self.produce = Carrot
    end
}

return CarrotSeed