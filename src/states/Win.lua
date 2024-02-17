--
--  Game
--

local Gamestate = require("libs.hump.gamestate")

local Win = Gamestate.new()

function Win:enter()

end

function Win:update(dt)

end

function Win:draw()
	love.graphics.print("You win", love.graphics.getWidth() / 2 - 32, love.graphics.getHeight() / 2)
end

return Win
