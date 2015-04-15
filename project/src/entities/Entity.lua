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
	end,
	intersects = function(self, other)
		local x1,y1,w1,h1, x2,y2,w2,h2 = self.pos.x, self.pos.y, self.w or 1 , self.h or 1, other.pos.x, other.pos.y, other.w or 1, other.h or 1
		x1,y1,x2,y2 = x1-w1/2, y1-h1/2, x2-w2/2, y2-h2/2
  		return x1 < x2+w2 and
	         x2 < x1+w1 and
	         y1 < y2+h2 and
	         y2 < y1+h1
	end,
	collision = function(self, other) end
}

--------------------------------------------------------------------------------
-- Inheritance
--------------------------------------------------------------------------------

Entity:include(Thing)
