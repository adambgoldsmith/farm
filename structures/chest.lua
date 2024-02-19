Class = require("class")
Structure = require("structures.structure")

Chest = Class {
    __includes = Structure,
    init = function(self, x, y)
        Structure.init(self)
        self.name = "chest"
        self.type = "structure"
        self.pos = {x = x, y = y}
        self.size = {w = 32, h = 32}
        self.img = love.graphics.newImage("res/chest.png")
    end
}

return Chest