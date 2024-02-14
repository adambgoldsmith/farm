plot = require("tiles.plot")
water = require("tiles.water")

island_generator = {
    island_size_x = 10,
    island_size_y = 10,
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
            self.island[i][j] = plot:new(nil, i * 32, j * 32)
        end
    end
    for i = 1, self.island_size_x do
        self.island[i][1] = water:new(nil, i * 32, 0)
        self.island[i][self.island_size_y] = water:new(nil, i * 32, self.island_size_y * 32)
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