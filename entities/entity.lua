Class = require("class")
GameObject = require("game_object")

Entity = Class {
    __includes = GameObject,
    init = function(self)
        GameObject.init(self)
        self.name = "entity"
        self.type = "entity"
        self.speed = 100
    end,

    check_collision = function(self, other)
        if self.pos.x < other.pos.x + other.size.w and
           self.pos.x + self.size.w > other.pos.x and
           self.pos.y < other.pos.y + other.size.h and
           self.pos.y + self.size.h > other.pos.y then
            return true
        end
        return false
    end
}

return Entity