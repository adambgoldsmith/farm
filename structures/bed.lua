Class = require("class")
Structure = require("structures.structure")
Collidable = require("collidable")

Bed = Class {
    __includes = {Structure, Collidable},
    init = function(self, x, y)
        Structure.init(self)
        Collidable.init(self)
        self.pos = {x = x, y = y}
        self.size = {w = 32, h = 32}
        self.name = "bed"
        self.type = "structure"
        self.img = love.graphics.newImage("res/bed.png")
    end,

    interact = function(self)
        self:sleep()
    end,

    sleep = function(self)
        print("You slept in the bed")
    end
}

return Bed