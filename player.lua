player = {
    x = 0,
    y = 0,
    speed = 100,
    inventory_size = 5,
    inventory = {"nothing", "nothing", "nothing", "nothing", "nothing"},
    held_item = nil,
    held_item_index = 1,
}

function player:new(o)
    o = o or {}
    self.held_item = self.inventory[1]
    setmetatable(o, self)
    self.__index = self
    return o
end

function player:draw()
    love.graphics.rectangle("fill", self.x, self.y, 32, 32)

    self:display_inventory()
end

function player:move(dt)
    if love.keyboard.isDown("w") then
        self.y = self.y - self.speed * dt
    end
    if love.keyboard.isDown("s") then
        self.y = self.y + self.speed * dt
    end
    if love.keyboard.isDown("a") then
        self.x = self.x - self.speed * dt
    end
    if love.keyboard.isDown("d") then
        self.x = self.x + self.speed * dt
    end
end

-- combine with check_ground_item
function player:check_tile(tile)
    if self.x < tile.x + 32 and
        self.x + 32 > tile.x and
        self.y < tile.y + 32 and
        self.y + 32 > tile.y then
        return true
    end
    return false
end

function player:tile_collision(tile)
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

function player:check_ground_item(item)
    if self.x < item.x + 32 and
        self.x + 32 > item.x and
        self.y < item.y + 32 and
        self.y + 32 > item.y then
        return true
    end
    return false
end

function player:display_inventory()
    for i = 1, self.inventory_size do
        if i == self.held_item_index then
            love.graphics.rectangle("fill", 256 + (i - 1) * 32, 32, 32, 32)
        else
            love.graphics.rectangle("line", 256 + (i - 1) * 32, 32, 32, 32)
        end
        if type(Player.inventory[i]) == "table" then
            love.graphics.draw(Player.inventory[i].sprite, 256 + (i - 1) * 32, 32)
        else
            love.graphics.print(Player.inventory[i], 256 + (i - 1) * 32, 32)
        end
    end
end

function player:add_item(item)
    for i = 1, self.inventory_size do
        if self.inventory[i] == "nothing" then
            self.inventory[i] = item
            return true
        end
    end
    return false
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
