-- Author: Adam Goldsmith
-- 2024-02-13

math.randomseed(os.time())

Camera = require("libraries.camera")
Inventory = require("ui.inventory")
Status = require("ui.status")
Shop = require("ui.shop")
Player = require("entities.player")
Chicken = require("entities.chicken")
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

function love.load()
    camera = Camera()
    inventory = Inventory()
    status = Status()
    shop = Shop()

    player = Player(100, 100)
    chicken = Chicken(200, 200)
    fishing_rod = FishingRod(128, 128)
    axe = Axe(160, 128)
    flute = Flute(192, 128)
    carrot = Carrot(192, 128)
    tomato = Tomato(224, 128)
    cabbage = Cabbage(256, 128)
    carrot_seed = CarrotSeed(288, 128)
    tomato_seed = TomatoSeed(320, 128)
    cabbage_seed = CabbageSeed(352, 128)
    egg = Egg(384, 128)
    hoe = Hoe(416, 128)
    watering_can = WateringCan(448, 128)
    caravan = Caravan(480, 128)
    house = House(480, 224)
    fence = Fence(480, 320)
    chest = Chest(480, 416)
    plot = Plot(480, 512)


    ground_items = {
        fishing_rod,
        axe,
        carrot,
        tomato,
        cabbage,
        carrot_seed,
        tomato_seed,
        cabbage_seed,
        egg,
        hoe,
        watering_can,
        flute
    }

    tiles = {
        plot
    }

    trees = {
        Tree(math.random(0, 800), math.random(0, 600)),
        Tree(math.random(0, 800), math.random(0, 600)),
        Tree(math.random(0, 800), math.random(0, 600)),
        Tree(math.random(0, 800), math.random(0, 600)),
    }

    structures = {
        caravan
    }

    love.graphics.setBackgroundColor(0.5, 0.5, 0.5)
    love.graphics.setDefaultFilter("nearest", "nearest")

    player:add_item(Hoe(0, 0))
    player:add_item(WateringCan(0, 0))
    player:add_item(FishingRod(0, 0))
    player:add_item(Axe(0, 0))
end

function love.draw()
    camera:attach()

    chicken:draw()
    caravan:draw()
    house:draw()
    fence:draw()
    chest:draw()
    plot:draw()
    
    for i, tree in ipairs(trees) do
        tree:draw()
    end

    for i, item in ipairs(ground_items) do
        item:draw()
    end

    player:draw()

    inventory:draw(player, camera)
    status:draw(player)
    shop:draw(caravan, camera)

    camera:detach()
end

function love.update(dt)
    player:move(dt)
    player:select_item()

    chicken:move(dt)
    if chicken:ready_to_lay_egg(dt) then
        table.insert(ground_items, chicken:lay_egg())
    end

    for i, item in ipairs(ground_items) do
        item:bob()
    end

    for i, tree in ipairs(trees) do
        tree:cooldown(dt)
    end

    if love.timer.getTime() % 1 < dt then
        for i, tile in ipairs(tiles) do
            tile:grow()
        end
    end

    inventory:attach_to_player(player)
    inventory:slide(dt)
    status:attach_to_player(player)

    camera:lookAt(player.pos.x, player.pos.y)
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
        for i, item in ipairs(ground_items) do
            if player:check_collision(item) then
                if player:add_item(item) then
                    table.remove(ground_items, i)
                end
            end
        end
        for i, tile in ipairs(tiles) do
            if player:check_collision(tile) then
                tile:interact(player)
            end
        end
        for i, structure in ipairs(structures) do
            if player:check_collision(structure) then
                structure:interact(player)
            end
        end
    end
    if key == "q" then
        local item = player:drop_item()
        if item ~= nil then
            item:update_pos(player.pos)
            table.insert(ground_items, item)
        end
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        shop:buy_item(player, caravan, camera)
        inventory:select_item(player, camera)
        for i, tree in ipairs(trees) do
            if player:check_collision(tree) then
                local logs = tree:interact(player)
                if logs ~= nil then
                    table.insert(ground_items, logs)
                    table.remove(trees, i)
                end
            end
        end
    end
    if button == 2 then
        inventory:release_item(player)
    end
end