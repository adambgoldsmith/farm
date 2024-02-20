Class = require("class")
Enemy = require("entities.enemy")

Mask = Class {
    __includes = Enemy,
    init = function(self, x, y)
        Enemy.init(self)
        self.pos = {x = x, y = y}
        self.size = {w = 32, h = 32}
        self.img = love.graphics.newImage("res/enemy_mask.png")
        self.name = "mask"
        self.type = "enemy"
        self.speed = 100
        self.health = 100
        self.damage = 10
        self.attack_range = 32
        self.attack_speed = 1
        self.attack_timer = 0
    end,
}

return Mask