Class = require("class")
GameObject = require("game_object")

Entity = Class {
    __includes = GameObject,
    init = function(self)
        GameObject.init(self)
        self.name = "entity"
        self.type = "entity"
        self.speed = 100
    end,

    check_collision = function(self, other)
        if self.pos.x+1 < other.pos.x+1 + other.size.w+1 and
           self.pos.x+1 + self.size.w+1 > other.pos.x+1 and
           self.pos.y+1 < other.pos.y+1 + other.size.h+1 and
           self.pos.y+1 + self.size.h+1 > other.pos.y+1 then
            return true
        end
        return false
    end,

    collide = function(self, other)
        local xOverlap = math.max(0, math.min(self.pos.x + self.size.w, other.pos.x + other.size.w) - math.max(self.pos.x, other.pos.x))
        local yOverlap = math.max(0, math.min(self.pos.y + self.size.h, other.pos.y + other.size.h) - math.max(self.pos.y, other.pos.y))
    
        if xOverlap > 0 and yOverlap > 0 then
            if xOverlap < yOverlap then
                -- Horizontal collision
                if self.pos.x + self.size.w / 2 < other.pos.x + other.size.w / 2 then
                    -- Colliding on the left side
                    self.pos.x = other.pos.x - self.size.w
                else
                    -- Colliding on the right side
                    self.pos.x = other.pos.x + other.size.w
                end
                self.pos.x_vel = 0
            else
                -- Vertical collision
                if self.pos.y + self.size.h / 2 < other.pos.y + other.size.h / 2 then
                    -- Colliding on the top
                    self.pos.y = other.pos.y - self.size.h
                    self.airborne = false
                    self.pos.y_vel = 0
                else
                    -- Colliding on the bottom
                    self.pos.y = other.pos.y + other.size.h
                    self.pos.y_vel = 0
                end
            end
        end
    end
}

return Entity