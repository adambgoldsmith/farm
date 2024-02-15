item = {}

function item:new(o, name, type)
    o = o or {}
    o.name = name
    o.type = type
    o.sprite = love.graphics.newImage("res/missing_texture.png")
    setmetatable(o, self)
    self.__index = self
    return o
end

function item:draw()
    love.graphics.draw(self.sprite, self.x, self.y)
end

function item:float()
    
    self.y = self.y + math.sin(love.timer.getTime() * 2) * 0.1
end

function item:drop(x, y)
    self.x = x
    self.y = y
end

return item
