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
        local chest = Chest(500, 500)
        self.add_structure(self, chest)
        self.add_ui(self, Shop(caravan))
        self.add_ui(self, Storage(chest))

        local tables = {self.entities, self.trees, self.tiles, self.structures, self.ui}
        for _, tbl in ipairs(tables) do
            for _, object in ipairs(tbl) do
                if object.click then
                    table.insert(self.clickables, object)
                end
            end
        end
    end
}

return Farm