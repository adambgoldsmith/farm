Class = require("class")
Item = require("items.item")

WateringCan = Class {
    __includes = Item,
    init = function(self, x, y)
        Item.init(self)
        self.pos = {x = x, y = y}
        self.size = {w = 32, h = 32}
        self.name = "watering_can"
        self.type = "tool"
        self.img = love.graphics.newImage("res/watering_can_v2.png")
    end
}

return WateringCan