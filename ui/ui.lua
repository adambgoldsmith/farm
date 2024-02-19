Class = require("class")
GameObject = require("game_object")

UI = Class {
    __includes = {GameObject},
    init = function(self)
        GameObject.init(self)
        self.name = "ui"
        self.type = "ui"
    end
}

return UI