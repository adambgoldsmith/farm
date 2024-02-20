Class = require("class")
Area = require("areas.area")

-- Entities
Chicken = require("entities.chicken")
-- Trees
Tree = require("tree")
-- Tiles
Plot = require("tiles.plot")
-- Structures
Caravan = require("structures.caravan")
Chest = require("structures.chest")
-- UI
Shop = require("ui.shop")
Storage = require("ui.storage")

Farm = Class {
    __includes = Area,
    init = function(self)
        Area.init(self)
        self.name = "Farm"
    end,

    load = function(self)
        self.add_entity(self, Chicken(100, 100))
        self.add_tree(self, Tree(200, 200))
        self.add_tile(self, Plot(300, 300))
        local caravan = Caravan(400, 400)
        self.add_structure(self, caravan)
        self.add_structure(self, Chest(500, 500))
        self.add_ui(self, Shop(caravan))
    end
}

return Farm