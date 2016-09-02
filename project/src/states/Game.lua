--
--  Game
--

local Gamestate     = requireLibrary("hump.gamestate")
local timer         = requireLibrary("hump.timer")
local Vector        = requireLibrary("hump.vector")
local tween         = timer.tween

Game = Gamestate.new()

local stuff = {}
function Game:enter()

	
end

function Game:update(dt)
   
end

function Game:draw()
    love.graphics.print(love.timer.getFPS(), 0, 0)
end