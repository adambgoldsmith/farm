entity = {
    x = 0,
    y = 0,
    name = "entity",
    type = "entity",
    sprite = love.graphics.newImage("res/missing_texture.png")
}

function entity:new(o, x, y)
    o = o or {}
    o.x = x
    o.y = y
    setmetatable(o, self)
    self.__index = self
    return o
end

function entity:draw()
    love.graphics.draw(self.sprite, self.x, self.y)
end

function entity:check_tile(tile)
    if self.x < tile.x + 32 and
        self.x + 32 > tile.x and
        self.y < tile.y + 32 and
        self.y + 32 > tile.y then
        return true
    end
    return false
end

function entity:tile_collision(tile)
    local xOverlap = math.max(0, math.min(self.x + 32, tile.x + 32) - math.max(self.x, tile.x))
    local yOverlap = math.max(0, math.min(self.y + 32, tile.y + 32) - math.max(self.y, tile.y))

    if xOverlap > yOverlap then
        if self.y < tile.y then
            self.y = self.y - yOverlap
        else
            self.y = self.y + yOverlap
        end
    else
        if self.x < tile.x then
            self.x = self.x - xOverlap
        else
            self.x = self.x + xOverlap
        end
    end 
end

return entity