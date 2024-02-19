Class = require("class")
GameObject = require("game_object")

Structure = Class {
    __includes = GameObject,
    init = function(self)
        GameObject.init(self)
        self.name = "structure"
        self.type = "structure"
    end
}

return Structure