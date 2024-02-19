Class = require("class")
Item = require("items.item")

Carrot = Class {
    __includes = Item,
    init = function(self, x, y)
        Item.init(self)
        self.pos = {x = x, y = y}
        self.size = {w = 32, h = 32}
        self.name = "carrot"
        self.type = "produce"
        self.img = love.graphics.newImage("res/carrot.png")
    end
}

return Carrot