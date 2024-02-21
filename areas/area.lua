Class = require("class")

Area = Class {
    init = function(self)
        self.entities = {}
        self.ground_items = {}
        self.trees = {}
        self.tiles = {}
        self.structures = {}
        self.ui = {}
        self.clickables = {}
    end,

    draw = function(self)
        for _, item in ipairs(self.ground_items) do
            item:draw()
        end

        for _, tree in ipairs(self.trees) do
            tree:draw()
        end

        for _, tile in ipairs(self.tiles) do
            tile:draw()
        end

        for _, structure in ipairs(self.structures) do
            structure:draw()
        end

        for _, entity in ipairs(self.entities) do
            entity:draw()
        end

        for _, ui in ipairs(self.ui) do
            ui:draw()
        end
    end,

    update = function(self, dt, player)
        for _, item in ipairs(self.ground_items) do
            item:update(dt)
        end

        for _, tree in ipairs(self.trees) do
            tree:update(dt)
        end

        for _, tile in ipairs(self.tiles) do
            tile:update(dt)
        end

        for _, entity in ipairs(self.entities) do
            entity:update(dt, player)
        end
    end,

    click = function(self, player)
        for _, clickable in ipairs(self.clickables) do
            clickable:click(player)
        end
    end,

    add_background = function(self, background)
        table.insert(self.backgrounds, background)
    end,

    add_entity = function(self, entity)
        table.insert(self.entities, entity)
    end,

    add_ground_item = function(self, item)
        table.insert(self.ground_items, item)
    end,

    add_tree = function(self, tree)
        table.insert(self.trees, tree)
    end,

    add_tile = function(self, tile)
        table.insert(self.tiles, tile)
    end,

    add_structure = function(self, structure)
        table.insert(self.structures, structure)
    end,

    add_ui = function(self, ui)
        table.insert(self.ui, ui)
    end,

    add_clickables = function(self)
        local tbls = {self.entities, self.ground_items, self.trees, self.tiles, self.structures, self.ui}
        for _, tbl in ipairs(tbls) do
            for _, object in ipairs(tbl) do
                if object.click then
                    table.insert(self.clickables, object)
                end
            end
        end
    end
}

return Area