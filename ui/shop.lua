Class = require("class")
UI = require("ui.ui")

Shop = Class {
    __includes = UI,
    init = function(self)
        UI.init(self)
        self.pos = {x = 0, y = 0}
        self.size = {w = 0, h = 0}
        self.name = "shop"
        self.type = "UI"
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

    draw = function(self, shop, camera)
        if shop.is_open then
            self:display_shop(shop)
            self:display_item_info(shop, camera)
        end
    end,

    display_shop = function(self, shop)
        for i, box in ipairs(self.boxes) do
            love.graphics.rectangle("line", shop.pos.x + box.x + 16, shop.pos.y + box.y - 96, 32, 32)
            love.graphics.setColor(1, 1, 1)
            if shop == i then
                love.graphics.setColor(0, 1, 0)
            end
            if shop.stock[i] ~= nil then
                love.graphics.draw(shop.stock[i].img, shop.pos.x + box.x + 16, shop.pos.y + box.y - 96)
            end
            love.graphics.setColor(1, 1, 1)
        end
    end,

    display_item_info = function(self, shop, camera)
        local x_pos, y_pos = camera:mousePosition()
        local box = self:find_box(x_pos, y_pos, shop)
        if box ~= nil then
            if shop.stock[box] ~= nil then
                love.mouse.setVisible(false)
                love.graphics.draw(self.item_info_box, x_pos, y_pos)
                love.graphics.setColor(0, 0, 0)
                love.graphics.print(shop.stock[box].name, x_pos + 48, y_pos + 16)
                love.graphics.print(shop.stock[box].price, x_pos + 48, y_pos + 32)
                love.graphics.setColor(1, 1, 1)
                love.graphics.draw(shop.stock[box].img, x_pos + 8, y_pos + 8)
            else
                love.mouse.setVisible(true)
            end
        end
    end,

    find_box = function(self, x, y, shop)
        for i, box in ipairs(self.boxes) do
            if x > shop.pos.x + box.x + 16 and x < shop.pos.x + box.x + 48 and y > shop.pos.y + box.y - 96 and y < shop.pos.y + box.y - 64 then
                return i
            end
        end
        return nil
    end,

    buy_item = function(self, player, shop, camera)
        if shop.is_open then
            local x_pos, y_pos = camera:mousePosition()
            print(x_pos, y_pos)
            local box = self:find_box(x_pos, y_pos, shop)
            if box ~= nil then
                print(shop.stock[box])
                if shop.stock[box] ~= nil then
                    if player.money >= shop.stock[box].price then
                        if player:add_item(shop.stock[box]) then
                            player.money = player.money - shop.stock[box].price
                            shop.stock[box] = nil
                        end
                    end
                end
            end
        end
    end,
}

return Shop