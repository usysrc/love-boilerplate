
local Gamestate     = require (LIBRARYPATH.."hump.gamestate")
local gui       = require( LIBRARYPATH.."Quickie"           )
local Class         = require (LIBRARYPATH.."hump.class")
local Vector         = require (LIBRARYPATH.."hump.vector")

Thing = Class{
	init = function(self, x, y)
		self.pos = Vector(x, y)
		return self
	end,
	update = function(dt)
	end,
	draw = function()
	end
}

Entity = Class{
	init = function(self, stage, x, y)
		self = Thing.init(self, stage, x, y)
		stage:register(self)
		self.stage = stage
		return self
	end
}
Entity:include(Thing)