Class = require("class")
Area = require("areas.area")

Mask = require("entities.mask")
FishingRod = require("items.fishing_rod")
Axe = require("items.axe")
Hoe = require("items.hoe")
WateringCan = require("items.watering_can")
Carrot = require("items.carrot")
Tomato = require("items.tomato")
Cabbage = require("items.cabbage")
CarrotSeed = require("items.carrot_seed")
TomatoSeed = require("items.tomato_seed")
CabbageSeed = require("items.cabbage_seed")
Egg = require("items.egg")
Caravan = require("structures.caravan")
House = require("structures.house")
Fence = require("structures.fence")
Chest = require("structures.chest")
Flute = require("items.flute")
Plot = require("tiles.plot")
Tree = require("tree")

TestArea = Class {
    __includes = Area,
    init = function(self)
        Area.init(self)
        self.name = "Test Area"
    end,

    load = function(self)
        self:add_entity(Mask(256, 500))

        self:add_ground_item(FishingRod(200, 0))
        self:add_ground_item(Axe(232, 0))
        self:add_ground_item(Hoe(264, 0))
        self:add_ground_item(WateringCan(296, 0))
        self:add_ground_item(Carrot(328, 0))
        self:add_ground_item(Tomato(360, 0))
        self:add_ground_item(Cabbage(392, 0))
        self:add_ground_item(CarrotSeed(424, 0))
        self:add_ground_item(TomatoSeed(456, 0))
        self:add_ground_item(CabbageSeed(488, 0))
        self:add_ground_item(Egg(520, 0))
        self:add_ground_item(Flute(552, 0))

        self:add_tile(Plot(0, 0))
        self:add_tile(Plot(32, 0))
        self:add_tile(Plot(64, 0))
        self:add_tile(Plot(96, 0))
        self:add_tile(Plot(128, 0))
        self:add_tile(Plot(160, 0))

        self:add_structure(Caravan(0, 0))
        self:add_structure(House(0, 100))
        self:add_structure(Fence(0, 200))
        self:add_structure(Chest(0, 300))

        self:add_tree(Tree(0, 400))
        self:add_tree(Tree(32, 400))
        self:add_tree(Tree(64, 400))
        self:add_tree(Tree(96, 400))
        self:add_tree(Tree(128, 400))
    end
}

return TestArea