Class = require("class")
Item = require("items.item")

FishingRod = Class {
    __includes = Item,
    init = function(self, x, y)
        Item.init(self)
        self.name = "fishing_rod"
        self.type = "tool"
        self.pos = {x = x, y = y}
        self.size = {w = 32, h = 32}
        self.img = love.graphics.newImage("res/fishing_rod.png")
    end,
}

return FishingRod