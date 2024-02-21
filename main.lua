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
PLAYER = Player(400, 300)
INVENTORY = Inventory()
STATUS = Status()

TEST_AREA = TestArea()
FARM = FarmArea()
PLAYER_HOUSE = PlayerHouseArea()

CURRENT_AREA = TEST_AREA

function love.load()
    love.graphics.setBackgroundColor(0.5, 0.5, 0.5)
    love.graphics.setDefaultFilter("nearest", "nearest")

    PLAYER:add_item(Hoe())
    PLAYER:add_item(Axe())

    TEST_AREA:load()
    FARM:load()
    PLAYER_HOUSE:load()
    cabin_indoors = love.graphics.newImage("res/cabin_indoors.png")
end

function love.draw()
    CAMERA:attach()

    CURRENT_AREA:draw()

    if CURRENT_AREA == FARM then
        love.graphics.setBackgroundColor(29/255, 112/255, 18/255)
    elseif  CURRENT_AREA == PLAYER_HOUSE then
        love.graphics.setBackgroundColor(0, 0, 0)
        love.graphics.draw(cabin_indoors, 0, 0)
    end

    PLAYER:draw()
    INVENTORY:draw(PLAYER, CAMERA)
    STATUS:draw(PLAYER)

    CAMERA:detach()
end

function love.update(dt)
    PLAYER:move(dt)
    PLAYER:select_item()

    CURRENT_AREA:update(dt, PLAYER)

    INVENTORY:attach_to_player(PLAYER)
    INVENTORY:slide(dt)
    STATUS:attach_to_player(PLAYER)

    CAMERA:lookAt(PLAYER.pos.x, PLAYER.pos.y)
end

function love.wheelmoved(x, y)
    PLAYER:select_item_mouse_wheel(y)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    if key == "i" then
        INVENTORY:toggle_visibility()
    end
    if key == "e" then
        for i, item in ipairs(CURRENT_AREA.ground_items) do
            if PLAYER:check_collision(item) then
                if PLAYER:add_item(item) then
                    table.remove(CURRENT_AREA.ground_items, i)
                end
            end
        end
        for i, tile in ipairs(CURRENT_AREA.tiles) do
            if PLAYER:check_collision(tile) then
                tile:interact(PLAYER)
            end
        end
        for i, structure in ipairs(CURRENT_AREA.structures) do
            if PLAYER:check_collision(structure) then
                structure:interact(PLAYER)
            end
        end
    end
    if key == "q" then
        local item = PLAYER:drop_item()
        if item ~= nil then
            item:update_pos(PLAYER.pos)
            table.insert(CURRENT_AREA.ground_items, item)
        end
    end
    if key == "p" then
        load_area(FARM)
    end
    if key == "o" then
        load_area(TEST_AREA)
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        INVENTORY:select_item(PLAYER, CAMERA)
        CURRENT_AREA:click(PLAYER)
    end
    if button == 2 then
        INVENTORY:release_item(PLAYER)
    end
end

function load_area(area)
    CURRENT_AREA = area
end