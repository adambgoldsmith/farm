plot = {
    x = 0,
    y = 0,
    name = "plot",
    type = "tile",
    sprite = {
        plot = love.graphics.newImage("res/missing_texture.png"),
        plot_tilled = love.graphics.newImage("res/missing_texture.png"),
        plot_water = love.graphics.newImage("res/missing_texture.png"),
    },
    is_tilled = false,
    is_seeded = false,
    is_watered = false,
    is_grown = false,
    is_dead = false,
    death_chance = 0.1,
    growth = 0,
    seed = nil,
}

function plot:new(o, x, y)
    o = o or {}
    o.x = x or 0
    o.y = y or 0
    o.sprite = {
        plot = love.graphics.newImage("res/plot.png"),
        plot_tilled = love.graphics.newImage("res/plot_tilled.png"),
        plot_water = love.graphics.newImage("res/plot_water.png"),
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

function plot:draw()
    if not self.is_tilled then
        love.graphics.draw(self.sprite.plot, self.x, self.y)
    else
        love.graphics.draw(self.sprite.plot_tilled, self.x, self.y)
    end
    if self.is_watered then
        love.graphics.draw(self.sprite.plot_water, self.x, self.y)
    end
    if self.is_seeded then
        love.graphics.draw(self.seed.sprite, self.x, self.y)
    end
end

function plot:till()
    self.is_tilled = true
end

function plot:plant_seed(seed)
    self.seed = seed
    self.is_seeded = true
end

function plot:water()
    self.is_watered = true
    self.death_chance = self.death_chance / 2
end

function plot:grow()
    if self.is_seeded then
        self.growth = self.growth + 1
    end
end

function plot:harvest()
    if self.growth >= self.seed.growth_time then
        self.is_tilled = false
        self.is_seeded = false
        self.is_watered = false
        self.growth = 0
        produce = self.seed.produce
        self.seed = nil
        return produce:new()
    end
    return "nothing"
end

return plot