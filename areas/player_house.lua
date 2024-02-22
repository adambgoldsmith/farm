Class = require("class")
Area = require("areas.area")

Bed = require("structures.bed")
Door = require("structures.door")

PlayerHouse = Class {
    __includes = Area,
    init = function(self)
        Area.init(self)
        self.name = "Player House"
    end,

    load = function(self)
        self:add_level_object(Bed(192, 32))
        self:add_level_object(Door(32, 192, TEST_AREA))
    end
}

return PlayerHouse
