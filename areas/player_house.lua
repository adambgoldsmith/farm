Class = require("class")
Area = require("areas.area")

PlayerHouse = Class {
    __includes = Area,
    init = function(self)
        Area.init(self)
        self.name = "Player House"
    end,

    load = function(self)
    end
}

return PlayerHouse