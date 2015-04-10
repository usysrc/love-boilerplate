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
require "src.entities.Entity"

--------------------------------------------------------------------------------
-- Class Definition
--------------------------------------------------------------------------------

Stage = Class{
	init = function(self, parent, x, y, objs)
		Entity.init(self, parent, x or 0, y or 0)
		self.objects = objs or {}
	end,
	register = function(self, obj)
		self.objects[#self.objects+1] = obj
		obj.stage = self
	end,
	remove = function(self, obj)
		for i=#self.objects,1,-1 do
			local v = self.objects[i]
			if v and v == obj then
				v.stage = nil
				table.remove(self.objects, i)
				if v.remove then v:remove() end
			end
		end
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
		love.graphics.push()
		love.graphics.translate(self.pos.x, self.pos.y)
		print(#self.objects)
		for i,v in ipairs(self.objects) do
			v:draw()
		end
		love.graphics.pop()
	end,
	mousepressed = function(self, x, y, btn)
		for i,v in ipairs(self.objects) do
			if v.mousepressed then v:mousepressed(x,y,btn) end
		end
	end
}

--------------------------------------------------------------------------------
-- Inheritance
--------------------------------------------------------------------------------

Stage:include(Entity)