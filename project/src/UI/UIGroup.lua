--
-- UIGroup Class
--
-- 2015 Heachant, Tilmann Hars <headchant@headchant.com>
--
--

--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------

require "src.entities.Stage"
local Vector        = require (LIBRARYPATH.."hump.vector"	)


--------------------------------------------------------------------------------
-- Default Settings
--------------------------------------------------------------------------------

local default = {
	dirx = 0,
	diry = 1,
	spacing = { x = 4, y = 4}
}

local grows = {
	up = { x = 0, y = -1},
	down = { x = 0, y = 1},
	left = { x = -1, y = 0},
	right = { x = 1, y = 0}
}

--------------------------------------------------------------------------------
-- push
--------------------------------------------------------------------------------

local push = function(self, options)
	for k,v in pairs(options) do
		self[k] = v
	end
	if options.grow then
		assert(grows[self.grow], "UI Error: growdirectiongroup '"..options.grow.."' not found")
		self.dirx = grows[self.grow].x
		self.diry = grows[self.grow].y
	end
end

local new = function(stage, x, y)
	local obj = Stage(stage, x or 0, y or 0)
	obj.ox, obj.oy = x or 0, y or 0
	obj.pushPosition = Vector()
	obj.push = push
	obj.dirx, obj.diry = default.dirx, default.diry
	obj.spacing = {x = default.spacing.x, y = default.spacing.y}
	-- update the group position
	local this = obj
	local lobj
	obj.next = function(obj)
		if lobj then
			this.pushPosition.x = this.pushPosition.x + this.dirx * lobj.w + this.spacing.x * this.dirx
			this.pushPosition.y = this.pushPosition.y + this.diry * lobj.h + this.spacing.y * this.diry
		end
		obj.pos.x = this.pushPosition.x
		obj.pos.y = this.pushPosition.y
		lobj = obj
	end

	return obj
end


return new