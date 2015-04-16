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
	-- assuming that x,y are the center
	init = function(self, stage, x, y)
		Thing.init(self, x, y)
		if not stage then return end
		stage:register(self)
		self.stage = stage
	end,
	getEdges = function(self)
		return {
			Vector(self.pos.x - self.w/2, self.pos.y - self.h/2),
			Vector(self.pos.x - self.w/2, self.pos.y + self.h/2),
			Vector(self.pos.x + self.w/2, self.pos.y - self.h/2),
			Vector(self.pos.x + self.w/2, self.pos.y + self.h/2)
		}
	end,
	getMinMax = function(self)
		return 	Vector(self.pos.x - self.w/2, self.pos.y - self.h/2),
				Vector(self.pos.x + self.w/2, self.pos.y + self.h/2)
	end,
	getMTV = function(self, other)
		local ret = Vector(0,0)
		local minA, maxA = self:getMinMax()
		local minB, maxB = other:getMinMax()

		local left = minB.x - maxA.x
		local right = maxB.x - minA.x
		local bottom = minB.y - maxA.y
		local top = maxB.y - minA.y

		if (math.abs(left) > right) then
			ret.x = right
		else
			ret.x = left
		end

		if (math.abs(bottom) > top) then
			ret.y = top
		else
			ret.y = bottom
		end

		if (math.abs(ret.x) <= math.abs(ret.y)) then
			ret.y = 0
		else
			ret.x = 0
		end
		return ret
	end,
	intersects = function(self, other)
		local x1,y1,w1,h1, x2,y2,w2,h2 = self.pos.x, self.pos.y, self.w or 1 , self.h or 1, other.pos.x, other.pos.y, other.w or 1, other.h or 1
		x1,y1,x2,y2 = x1-w1/2, y1-h1/2, x2-w2/2, y2-h2/2
  		return x1 < x2+w2 and
	         x2 < x1+w1 and
	         y1 < y2+h2 and
	         y2 < y1+h1

	 	
	end,
	axisSeperate = function(self, vectorAxis, polygonA, polygonB)

	end,
	collision = function(self, other) 
		local mtv = self:getMTV(other)
		self.pos = self.pos + mtv * 0.5
		other.pos = other.pos - mtv*0.5
	end
}

--------------------------------------------------------------------------------
-- Inheritance
--------------------------------------------------------------------------------

Entity:include(Thing)
