status = {
    x = 0,
    y = 0,
    name = "status",
    type = "ui",
}

function status:new(o, x, y)
    o = o or {}
    o.x = x
    o.y = y
    setmetatable(o, self)
    self.__index = self
    return o
end

function status:draw(player)
    self:display_status(player)
end

function status:display_status(player)
    -- love.graphics.print("Health: " .. player.health, self.x, self.y)
    -- love.graphics.print("Hunger: " .. player.hunger, self.x, self.y + 16)
    -- love.graphics.print("Thirst: " .. player.thirst, self.x, self.y + 32)
    love.graphics.print("$" .. player.money, self.x, self.y)
end

function status:attach_to_player(player)
    self.x = player.x + 256 + 64
    self.y = player.y - 256 - 32
end

return status