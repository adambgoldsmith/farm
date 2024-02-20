Class = require("class")
GameObject = require("game_object")
Logs = require("items.logs")

Tree = Class {
    __includes = GameObject,
    init = function(self, x, y)
        GameObject.init(self)
        self.name = "tree"
        self.type = "tree"
        self.pos = {x = x, y = y}
        self.size = {w = 32, h = 32}
        self.img = love.graphics.newImage("res/tree.png")
        self.produce = Logs
        self.hits = 0
        self.max_hits = 6
        self.hit_cooldown = 0
        self.hit_cooldown_max = 1
    end,

    draw = function(self)
        self.img:setFilter("nearest", "nearest")
        love.graphics.draw(self.img, self.pos.x, self.pos.y)
    end,

    update = function(self, dt)
        self:cooldown(dt)
    end,

    interact = function(self, player)
        if player.held_item ~= nil then
            if player.held_item.name == "axe" then
                return self.hit(self)
            end
        end
    end,

    cooldown = function(self, dt)
        if self.hit_cooldown > 0 then
            self.hit_cooldown = self.hit_cooldown - dt
        end
    end,

    hit = function(self)
        if self.hit_cooldown <= 0 then
            self.hits = self.hits + 1
            self.hit_cooldown = self.hit_cooldown_max
            if self.hits >= self.max_hits then
                self.hits = 0
                return self.produce(self.pos.x, self.pos.y)
            end
        end
    end,
}

return Tree