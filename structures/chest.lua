Class = require("class")
Structure = require("structures.structure")

Tomato = require("items.tomato")

Chest = Class {
    __includes = Structure,
    init = function(self, x, y)
        Structure.init(self)
        self.name = "chest"
        self.type = "structure"
        self.pos = {x = x, y = y}
        self.size = {w = 32, h = 32}
        self.img = love.graphics.newImage("res/chest.png")
        self.is_open = false
        self.items = {
            Tomato(0, 0),
        }
        self.max_items = 6
    end,

    interact = function(self)
        self.is_open = not self.is_open
    end,
}

return Chest