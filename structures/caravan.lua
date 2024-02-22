Class = require("class")
Structure = require("structures.structure")
Collidable = require("collidable")

FishingRod = require("items.fishing_rod")
Flute = require("items.flute")
Axe = require("items.axe")
Sword = require("items.sword")
Logs = require("items.logs")

Caravan = Class {
    __includes = {Structure, Collidable},
    init = function(self, x, y)
        Structure.init(self)
        Collidable.init(self)
        self.pos = {x = x, y = y}
        self.size = {w = 128, h = 96}
        self.img = love.graphics.newImage("res/caravan.png")
        self.name = "caravan"
        self.type = "structure"
        self.is_open = false
        self.stock = {
            FishingRod(0, 0),
            Flute(0, 0),
            Axe(0, 0),
            Sword(0, 0),
            Logs(0, 0)
        }
    end,

    interact = function(self)
        self.is_open = not self.is_open
    end,
}

return Caravan