entity = require("entities.entity")

player = entity:new()

function player:new(o, x, y)
    o = o or entity:new(o, x, y)
    o.x = x
    o.y = y
    o.name = "player"
    o.type = "player"
    o.sprite = love.graphics.newImage("res/char_32x32.png")
    o.speed = 150
    o.direction = 1
    o.inventory_size = 5
    o.inventory = {"nothing", "nothing", "nothing", "nothing", "nothing"}
    o.held_item = nil
    o.held_item_index = 1
    o.money = 0
    setmetatable(o, self)
    self.__index = self
    return o
end

function player:draw()
    self.sprite:setFilter("nearest", "nearest")
    if self.direction == 1 then
        love.graphics.draw(self.sprite, self.x, self.y, 0, 2, 2, 0, 0)
    else
        love.graphics.draw(self.sprite, self.x + 32, self.y, 0, -2, 2, 0, 0)
    end
end

function player:move(dt)
    if love.keyboard.isDown("w") then
        self.y = self.y - self.speed * dt
    end
    if love.keyboard.isDown("s") then
        self.y = self.y + self.speed * dt
    end
    if love.keyboard.isDown("a") then
        self.x = self.x - self.speed * dt
        self.direction = -1
    end
    if love.keyboard.isDown("d") then
        self.x = self.x + self.speed * dt
        self.direction = 1
    end
end

function player:check_ground_item(item)
    if self.x < item.x + 32 and
        self.x + 32 > item.x and
        self.y < item.y + 32 and
        self.y + 32 > item.y then
        return true
    end
    return false
end

function player:add_item(item)
    for i = 1, self.inventory_size do
        if self.inventory[i] == "nothing" then
            self.inventory[i] = item
            return true
        end
    end
    return false
end

function player:drop_item()
    if love.keyboard.isDown("q") and type(self.held_item) == "table" then
        return true
    end
    return false
end

function player:delete_item()
    self.inventory[self.held_item_index] = "nothing"
    self.held_item = "nothing"
end

function player:select_item()
    if love.keyboard.isDown("1") then
        self.held_item = self.inventory[1]
        self.held_item_index = 1
    end
    if love.keyboard.isDown("2") then
        self.held_item = self.inventory[2]
        self.held_item_index = 2
    end
    if love.keyboard.isDown("3") then
        self.held_item = self.inventory[3]
        self.held_item_index = 3
    end
    if love.keyboard.isDown("4") then
        self.held_item = self.inventory[4]
        self.held_item_index = 4
    end
    if love.keyboard.isDown("5") then
        self.held_item = self.inventory[5]
        self.held_item_index = 5
    end
end

function player:select_item_scrolling(y)
    if y > 0 then
        self.held_item_index = self.held_item_index + 1
        if self.held_item_index > self.inventory_size then
            self.held_item_index = 1
        end
    elseif y < 0 then
        self.held_item_index = self.held_item_index - 1
        if self.held_item_index < 1 then
            self.held_item_index = self.inventory_size
        end
    end
    self.held_item = self.inventory[self.held_item_index]
end

function player:use_item()
    if love.keyboard.isDown("space") then
        return true
    end
    return false
end

function player:money_change(amount)
    self.money = self.money + amount
end

return player
