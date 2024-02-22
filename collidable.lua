Class = require("class")
GameObject = require("game_object")

Collidable = Class {
    __includes = GameObject,
    init = function(self)
        GameObject.init(self)
        self.type = "collidable"
        self.collidable = true
    end
}

return Collidable