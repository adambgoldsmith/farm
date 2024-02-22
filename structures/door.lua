Class = require("class")
Structure = require("structures.structure")

Door = Class {
    __includes = Structure,
    init = function(self, x, y, destination)
        Structure.init(self)
        self.pos = {x = x, y = y}
        self.size = {w = 32, h = 32}
        self.name = "door"
        self.type = "structure"
        self.img = love.graphics.newImage("res/cabin_door.png")
        self.destination = destination
    end,

    interact = function(self)
        self:enter()
    end,

    enter = function(self)
        CURRENT_AREA = self.destination
    end
}

return Door