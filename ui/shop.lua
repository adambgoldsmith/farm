Class = require("class")
UI = require("ui.ui")

Shop = Class {
    __includes = UI,
    init = function(self, shop)
        UI.init(self)
        self.pos = {x = 0, y = 0}
        self.size = {w = 0, h = 0}
        self.name = "shop"
        self.type = "UI"
        self.shop = shop
        self.item_info_box = love.graphics.newImage("res/shop_item_info.png")
        self.boxes = {
            {x = 0, y = 0},
            {x = 32, y = 0},
            {x = 64, y = 0},
            {x = 0, y = 32},
            {x = 32, y = 32},
            {x = 64, y = 32},
            {x = 0, y = 64},
            {x = 32, y = 64},
            {x = 64, y = 64}
        }
    end,

    draw = function(self)
        if self.shop.is_open then
            self:display_shop(self.shop)
            self:display_item_info(self.shop)
        end
    end,

    display_shop = function(self)
        for i, box in ipairs(self.boxes) do
            love.graphics.rectangle("line", self.shop.pos.x + box.x + 16, self.shop.pos.y + box.y - 96, 32, 32)
            love.graphics.setColor(1, 1, 1)
            if self.shop == i then
                love.graphics.setColor(0, 1, 0)
            end
            if self.shop.stock[i] ~= nil then
                love.graphics.draw(self.shop.stock[i].img, self.shop.pos.x + box.x + 16, self.shop.pos.y + box.y - 96)
            end
            love.graphics.setColor(1, 1, 1)
        end
    end,

    display_item_info = function(self)
        local x_pos, y_pos = CAMERA:mousePosition()
        local box = self:find_box(x_pos, y_pos, self.shop)
        if box ~= nil then
            if self.shop.stock[box] ~= nil then
                love.mouse.setVisible(false)
                love.graphics.draw(self.item_info_box, x_pos, y_pos)
                love.graphics.setColor(0, 0, 0)
                love.graphics.print(self.shop.stock[box].name, x_pos + 48, y_pos + 16)
                love.graphics.print(self.shop.stock[box].price, x_pos + 48, y_pos + 32)
                love.graphics.setColor(1, 1, 1)
                love.graphics.draw(self.shop.stock[box].img, x_pos + 8, y_pos + 8)
            else
                love.mouse.setVisible(true)
            end
        end
    end,

    find_box = function(self, x, y)
        for i, box in ipairs(self.boxes) do
            if x > self.shop.pos.x + box.x + 16 and x < self.shop.pos.x + box.x + 48 and y > self.shop.pos.y + box.y - 96 and y < self.shop.pos.y + box.y - 64 then
                return i
            end
        end
        return nil
    end,

    buy_item = function(self, player)
        if self.shop.is_open then
            local x_pos, y_pos = CAMERA:mousePosition()
            print(x_pos, y_pos)
            local box = self:find_box(x_pos, y_pos, self.shop)
            if box ~= nil then
                print(self.shop.stock[box])
                if self.shop.stock[box] ~= nil then
                    if player.money >= self.shop.stock[box].price then
                        if player:add_item(self.shop.stock[box]) then
                            player.money = player.money - self.shop.stock[box].price
                            self.shop.stock[box] = nil
                        end
                    end
                end
            end
        end
    end,
}

return Shop