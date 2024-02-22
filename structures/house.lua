Class = require("class")
Structure = require("structures.structure")
Collidable = require("collidable")

House = Class {
    __includes = {Structure, Collidable},
    init = function(self, x, y)
        Structure.init(self)
        Collidable.init(self)
        self.pos = {x = x, y = y}
        self.size = {w = 96, h = 96}
        self.img = love.graphics.newImage("res/cabin.png")
        self.name = "house"
        self.type = "structure"
    end,

    interact = function(self)
        CURRENT_AREA = PLAYER_HOUSE
    end
}

return House