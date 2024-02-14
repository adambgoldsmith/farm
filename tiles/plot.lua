plot = {
    x = 0,
    y = 0,
    type = "plot",
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
    setmetatable(o, self)
    self.__index = self
    return o
end

function plot:draw()
    love.graphics.rectangle("line", self.x, self.y, 32, 32)
    if self.is_tilled then
        love.graphics.setColor(139, 69, 19)
        love.graphics.rectangle("fill", self.x, self.y, 32, 32)
    end
    if self.is_watered then
        love.graphics.setColor(0, 0, 255)
        love.graphics.rectangle("fill", self.x, self.y, 32, 32)
    end
    if self.is_seeded then
        love.graphics.setColor(255, 255, 255)
        love.graphics.print(self.seed.name, self.x, self.y)
        love.graphics.setColor(0, 255, 0)
        love.graphics.print(tostring(self.growth), self.x, self.y + 16)
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