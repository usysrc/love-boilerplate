--
-- main.lua
--
require("libs.strict")
require("globals")
local Game = require("src.states.Game")
local Gamestate = requireLibrary("hump.gamestate")

-- Initialization
function love.load()
	math.randomseed(os.time())
	love.graphics.setDefaultFilter("nearest", "nearest")
	Gamestate.registerEvents()
	Gamestate.switch(Game)
end

-- Get console output working with some terminals
io.stdout:setvbuf("no")
