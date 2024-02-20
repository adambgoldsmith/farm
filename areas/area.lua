Class = require("class")

Area = Class {
    init = function(self)
        self.entities = {}
        self.ground_items = {}
        self.trees = {}
        self.tiles = {}
        self.structures = {}
        self.ui = {}
    end,

    draw = function(self)
        for i, item in ipairs(self.ground_items) do
            item:draw()
        end

        for i, tree in ipairs(self.trees) do
            tree:draw()
        end

        for i, tile in ipairs(self.tiles) do
            tile:draw()
        end

        for i, structure in ipairs(self.structures) do
            structure:draw()
        end

        for i, entity in ipairs(self.entities) do
            entity:draw()
        end

        for i, ui in ipairs(self.ui) do
            ui:draw()
        end
    end,

    update = function(self, dt, player)
        for i, item in ipairs(self.ground_items) do
            item:update()
        end

        for i, tree in ipairs(self.trees) do
            tree:update(dt)
        end

        for i, tile in ipairs(self.tiles) do
            tile:update(dt)
        end

        for i, entity in ipairs(self.entities) do
            entity:update(dt, player)
        end
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
    end
}

return Area