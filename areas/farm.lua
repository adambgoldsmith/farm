local farm = {
    ground_items = {},
    trees = {},
    tiles = {},
    structures = {}
}

function farm:load()
    self.ground_items = {}
    self.trees = {}
    self.tiles = {}
    self.structures = {}
end

function farm:update(dt)
    for i, item in ipairs(self.ground_items) do
        item:bob()
    end

    for i, tree in ipairs(self.trees) do
        tree:cooldown(dt)
    end

    if love.timer.getTime() % 1 < dt then
        for i, tile in ipairs(self.tiles) do
            tile:grow()
        end
    end
end

function farm:draw()
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
end

return farm