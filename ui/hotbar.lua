hotbar = {
    x = 0,
    y = 0,
    name = "hotbar",
    type = "ui",
}

function hotbar:new(o, x, y)
    o = o or {}
    o.x = x
    o.y = y
    setmetatable(o, self)
    self.__index = self
    return o
end

function hotbar:draw(player)
    self:display_hotbar(player)
end

function hotbar:display_hotbar(player)
    for i = 1, player.inventory_size do
        if i == player.held_item_index then
            love.graphics.rectangle("fill", self.x + (i - 1) * 32, self.y, 32, 32)
        else
            love.graphics.rectangle("line", self.x + (i - 1) * 32, self.y, 32, 32)
        end
        if player.inventory[i] ~= "nothing" then
            love.graphics.draw(player.inventory[i].sprite, self.x + (i - 1) * 32, self.y)
        end
    end
end

function hotbar:attach_to_player(player)
    self.x = player.x - 64
    self.y = player.y - 256 - 32
end

return hotbar