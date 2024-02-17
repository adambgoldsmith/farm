shop = {
    x = 0,
    y = 0,
    name = "shop",
    type = "ui",
}

function shop:new(o, x, y)
    o = o or {}
    o.x = x
    o.y = y
    o.name = "shop"
    o.type = "ui"
    o.is_open = false
    o.boxes = {
        {x = 0, y = 0},
        {x = 32, y = 0},
        {x = 64, y = 0},
        {x = 0, y = 32},
        {x = 32, y = 32},
        {x = 64, y = 32},
        {x = 0, y = 64},
        {x = 32, y = 64},
        {x = 64, y = 64},
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

function shop:draw(selected_shop)
    if self.is_open then
        self:display_shop(selected_shop)
        Selected = self:check_mouse_position(cam)
        self:display_item_info(Caravan, Selected, cam)
    end
end

function shop:display_shop(selected_shop)
    for i, box in ipairs(self.boxes) do
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.rectangle("fill", self.x + box.x, self.y + box.y, 32, 32)
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("line", self.x + box.x, self.y + box.y, 32, 32)
        love.graphics.setColor(1, 1, 1)
        if selected_shop == i then
            love.graphics.setColor(0, 1, 0)
        end
        if selected_shop.items[i] ~= "nothing" then
            love.graphics.draw(selected_shop.items[i]:new().sprite, self.x + box.x, self.y + box.y)
        end
        love.graphics.setColor(1, 1, 1)
    end
end

function shop:display_item_info(selected_shop, selected_item, cam)
    local x_pos, y_pos = cam:mousePosition()
    if selected_item ~= 0 and selected_shop.items[selected_item] ~= "nothing" then
        love.mouse.setVisible(false)
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.rectangle("fill", x_pos, y_pos, 128, 64)
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("line", x_pos, y_pos, 128, 64)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(selected_shop.items[selected_item]:new().name, x_pos + 4, y_pos + 4)
        love.graphics.print(selected_shop.items[selected_item]:new().price, x_pos + 4, y_pos + 24)
        love.graphics.setColor(1, 1, 1)
    else    
        love.mouse.setVisible(true)
    end
end


function shop:check_mouse_position(cam)
    local x_pos, y_pos = cam:mousePosition()
    for i, box in ipairs(self.boxes) do
        if x_pos > self.x + box.x and x_pos < self.x + box.x + 32 and y_pos > self.y + box.y and y_pos < self.y + box.y + 32 then
            return i
        end
    end
    return 0
end

function shop:buy_item(player, item)
    if item == "nothing" then
        return
    end
    if player.money >= item.price then
        if player:add_item(item:new()) then
            player.money = player.money - item.price
        else
            print("not enough space in inventory")
        end
    else
        print("not enough money")
    end
end

function shop:set_is_open()
    self.is_open = not self.is_open
end

function shop:attach_to_shop(selected_shop)
    self.x = selected_shop.x + 16
    self.y = selected_shop.y - 96
end

return shop

