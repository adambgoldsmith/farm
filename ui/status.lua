Class = require("class")
UI = require("ui/ui")

Status = Class {
    __includes = {UI},
    init = function(self)
        UI.init(self)
        self.pos = {x = 0, y = 0}
        self.size = {w = 0, h = 0}
        self.name = "status"
        self.type = "ui"
    end,

    draw = function(self, player)
        love.graphics.print("Money: " .. player.money, self.pos.x, self.pos.y)
    end,

    attach_to_player = function(self, player)
        self.pos.x = player.pos.x + 32 * 8
        self.pos.y = player.pos.y - 288
    end
}

return Status