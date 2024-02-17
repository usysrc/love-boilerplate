--
--  Game
--

local Gamestate = require("libs.hump.gamestate")
local Timer = require("libs.hump.timer")
local Vector = require("libs.hump.vector")
local Tween = Timer.tween
local Map = require("src.entities.Map")
local Win = require("src.states.Win")

local Game = Gamestate.new()

function Game:enter()
	Game.objects = {}
	Game.map = Map()
	Game.w = 32
	Game.h = 32

	-- Create a circle
	local obj = {
		pos = Vector(400, 300),
		draw = function(self)
			love.graphics.circle("fill", self.pos.x, self.pos.y, 32, 32)
		end,
	}
	add(Game.objects, obj)

	local this
	this = function()
		Tween(2, obj.pos, { x = 0, y = math.random() * 600 }, "quad", function()
			Tween(2, obj.pos, { x = 800, y = math.random() * 600 }, "quad", this)
		end)
	end
	this()
end

function Game:update(dt)
	Timer.update(dt)
end

function Game:draw()
	for obj in all(Game.objects) do
		obj:draw()
	end
	love.graphics.print(love.timer.getFPS(), 0, 0)
end

function Game:mousepressed(x, y, button)
	Gamestate.switch(Win)
end

return Game
