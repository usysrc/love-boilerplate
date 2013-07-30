local Class         = require (LIBRARYPATH.."hump.class")

Stage = Class{
	init = function(self, objs)
		self.objects = objs or {}
	end,
	register = function(self, obj)
		self.objects[#self.objects+1] = obj
	end,
	update = function(self, dt)
		for i,v in ipairs(self.objects) do
			v:update(dt)
		end
	end,
	draw = function(self)
		for i,v in ipairs(self.objects) do
			v:draw()
		end
	end
}