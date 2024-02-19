Class = require("class")
Structure = require("structures.structure")

Fence = Class {
    __includes = Structure,
    init = function(self, x, y)
        Structure.init(self)
        self.pos = {x = x, y = y}
        self.size = {w = 32, h = 32}
        self.img = love.graphics.newImage("res/fence_front.png")
        self.name = "fence"
        self.type = "structure"
    end
}

return Fence