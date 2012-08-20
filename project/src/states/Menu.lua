--
--  Menu
--
--  Created by Tilmann Hars on 2012-08-20.
--  Copyright (c) 2012 Headchant. All rights reserved.
--
local Gamestate = require( LIBRARYPATH.."hump.gamestate"    )
local gui       = require( LIBRARYPATH.."Quickie"           )

Menu = Gamestate.new()

local center = { 
        x = love.graphics.getWidth()/2,
        y = love.graphics.getHeight()/2,
    }

function Menu:update()
    gui.group.push{grow = "down", pos = {center.x-50, center.y-100}}

    if gui.Button{text = "Start"} then
        Gamestate.switch(Game)
    end
    if gui.Button{text = "Options"} then
        Gamestate.switch(Options)
    end
    if gui.Button{text = "Exit"} then
        love.event.push("quit")
    end

    gui.group.pop()
end

function Menu:draw()
    gui.core.draw()
end

function Menu:keypressed(key, code)
    gui.keyboard.pressed(key, code)
end