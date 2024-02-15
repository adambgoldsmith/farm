entity = require("entities.entity")
egg = require("items.egg")

chicken = entity:new()

function chicken:new(o, x, y)
    o = o or entity:new(o, x, y)
    o.x = x
    o.y = y
    o.name = "chicken"
    o.type = "animal"
    o.sprite = love.graphics.newImage("res/chicken_white.png")
    o.speed = 25
    o.direction = 2
    o.produce = egg
    setmetatable(o, self)
    self.__index = self
    return o
end

function chicken:draw()
    local flip = 1
    if self.direction == 3 or self.direction == 5 or self.direction == 7  or self.direction == 9 or self.direction == 11 then
        flip = -1
    else
        flip = 1
    end
    love.graphics.draw(self.sprite, self.x, self.y, 0, flip, 1, 16, 16)
end

function chicken:move(dt)
    if love.timer.getTime() % (math.random(3, 3)) < dt then
        self.direction = math.random(1, 12)
    end
    if self.direction == 1 then
        self.y = self.y - self.speed * dt
    end
    if self.direction == 2 then
        self.y = self.y + self.speed * dt
    end
    if self.direction == 3 then
        self.x = self.x - self.speed * dt
    end
    if self.direction == 4 then
        self.x = self.x + self.speed * dt
    end
    if self.direction == 5 then
        self.x = self.x - self.speed * dt
        self.y = self.y - self.speed * dt
    end
    if self.direction == 6 then
        self.x = self.x + self.speed * dt
        self.y = self.y - self.speed * dt
    end
    if self.direction == 7 then
        self.x = self.x - self.speed * dt
        self.y = self.y + self.speed * dt
    end
    if self.direction == 8 then
        self.x = self.x + self.speed * dt
        self.y = self.y + self.speed * dt
    end
end

function chicken:lay_egg(dt)
    if love.timer.getTime() % (math.random(10, 12)) < dt then
        return true
    end
    return false
end

return chicken