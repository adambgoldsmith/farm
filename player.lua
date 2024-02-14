player = {
    x = 0,
    y = 0,
    speed = 100,
    held_item = nil,
    held_item_index = 1,
    inventory_size = 5,
    inventory = {
        "hoe",
        "watering can",
    },
}

function player:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function player:draw()
    love.graphics.rectangle("fill", self.x, self.y, 32, 32)
end

function player:move(dt)
    if love.keyboard.isDown("up") then
        self.y = self.y - self.speed * dt
    end
    if love.keyboard.isDown("down") then
        self.y = self.y + self.speed * dt
    end
    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
    end
    if love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
    end
end

function player:check_tile(tile)
    if self.x < tile.x + 32 and
        self.x + 32 > tile.x and
        self.y < tile.y + 32 and
        self.y + 32 > tile.y then
        return true
    end
    return false
end

function player:check_ground_item(item)
    if self.x < item.x + 32 and
        self.x + 32 > item.x and
        self.y < item.y + 32 and
        self.y + 32 > item.y then
        return true
    end
    return false
end

function player:add_item(item)
    if #self.inventory < self.inventory_size then
        table.insert(self.inventory, item)
    end
end

function player:drop_item()
    if love.keyboard.isDown("q") and type(self.held_item) == "table" then
        return true
    end
    return false
end

function player:select_item()
    if love.keyboard.isDown("1") then
        self.held_item = self.inventory[1]
        self.held_item_index = 1
    end
    if love.keyboard.isDown("2") then
        self.held_item = self.inventory[2]
        self.held_item_index = 2
    end
    if love.keyboard.isDown("3") then
        self.held_item = self.inventory[3]
        self.held_item_index = 3
    end
    if love.keyboard.isDown("4") then
        self.held_item = self.inventory[4]
        self.held_item_index = 4
    end
    if love.keyboard.isDown("5") then
        self.held_item = self.inventory[5]
        self.held_item_index = 5
    end
end

function player:use_item()
    if love.keyboard.isDown("space") then
        return true
    end
    return false
end

return player
