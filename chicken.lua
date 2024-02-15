egg = require("items.egg")

chicken = {
    x = 0,
    y = 0,
    name = "chicken",
    type = "animal",
    sprite = love.graphics.newImage("res/missing_texture.png"),
    speed = 25,
    direction = 2,
    produce = egg
}

function chicken:new(o, x, y)
    o = o or {}
    o.x = x
    o.y = y
    o.sprite = love.graphics.newImage("res/chicken_white.png")
    setmetatable(o, self)
    self.__index = self
    return o
end

function chicken:draw()
    love.graphics.draw(self.sprite, self.x, self.y)
end

function chicken:move(dt)
    if love.timer.getTime() % (math.random(3, 8)) < dt then
        self.direction = math.random(1, 11)
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