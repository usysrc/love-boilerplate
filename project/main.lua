--
--  LD24Warumup
--
--  Created by Tilmann Hars on 20.08.2012.
--  Copyright (c) 2012 Headchant. All rights reserved.
--

-- Set Library Folders
LIBRARYPATH = "libs"
LIBRARYPATH = LIBRARYPATH .. "."

-- Get the libs manually
local strict    = require( LIBRARYPATH.."strict"            )
local slam      = require( LIBRARYPATH.."slam"              )
local Gamestate = require( LIBRARYPATH.."hump.gamestate"    )

-- Handle some global variables that strict.lua may (incorrectly, ofcourse) complain about:
no_game_code = nil
NO_WIDGET = nil

-- require all files in a folder and its subfolders, this way we do not have to require every new file
local function recursiveRequire(folder, tree)
    local tree = tree or {}
    for i,file in ipairs(love.filesystem.enumerate(folder)) do
        local filename = folder.."/"..file
        print(filename)
        if love.filesystem.isDirectory(filename) then
            recursiveRequire(filename)
        else
            require(filename:gsub(".lua",""))
        end
    end
    return tree
end

-- Initialization
function love.load()
    print "Require Sources:"
    recursiveRequire("src")
	Gamestate.registerEvents()
	Gamestate.switch(Menu)
end

-- Logic
function love.update( dt )
	
end

-- Rendering
function love.draw()
	
end

-- Input
function love.keypressed()
	
end

function love.keyreleased()
	
end

function love.mousepressed()
	
end

function love.mousereleased()
	
end

function love.joystickpressed()
	
end

function love.joystickreleased()
	
end