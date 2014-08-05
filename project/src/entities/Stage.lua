--
-- Stage Class
--
-- 2014 Heachant, Tilmann Hars <headchant@headchant.com>
--
--

--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------

local Class         = require (LIBRARYPATH.."hump.class")

--------------------------------------------------------------------------------
-- Class Definition
--------------------------------------------------------------------------------

Stage = Class{
	init = function(self, objs)
		self.objects = objs or {}
	end,
	register = function(self, obj)
		self.objects[#self.objects+1] = obj
	end,
	update = function(self, dt)
		for i=#self.objects,1,-1 do
			local v = self.objects[i]
			if v then
				v:update(dt)
				if v.dead then
					if v.remove then v:remove() end
					table.remove(self.objects, i)
				end
			end
		end
	end,
	draw = function(self)
		for i,v in ipairs(self.objects) do
			v:draw()
		end
	end
}