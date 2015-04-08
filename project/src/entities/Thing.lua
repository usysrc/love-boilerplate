--
-- Thing Class
--
-- 2014 Heachant, Tilmann Hars <headchant@headchant.com>
--
--

--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------

local Gamestate     = require (LIBRARYPATH.."hump.gamestate")
local gui       	= require (LIBRARYPATH.."Quickie"		)
local Class         = require (LIBRARYPATH.."hump.class"	)
local Vector        = require (LIBRARYPATH.."hump.vector"	)

--------------------------------------------------------------------------------
-- Class Definition
--------------------------------------------------------------------------------

Thing = Class{
	init = function(self, x, y)
		self.pos = Vector(x, y)
	end,
	update = function(dt)
	end,
	draw = function()
	end
}