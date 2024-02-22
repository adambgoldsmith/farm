Class = require("class")

Area = Class {
    init = function(self)
        self.level_objects = {}
        self.ui = {}
        self.clickables = {}
        self.collidables = {}
        self.last_collidable_update = 0
    end,

    draw = function(self, player)
        local player_bottom = player.pos.y / 2 + player.size.h / 2

        -- Draw objects that are not collidable
        for _, object in ipairs(self.level_objects) do
            if not object.collidable then
                object:draw()
            end
        end

        -- Draw collidable objects before player
        for _, object in ipairs(self.collidables) do
            if player_bottom > object.pos.y / 2 + object.size.h / 2 then
                object:draw()
            end
        end

        -- Draw the player
        player:draw()

        -- Draw collidable objects after player
        for _, object in ipairs(self.collidables) do
            if player_bottom <= object.pos.y / 2 + object.size.h / 2 then
                object:draw()
            end
        end

        -- Draw UI
        for _, object in ipairs(self.ui) do
            object:draw()
        end
    end,

    update = function(self, dt)
        self.last_collidable_update = self.last_collidable_update + dt
        if self.last_collidable_update >= 0.5 then
            self:update_collidable_objects()
            self.last_collidable_update = 0
        end

        for _, object in ipairs(self.level_objects) do
            if object.update then
                object:update(dt)
            end
        end
    end,

    update_collidable_objects = function(self)
        self.collidables = {}

        for _, object in ipairs(self.level_objects) do
            if object.collidable then
                table.insert(self.collidables, object)
            end
        end
    end,

    click = function(self, player)
        for _, clickable in ipairs(self.clickables) do
            clickable:click(player)
        end
    end,

    add_level_object = function(self, object)
        table.insert(self.level_objects, object)
    end,

    add_ui = function(self, object)
        table.insert(self.ui, object)
    end,

    add_clickables = function(self)
        for _, object in ipairs(self.level_objects) do
            if object.click then
                table.insert(self.clickables, object)
            end
        end
        for _, object in ipairs(self.ui) do
            if object.click then
                table.insert(self.clickables, object)
            end
        end
    end
}

return Area