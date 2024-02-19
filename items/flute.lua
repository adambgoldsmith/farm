Class = require("class")
Item = require("items.item")

Flute = Class {
    __includes = Item,
    init = function(self, x, y)
        Item.init(self)
        self.name = "flute"
        self.type = "item"
        self.pos = {x = x, y = y}
        self.size = {w = 32, h = 32}
        self.img = love.graphics.newImage("res/flute.png")
    end
}

return Flute
