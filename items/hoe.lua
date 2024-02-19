Class = require("class")
Item = require("items.item")

Hoe = Class {
    __includes = Item,
    init = function(self, x, y)
        Item.init(self)
        self.pos = {x = x, y = y}
        self.size = {w = 32, h = 32}
        self.name = "hoe"
        self.type = "tool"
        self.img = love.graphics.newImage("res/hoe.png")
    end
}

return Hoe