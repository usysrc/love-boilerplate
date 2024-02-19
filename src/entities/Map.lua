--
-- Map Class
--
-- Made for tilemaps

--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------

local Class = require("libs.hump.class")

--------------------------------------------------------------------------------
-- Class Definition
--------------------------------------------------------------------------------

local Map = Class({
	init = function(self)
		self.data = {}
	end,
	set = function(self, i, j, what)
		self.data[i .. "," .. j] = what
	end,
	get = function(self, i, j)
		return self.data[i .. "," .. j]
	end,
	isBlocked = function(self, i, j)
		local t = self:get(i, j)
		return t and t.blocked
	end,
})

return Map
