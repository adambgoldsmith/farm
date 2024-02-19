Class = require("class")
GameObject = require("game_object")

Tile = Class {
    __includes = GameObject,
    init = function(self)
        GameObject.init(self)
        self.name = "tile"
        self.type = "tile"
    end
}

return Tile