Class = require("class")
Item = require("items.item")
Tomato = require("items.tomato")

TomatoSeed = Class {
    __includes = Item,
    init = function(self, x, y)
        Item.init(self)
        self.pos = {x = x, y = y}
        self.size = {w = 32, h = 32}
        self.name = "tomato_seed"
        self.type = "seed"
        self.img = love.graphics.newImage("res/tomato_seed.png")
        self.growth_time = 12
        self.produce = Tomato
    end
}

return TomatoSeed