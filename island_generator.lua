plot = require("tiles.plot")
water = require("tiles.water")

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
            if i == 1 or i == self.island_size_x or j == 1 or j == self.island_size_y then
                self.island[i][j] = water:new(nil, (i - 1) * 32, (j - 1) * 32)
            else
                self.island[i][j] = plot:new(nil, (i - 1) * 32, (j - 1) * 32)
            end
        end
    end
end

function island_generator:draw()
    for i = 1, self.island_size_x do
        for j = 1, self.island_size_y do
            self.island[i][j]:draw()
        end
    end
end

return island_generator