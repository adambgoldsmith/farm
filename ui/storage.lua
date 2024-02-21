Class = require("class")
UI = require("ui.ui")

Storage = Class {
    __includes = UI,
    init = function(self, container)
        UI.init(self)
        self.name = "storage"
        self.type = "ui"
        self.pos = {x = 0, y = 0}
        self.size = {w = 0, h = 0}
        self.container = container
    end,

    draw = function(self)
        if self.container.is_open then
            self:display_storage(self.container)
        end
    end,

    display_storage = function(self)
        local itemsPerLine = 3
        local itemWidth = 32
        local itemHeight = 32

        for i = 1, self.container.max_items do
            local row = math.floor((i - 1) / itemsPerLine)
            local col = (i - 1) % itemsPerLine

            local x = self.container.pos.x + col * itemWidth - 32
            local y = self.container.pos.y - (row + 1) * itemHeight - 16

            love.graphics.rectangle("line", x, y, itemWidth, itemHeight)
            if self.container.items[i] ~= nil then
                love.graphics.draw(self.container.items[i].img, x, y)
            end
        end
    end
}

return Storage