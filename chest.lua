chest = {
    x = 0,
    y = 0,
    name = "chest",
    type = "structure",
    sprite = love.graphics.newImage("res/missing_texture.png")
}

function chest:new(o, x, y)
    o = o or {}
    o.x = x
    o.y = y
    o.sprite = love.graphics.newImage("res/chest.png")
    o.items = {}
    o.max_items = 9
    setmetatable(o, self)
    self.__index = self
    return o
end

function chest:draw()
    self.sprite:setFilter("nearest", "nearest")
    love.graphics.draw(self.sprite, self.x, self.y)
end

function chest:add_item(item)
    if #self.items < self.max_items then
        table.insert(self.items, item)
    end
end

function chest:remove_item(item)
    for i, v in ipairs(self.items) do
        if v == item then
            table.remove(self.items, i)
            break
        end
    end
end

return chest