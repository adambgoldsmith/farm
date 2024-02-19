Class = require("class")
Item = require("items.item")

Sword = Class {
    __includes = Item,
    init = function(self, x, y)
        Item.init(self)
        self.name = "sword"
        self.type = "tool"
        self.pos = {x = x, y = y}
        self.size = {w = 32, h = 32}
        self.img = love.graphics.newImage("res/sword.png")
    end,
}

return Sword