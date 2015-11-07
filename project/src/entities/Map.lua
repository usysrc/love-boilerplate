--
-- Map Class
--
-- 2015 Heachant, Tilmann Hars <headchant@headchant.com>
--
-- Made for tilemaps and works with entity collision

--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------

local Gamestate     = require (LIBRARYPATH.."hump.gamestate")
local Class         = require (LIBRARYPATH.."hump.class"	)
local Vector        = require (LIBRARYPATH.."hump.vector"	)

--------------------------------------------------------------------------------
-- Class Definition
--------------------------------------------------------------------------------

Map = Class{
	init = function(self)
		self.data = {}
	end,
	set = function(self, i, j, what)
		self.data[i..","..j] = what
	end,
	get = function(self, i, j)
		return self.data[i..","..j]
	end,
	isBlocked = function(self, i, j)
		local t = self:get(i,j)
		return t and t.blocked
	end
}