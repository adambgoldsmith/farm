Class = require("class")
Structure = require("structures.structure")

House = Class {
    __includes = Structure,
    init = function(self, x, y)
        Structure.init(self)
        self.pos = {x = x, y = y}
        self.size = {w = 256, h = 192}
        self.img = love.graphics.newImage("res/house.png")
        self.name = "house"
        self.type = "structure"
    end
}

return House