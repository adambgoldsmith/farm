Class = require("class")
UI = require("ui/ui")

Inventory = Class {
    __includes = {UI},
    init = function(self)
        UI.init(self)
        self.pos = {x = 0, y = 0}
        self.size = {w = 0, h = 0}
        self.name = "inventory"
        self.type = "ui"
        self.visible = false
        self.y_offset = 288
        self.y_offset_max = 288
        self.sliding = false
        self.slide_speed = 75
        self.selection_one = nil
        self.selection_two = nil
    end,

    draw = function(self, player, camera)
        for i = 1, player.hotbar_size do
            if i == player.held_item_index then
                love.graphics.setColor(1, 0, 0)
                love.graphics.rectangle("line", self.pos.x + 32 * (i - 1), self.pos.y, 32, 32)
                love.graphics.setColor(1, 1, 1)
            else
                love.graphics.rectangle("line", self.pos.x + 32 * (i - 1), self.pos.y, 32, 32)
            end
            if player.inventory[i] ~= nil then
                if self.selection_one == i or self.selection_two == i then
                    love.graphics.draw(player.inventory[i].img, camera:mousePosition())
                else
                    love.graphics.draw(player.inventory[i].img, self.pos.x + 32 * (i - 1), self.pos.y)
                end
            end
        end
        for i = 1, player.inventory_size - player.hotbar_size do
            if player.inventory[i + player.hotbar_size] ~= nil then
                if self.selection_one == i + player.hotbar_size or self.selection_two == i + player.hotbar_size then
                    love.graphics.draw(player.inventory[i + player.hotbar_size].img, camera:mousePosition())
                else
                    love.graphics.draw(player.inventory[i + player.hotbar_size].img, self.pos.x + 32 * (i - 1) - 32, self.pos.y - 42)
                end
            end
        end
    end,

    slide = function(self, dt)
        if not self.visible then
            if self.sliding then
                if self.y_offset < self.y_offset_max then
                    self.y_offset = self.y_offset + self.slide_speed * dt
                else
                    self.sliding = false
                    self.selection_one = nil
                    self.selection_two = nil
                end
            end
        else
            if self.sliding then
                if self.y_offset > self.y_offset_max - 32 then
                    self.y_offset = self.y_offset - self.slide_speed * dt
                else
                    self.sliding = false
                    self.selection_one = nil
                    self.selection_two = nil
                end
            end
        end
    end,

    toggle_visibility = function(self)
        self.visible = not self.visible
        self.sliding = true
    end,

    attach_to_player = function(self, player)
        self.pos.x = player.pos.x - 32 * player.hotbar_size / 2
        self.pos.y = player.pos.y - self.y_offset
    end,

    -- Second item should be able to be nil
    select_item = function(self, player, camera)
        if self.visible then
            local x_pos, y_pos = camera:mousePosition()
            for i = 1, player.hotbar_size do
                if player.inventory[i] ~= nil then
                    if x_pos > self.pos.x + 32 * (i - 1) and x_pos < self.pos.x + 32 * i and y_pos > self.pos.y and y_pos < self.pos.y + 32 then
                        if self.selection_one == nil then
                            self.selection_one = i
                        else
                            self.selection_two = i
                            self:swap_items(player)
                        end
                    end
                end
            end
            for i = 1, player.inventory_size - player.hotbar_size do
                if player.inventory[i + player.hotbar_size] ~= nil then
                    if x_pos > self.pos.x + 32 * (i - 1) - 32 and x_pos < self.pos.x + 32 * i - 32 and y_pos > self.pos.y - 42 and y_pos < self.pos.y - 10 then
                        if self.selection_one == nil then
                            self.selection_one = i + player.hotbar_size
                        else
                            self.selection_two = i + player.hotbar_size
                            self:swap_items(player)
                        end
                    end
                end
            end
        end
    end,

    release_item = function(self)
        if self.visible then
            self.selection_one = nil
            self.selection_two = nil
        end
    end,

    swap_items = function(self, player)
        if self.selection_one ~= nil and self.selection_two ~= nil then
            local temp = player.inventory[self.selection_one]
            player.inventory[self.selection_one] = player.inventory[self.selection_two]
            player.inventory[self.selection_two] = temp
            self.selection_one = nil
            self.selection_two = nil
        end
    end
}

return Inventory