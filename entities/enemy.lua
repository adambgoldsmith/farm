Class = require("class")
Entity = require("entities.entity")

Enemy = Class {
    __includes = Entity,
    init = function(self)
        Entity.init(self)
        self.name = "enemy"
        self.type = "enemy"
        self.speed = 100
        self.health = 100
        self.damage = 10
        self.attack_range = 32
        self.attack_speed = 1
        self.attack_timer = 0
        self.target = nil
    end,

    -- Original wander method. Saving for a special occasion.
    -- sicko_mode = function(self, dt)
    --     self.pos.x = self.pos.x + (math.random(0, 1) * 2 - 1) * self.speed * dt
    --     self.pos.y = self.pos.y + (math.random(0, 1) * 2 - 1) * self.speed * dt
    -- end,

    chase_target = function(self, dt)
        if self.target then
            local dx = self.target.pos.x - self.pos.x
            local dy = self.target.pos.y - self.pos.y
            local distance = math.sqrt(dx * dx + dy * dy)
            if distance < self.attack_range then
                self:attack(self.target, dt)
            else
                self.pos.x = self.pos.x + dx / distance * self.speed * dt
                self.pos.y = self.pos.y + dy / distance * self.speed * dt
            end
        end
    end,

    attack = function(self, target, dt)
        self.attack_timer = self.attack_timer + dt
        if self.attack_timer > self.attack_speed then
            target:take_damage(self.damage)
            self.attack_timer = 0
        end
    end,

    take_damage = function(self, damage)
        self.health = self.health - damage
        if self.health <= 0 then
            self:die()
        end
    end,

    die = function(self)
        self.pos.x = -100
        self.pos.y = -100
    end,

    scan_for_target = function(self, player)
        local dx = player.pos.x - self.pos.x
        local dy = player.pos.y - self.pos.y
        local distance = math.sqrt(dx * dx + dy * dy)
        if distance < 200 then
            self:set_target(player)
        end
    end,

    set_target = function(self, target)
        self.target = target
    end,

    lose_target = function(self)
        if self.target then
            local dx = self.target.pos.x - self.pos.x
            local dy = self.target.pos.y - self.pos.y
            local distance = math.sqrt(dx * dx + dy * dy)
            if distance > 200 then
                self.target = nil
            end
        end
    end,

    update = function(self, dt, player)
        self:scan_for_target(player)
        self:chase_target(dt)
        self:lose_target()
    end
}

return Enemy