item = {}

function item:new(o, name, type)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.name = name
    self.type = type
    self.sprite = love.graphics.newImage("res/missing_texture.png")
    return o
end

function item:draw()
    love.graphics.draw(self.sprite, self.x, self.y)
end

function item:drop(x, y)
    self.x = x
    self.y = y
end

return item
