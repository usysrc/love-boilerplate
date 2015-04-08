--
-- UIButton Class
--
-- 2015 Heachant, Tilmann Hars <headchant@headchant.com>
--
--

--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------

local Class         = require (LIBRARYPATH.."hump.class"	)
local UIGroup 		= require "src.UI.UIGroup"


--------------------------------------------------------------------------------
-- Default Values
--------------------------------------------------------------------------------

local default = {
	h = 20,
	bgColor = {7, 47, 134}
}

--------------------------------------------------------------------------------
-- Draw
--------------------------------------------------------------------------------

local draw = function(self)
	local maxr, maxg, maxb = 255 - default.bgColor[1], 255 - default.bgColor[2], 255 - default.bgColor[3]
	local r,g,b = default.bgColor[1], default.bgColor[2], default.bgColor[3]

	for i=1, self.h do
		local k = 0.2 * math.floor(math.sin(math.pi*i/self.h)*8)/8
		love.graphics.setColor(r+k*maxr,g+k*maxg,b+k*maxb)
		love.graphics.line(0,i,love.graphics.getWidth(), i)
	end
end

local new = function(options)
	local obj = Entity(options.stage, 0, 0)
	obj.draw = draw
	obj.h = options.h or default.h
	return obj
end

return new