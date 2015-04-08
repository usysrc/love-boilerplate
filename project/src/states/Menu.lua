--
--  Menu
--

local Gamestate     = require( LIBRARYPATH.."hump.gamestate"    )
local UI            = require( "src.UI")
local timer         = require (LIBRARYPATH.."hump.timer")
local tween         = timer.tween
Menu = Gamestate.new()


local center = { 
        x = love.graphics.getWidth()/4,
        y = love.graphics.getHeight()/4,
    }

local stage
local button, group

local init = function()
    group = UI.UIGroup(stage)
    group:push{grow = "right", pos = {x = 2, y = 2}}
end

local newButton = function(text, onClick)
    return UI.UIButton{
        parent = group,
        onClick = onClick or function()
        end,
        text = text,
        scale = 2,
        dynamicWidth = true
    }
end

function Menu:enter(prev)
    stage = Stage()
    UI.UIMenuBar{ stage = stage }
    init()
    newButton("START", function() Gamestate.switch(Game) end)
    button = newButton("LOAD")
    newButton("OPTIONS")
end

function Menu:update(dt)
    timer.update(dt)
    stage:update(dt)
end

local canvas = love.graphics.newCanvas()

function Menu:draw()
    canvas:clear()
    love.graphics.setCanvas(canvas)
    stage:draw()
    love.graphics.setCanvas()
    love.graphics.setColor(255,255,255)
    love.graphics.draw(canvas, 0,0, 0, button.scale, button.scale)
end

function Menu:mousepressed(x,y,btn)
    stage:mousepressed(x, y, btn)
end