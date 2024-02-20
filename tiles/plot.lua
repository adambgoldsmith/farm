Class = require("class")
Tile = require("tiles.tile")

Plot = Class {
    __includes = Tile,
    init = function(self, x, y)
        Tile.init(self)
        self.pos = {x = x, y = y}
        self.size = {w = 32, h = 32}
        self.name = "plot"
        self.type = "tile"
        self.img = love.graphics.newImage("res/plot.png")
        self.is_tilled = false
        self.is_seeded = false
        self.is_watered = false
        self.is_grown = false
        self.death_chance = 0.1
        self.growth_stage = 0
        self.seed = nil
    end,

    draw = function(self)
        love.graphics.draw(self.img, self.pos.x, self.pos.y)
        if self.is_watered then
            love.graphics.draw(love.graphics.newImage("res/plot_water.png"), self.pos.x, self.pos.y)
        end
        if self.is_seeded then
            love.graphics.draw(self.seed.img, self.pos.x, self.pos.y)
        end
    end,

    update = function(self, dt)
        if love.timer.getTime() % 1 < dt then
            self:grow()
        end
    end,

    interact = function(self, player)
        print("interacting with plot")
        if player.held_item ~= nil then
            if player.held_item.name == "hoe" then
                self.till(self)
            elseif player.held_item.name == "watering_can" then
                self.water(self)
            elseif player.held_item.type == "seed" then
                self.plant_seed(self, player)
            end
        else 
            local produce = self.harvest(self)
            if produce ~= nil then
                player:add_item(produce)
            end
        end
    end,

    till = function(self)
        if not self.is_tilled then
            self.is_tilled = true
            self.img = love.graphics.newImage("res/plot_tilled.png")
        end
    end,

    water = function(self)
        if self.is_tilled and not self.is_watered then
            self.is_watered = true
        end
    end,

    plant_seed = function(self, player)
        if self.is_tilled and not self.is_seeded then
            self.is_seeded = true
            self.seed = player.held_item
            player:delete_item(player.held_item)
        end
    end,

    grow = function(self)
        if self.is_seeded and not self.is_grown then
            if math.random() < self.death_chance then
                self.is_seeded = false
                self.seed = nil
                self.is_watered = false
                self.is_tilled = false
            else
                self.growth_stage = self.growth_stage + 1
                if self.growth_stage == self.seed.growth_time then
                    self.is_grown = true
                end
            end
        end
    end,

    harvest = function(self)
        if self.is_grown then
            self.is_grown = false
            self.is_seeded = false
            self.is_watered = false
            self.is_tilled = false
            self.img = love.graphics.newImage("res/plot.png")
            local produce = self.seed.produce(self.pos.x, self.pos.y)
            self.seed = nil
            return produce
        end
        return nil
    end
}

return Plot