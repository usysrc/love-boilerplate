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
local Class         = require (LIBRARYPATH.."hump.class"	)
local Vector        = require (LIBRARYPATH.."hump.vector"	)

require "src.entities.Thing"

--------------------------------------------------------------------------------
-- Class Definition
--------------------------------------------------------------------------------

Entity = Class{
	init = function(self, stage, x, y)
		Thing.init(self, x, y)
		if not stage then return end
		stage:register(self)
		self.stage = stage
	end
}

--------------------------------------------------------------------------------
-- Inheritance
--------------------------------------------------------------------------------

Entity:include(Thing)
