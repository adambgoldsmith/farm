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
        self.size = {w = 64, h = 96}
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

    click = function(self)
        if PLAYER.held_item ~= nil then
            if PLAYER.held_item.name == "axe" then
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
                PLAYER:add_item(self.produce())
                for i, tree in ipairs(CURRENT_AREA.level_objects) do
                    if tree == self then
                        table.remove(CURRENT_AREA.level_objects, i)
                    end
                end
            end
        end
    end,
}

return Tree