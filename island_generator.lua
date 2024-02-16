grass = require("tiles.grass")
water = require("tiles.water")
dirt_separator = require("tiles.dirt_separator")

grass_sprites = {
    love.graphics.newImage("res/grass/grass_full.png"),
    love.graphics.newImage("res/grass/grass_left.png"),
    love.graphics.newImage("res/grass/grass_right.png"),
    love.graphics.newImage("res/grass/grass_top_mid.png"),
    love.graphics.newImage("res/grass/grass_top_right.png"),
    love.graphics.newImage("res/grass/grass_top_left.png"),
    love.graphics.newImage("res/grass/grass_bot_mid.png"),
    love.graphics.newImage("res/grass/grass_bot_right.png"),
    love.graphics.newImage("res/grass/grass_bot_left.png"),
}

-- separates the bottom of the grass from the top of the water
dirt_separator_sprite = love.graphics.newImage("res/dirt_separator.png")

water_sprites = {
    love.graphics.newImage("res/water/water_full.png"),
    love.graphics.newImage("res/water/water_top.png")
}

island_generator = {
    island_size_x = 16,
    island_size_y = 16,
    island = {},
}

function island_generator:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function island_generator:generate()
    for i = 1, self.island_size_x do
        self.island[i] = {}
        for j = 1, self.island_size_y do
            if i == 1 then
                -- If it's the first row, set water_sprites[1]
                self.island[i][j] = water:new(nil, (j - 1) * 32, (i - 1) * 32, water_sprites[1])
            elseif i == self.island_size_x then
                if j == 1 or j == self.island_size_y then
                    -- If it's the last row and the first or last column, set water_sprites[1]
                    self.island[i][j] = water:new(nil, (j - 1) * 32, (i - 1) * 32, water_sprites[1])
                else
                    -- If it's the last row and not the first or last column, set water_sprites[2]
                    self.island[i][j] = water:new(nil, (j - 1) * 32, (i - 1) * 32, water_sprites[2])
                end
            elseif i == self.island_size_x - 1 and (j ~= 1 and j ~= self.island_size_y) then
                -- If it's the second last row and not the first or last column, set dirt_separator_sprite
                self.island[i][j] = dirt_separator:new(nil, (j - 1) * 32, (i - 1) * 32, dirt_separator_sprite)
            else
                if j == 1 then
                    -- If it's not the first or last row and the first column, set water_sprites[1]
                    self.island[i][j] = water:new(nil, (j - 1) * 32, (i - 1) * 32, water_sprites[1])
                elseif j == self.island_size_y then
                    -- If it's not the first or last row and the last column, set water_sprites[1]
                    self.island[i][j] = water:new(nil, (j - 1) * 32, (i - 1) * 32, water_sprites[1])
                else
                    -- If it's not the first or last row and not the first or last column, set grass_sprites[1]
                    local determined_grass_sprite = self.determine_grass_sprite(i, j)
                    self.island[i][j] = grass:new(nil, (j - 1) * 32, (i - 1) * 32, determined_grass_sprite)
                end
            end
        end
    end
end

function island_generator.determine_grass_sprite(i, j)
    local determined_grass_sprite = grass_sprites[1]
    if i == 2 then
        if j == 2 then
            determined_grass_sprite = grass_sprites[6]
        elseif j == island_generator.island_size_y - 1 then
            determined_grass_sprite = grass_sprites[5]
        else
            determined_grass_sprite = grass_sprites[4]
        end
    elseif i == island_generator.island_size_x - 2 then
        if j == 2 then
            determined_grass_sprite = grass_sprites[9]
        elseif j == island_generator.island_size_y - 1 then
            determined_grass_sprite = grass_sprites[8]
        else
            determined_grass_sprite = grass_sprites[7]
        end
    else
        if j == 2 then
            determined_grass_sprite = grass_sprites[2]
        elseif j == island_generator.island_size_y - 1 then
            determined_grass_sprite = grass_sprites[3]
        end
    end

    return determined_grass_sprite
end

function island_generator:draw()
    for i = 1, self.island_size_x do
        for j = 1, self.island_size_y do
            self.island[i][j]:draw()
        end
    end
end

return island_generator