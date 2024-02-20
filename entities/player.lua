Class = require("class")
GameObject = require("game_object")
Entity = require("entities.entity")

Player = Class {
    __includes = {Entity, GameObject},
    init = function(self, x, y)
        Entity.init(self)
        self.pos = {x = x, y = y}
        self.size = {w = 32, h = 32}
        self.img = love.graphics.newImage("res/char_32x32.png")
        self.name = "player"
        self.type = "entity"
        self.speed = 150
        self.direction = 1
        self.health = 100
        self.max_health = 100
        self.inventory_size = 12
        self.inventory = {}
        self.hotbar_size = 5
        self.held_item = "nothing"
        self.held_item_index = 1
        self.money = 100
    end,

    draw = function(self)
        if self.direction == 1 then
            love.graphics.draw(self.img, self.pos.x, self.pos.y)
        else
            love.graphics.draw(self.img, self.pos.x + self.size.w, self.pos.y, 0, -1, 1)
        end
    end,

    move = function(self, dt)
        local dx = 0
        local dy = 0
        if love.keyboard.isDown("w") then
            dy = dy - 1
        end
        if love.keyboard.isDown("s") then
            dy = dy + 1
        end
        if love.keyboard.isDown("a") then
            dx = dx - 1
            self.direction = -1
        end
        if love.keyboard.isDown("d") then
            dx = dx + 1
            self.direction = 1
        end
        if dx ~= 0 and dy ~= 0 then
            dx = dx * 0.7071
            dy = dy * 0.7071
        end
        self.pos.x = self.pos.x + dx * self.speed * dt
        self.pos.y = self.pos.y + dy * self.speed * dt
    end,

    add_item = function(self, item)
        for i = 1, self.inventory_size do
            if self.inventory[i] == nil then
                self.inventory[i] = item
                return true
            end
        end
        return false
    end,

    delete_item = function(self)
        self.inventory[self.held_item_index] = nil
        self.held_item = nil
    end,

    drop_item = function(self)
        if self.held_item ~= nil then
            local item = self.held_item
            self:delete_item()
            return item
        end
    end,

    select_item = function(self)
        if love.keyboard.isDown("1") then
            self.held_item_index = 1
        elseif love.keyboard.isDown("2") then
            self.held_item_index = 2
        elseif love.keyboard.isDown("3") then
            self.held_item_index = 3
        elseif love.keyboard.isDown("4") then
            self.held_item_index = 4
        elseif love.keyboard.isDown("5") then
            self.held_item_index = 5
        end
        self.held_item = self.inventory[self.held_item_index]
    end,

    select_item_mouse_wheel = function(self, y)
        if y > 0 then
            self.held_item_index = self.held_item_index + 1
        elseif y < 0 then
            self.held_item_index = self.held_item_index - 1
        end
        if self.held_item_index > self.hotbar_size then
            self.held_item_index = 1
        elseif self.held_item_index < 1 then
            self.held_item_index = self.hotbar_size
        end
        self.held_item = self.inventory[self.held_item_index]
    end,

    interact = function(self, other)
        if self:check_collision(other) then
            print("Interacting with " .. other.name)
        end
    end,

    heal = function(self, health)
        self.health = self.health + health
        if self.health > self.max_health then
            self.health = self.max_health
        end
    end,

    take_damage = function(self, damage)
        self.health = self.health - damage
    end,
}

return Player