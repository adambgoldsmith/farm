-- Author: Adam Goldsmith
-- 2024-02-13

function love.load()
    camera = require("libraries.camera")
    cam = camera()

    hotbar = require("ui.hotbar")
    Hotbar = hotbar:new(nil, 0, 0)

    status = require("ui.status")
    Status = status:new(nil, 0, 0)

    island_generator = require("island_generator")
    Island = island_generator:new()
    Island:generate()

    player = require("entities.player")
    plot = require("tiles.plot")
    water = require("tiles.water")
    hoe = require("items.hoe")
    watering_can = require("items.watering_can")
    carrot_seed = require("items.carrot_seed")
    tomato_seed = require("items.tomato_seed")
    cabbage_seed = require("items.cabbage_seed")
    tomato = require("items.tomato")
    cabbage = require("items.cabbage")
    chicken = require("entities.chicken")
    fence = require("fence")
    house = require("house")
    chest = require("chest")

    ground_items = {
        cabbage_seed:new(nil, 256, 256),
        cabbage_seed:new(nil, 288, 256),
    }

    Player = player:new()
    Player:add_item(hoe:new())
    Player:add_item(watering_can:new())
    Player:add_item(carrot_seed:new())
    Player:add_item(tomato_seed:new())
    Plot = plot:new(nil, 64, 64)
    Water = water:new(nil, 96, 96)
    Chicken = chicken:new(nil, 128, 128)
    Fence = fence:new(nil, 192, 192)
    House = house:new(nil, 512, 64)
    Chest = chest:new(nil, 256 + 64, 192)
end

function love.draw()
    cam:attach()

        love.graphics.setBackgroundColor(0.1, 0.6, 0.1)

        Island:draw()
        
        Plot:draw()
        Water:draw()

        House:draw()

        Chest:draw()

        Fence:draw()

        Chicken:draw()

        for i, item in ipairs(ground_items) do
            item:draw()
        end

        Player:draw()

        Hotbar:draw(Player)
        Status:draw(Player)

    cam:detach()
end

function love.update(dt)
    if love.timer.getTime() % 1 < dt then
        Plot:grow()
    end

    Player:move(dt)
    Player:select_item()
    Player:tile_collision(Water)

    Chicken:move(dt)
    Chicken:tile_collision(Water)
    if Chicken:lay_egg(dt) then
        local egg = Chicken.produce:new(nil, Chicken.x, Chicken.y)
        table.insert(ground_items, egg)
    end


    if Player:check_tile(Plot) then
        if Player:use_item() then
            if type(Player.held_item) == "table" then
                if Player.held_item.name == "hoe" and not Plot.is_tilled then
                    Plot:till()
                end
                if Player.held_item.type == "seed" and Plot.is_tilled and not Plot.is_seeded then
                    Plot:plant_seed(Player.held_item)
                    Player:delete_item()
                end
                if Player.held_item.name == "watering can" and Plot.is_tilled then
                    Plot:water()
                end
            elseif  Player.held_item == "nothing" then
                if Plot.is_seeded then
                    -- this should only happen if the growth time has passed
                    -- it should only ever return a table that is a produce
                    -- currently returns "nothing"
                    local harvested_item = Plot:harvest()
                    Player:add_item(harvested_item)
                end
            end
        end
    end

    for i, item in ipairs(ground_items) do
        item:float()

        if Player:check_ground_item(item) then
            if Player:use_item() then
                local res = Player:add_item(item)
                if res then
                    table.remove(ground_items, i)
                end
            end
        end
    end

    if Player:drop_item() then
        Player.held_item:drop(Player.x, Player.y)
        table.insert(ground_items, Player.held_item)
        Player.held_item = "nothing"
        Player.inventory[Player.held_item_index] = "nothing"
    end

    Hotbar:attach_to_player(Player)
    Status:attach_to_player(Player)

    cam:lookAt(Player.x, Player.y)
end