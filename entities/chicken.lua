Class = require("class")
Entity = require("entities.entity")
Egg = require("items.egg")

Chicken = Class {
    __includes = Entity,
    init = function(self, x, y)
        Entity.init(self)
        self.name = "chicken"
        self.type = "entity"
        self.pos = {x = x, y = y}
        self.size = {w = 32, h = 32}
        self.speed = 25
        self.img = math.random(1, 2) == 1 and love.graphics.newImage("res/chicken_white.png") or love.graphics.newImage("res/chicken_brown.png")
        self.direction = 2
        self.produce = Egg
    end,

    draw = function(self)
        -- TODO: Fix chicken sprite flipping
        if self.direction == 2 or self.direction == 4 then
            love.graphics.draw(self.img, self.pos.x, self.pos.y)
        else
            love.graphics.draw(self.img, self.pos.x + self.size.w, self.pos.y, 0, -1, 1, self.size.w / 2, self.size.h / 2)
        end
    end,

    move = function(self, dt)
        -- TODO: Add 8-way movement
        if love.timer.getTime() % math.random(3, 4) < dt then
            self.direction = math.random(1, 4)
        end
        if self.direction == 1 then
            self.pos.y = self.pos.y - self.speed * dt
        elseif self.direction == 2 then
            self.pos.y = self.pos.y + self.speed * dt
        elseif self.direction == 3 then
            self.pos.x = self.pos.x - self.speed * dt
        elseif self.direction == 4 then
            self.pos.x = self.pos.x + self.speed * dt
        end
    end,

    ready_to_lay_egg = function(self, dt)
        return love.timer.getTime() % math.random(5, 10) < dt
    end,

    lay_egg = function(self)
        return self.produce(self.pos.x, self.pos.y)
    end


}

return Chicken

