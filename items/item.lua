item = {}

function item:new(o, name, type)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.name = name
    self.type = type
    return o
end

function item:draw()
    love.graphics.print(self.name, self.x, self.y)
end

function item:drop(x, y)
    self.x = x
    self.y = y
end

return item
