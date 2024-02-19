Class = require("class")
GameObject = require("game_object")

Item = Class {
    __includes = GameObject,
    init = function(self)
        GameObject.init(self)
        self.name = "item"
        self.type = "item"
        self.img = love.graphics.newImage("res/missing_texture.png")
        self.price = 10
    end,

    bob = function(self)
        self.pos.y = self.pos.y + math.sin(love.timer.getTime() * 2) * 0.1
    end,

    update_pos = function(self, pos)
        self.pos.x = pos.x
        self.pos.y = pos.y
    end,
}

return Item