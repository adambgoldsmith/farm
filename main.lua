-- Author: Adam Goldsmith
-- 2024-02-13

function love.load()
    player = require("player")
    plot = require("tiles.plot")
    hoe = require("items.hoe")
    watering_can = require("items.watering_can")
    carrot_seed = require("items.carrot_seed")
    tomato_seed = require("items.tomato_seed")
    cabbage_seed = require("items.cabbage_seed")

    ground_items = {
        cabbage_seed:new(nil, 256, 256),
    }

    Player = player:new()
    Player:add_item(hoe:new())
    Player:add_item(watering_can:new())
    Player:add_item(carrot_seed:new())
    Player:add_item(tomato_seed:new())
    Plot = plot:new(nil, 64, 64)
end

function love.draw()
    if type(Player.held_item) == "table" then
        love.graphics.print(Player.held_item.name, 256, 0)
    else
        love.graphics.print(tostring(Player.held_item), 256, 0)
    end
    
    Player:draw()
    Plot:draw()

    for i, item in ipairs(ground_items) do
        item:draw()
    end
end

function love.update(dt)
    if love.timer.getTime() % 1 < dt then
        Plot:grow()
    end

    Player:move(dt)
    Player:select_item()

    if Player:check_tile(Plot) then
        if Player:use_item() then
            if type(Player.held_item) == "table" then
                if Player.held_item.name == "hoe" and not Plot.is_tilled then
                    Plot:till()
                end
                if Player.held_item.type == "seed" and Plot.is_tilled and not Plot.is_seeded then
                    Plot:plant_seed(Player.held_item)
                end
                if Player.held_item.name == "watering can" and Plot.is_tilled then
                    Plot:water()
                end
            elseif  Player.held_item == "nothing" then
                if Plot.is_seeded then
                    local harvested_item = Plot:harvest()
                    Player:add_item(harvested_item)
                end
            end
        end
    end

    for i, item in ipairs(ground_items) do
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
end