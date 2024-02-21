-- Author: Adam Goldsmith
-- 2024-02-13

math.randomseed(os.time())

Player = require("entities.player")
Camera = require("libraries.camera")
Inventory = require("ui.inventory")
Status = require("ui.status")

TestArea = require("areas.test_area")
FarmArea = require("areas.farm")
PlayerHouseArea = require("areas.player_house")

CAMERA = Camera()

local player = Player(400, 300)
local inventory = Inventory()
local status = Status()
local test_area = TestArea()
local farm = FarmArea()
local player_house = PlayerHouseArea()

local current_area

function love.load()
    love.graphics.setBackgroundColor(0.5, 0.5, 0.5)
    love.graphics.setDefaultFilter("nearest", "nearest")

    player:add_item(Hoe())
    player:add_item(Axe())

    test_area:load()
    farm:load()
    player_house:load()

    current_area = test_area
end

function love.draw()
    CAMERA:attach()

    current_area:draw()
    
    player:draw()
    inventory:draw(player, CAMERA)
    status:draw(player)

    CAMERA:detach()
end

function love.update(dt)
    player:move(dt)
    player:select_item()

    current_area:update(dt, player)

    inventory:attach_to_player(player)
    inventory:slide(dt)
    status:attach_to_player(player)

    CAMERA:lookAt(player.pos.x, player.pos.y)
end

function love.wheelmoved(x, y)
    player:select_item_mouse_wheel(y)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    if key == "i" then
        inventory:toggle_visibility()
    end
    if key == "e" then
        for i, item in ipairs(current_area.ground_items) do
            if player:check_collision(item) then
                if player:add_item(item) then
                    table.remove(current_area.ground_items, i)
                end
            end
        end
        for i, tile in ipairs(current_area.tiles) do
            if player:check_collision(tile) then
                tile:interact(player)
            end
        end
        for i, structure in ipairs(current_area.structures) do
            if player:check_collision(structure) then
                structure:interact(player)
            end
        end
    end
    if key == "q" then
        local item = player:drop_item()
        if item ~= nil then
            item:update_pos(player.pos)
            table.insert(current_area.ground_items, item)
        end
    end
    if key == "p" then
        load_area(farm)
    end
    if key == "l" then
        load_area(player_house)
    end
    if key == "o" then
        load_area(test_area)
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        inventory:select_item(player, CAMERA)
        current_area:click(player)
    end
    if button == 2 then
        inventory:release_item(player)
    end
end

function load_area(area)
    current_area = area
end