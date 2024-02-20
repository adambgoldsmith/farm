Class = require("class")

GameObject = Class {
    init = function(self)
        self.pos = {x = 0, y = 0}
        self.size = {w = 32, h = 32}
        self.img = love.graphics.newImage("res/missing_texture.png")
        self.name = "GameObject"
        self.type = "GameObject"
    end,

    draw = function(self)
        love.graphics.draw(self.img, self.pos.x, self.pos.y)
    end,

    update = function(self, dt)
    end
}

return GameObject