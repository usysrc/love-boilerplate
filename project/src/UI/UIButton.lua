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

--------------------------------------------------------------------------------
-- Default Settings
--------------------------------------------------------------------------------

local default = {
	w = 64,
	h = 16,
	bgColor 		= {88,84,80},
	fgColor 		= {255,255,255},
	fontColor 		= {204,204,204},
	shadingColor 	= {
		{120, 116, 112},
		{72, 68, 64},
		{56, 52, 48},
		{104, 100, 96},

	},
	scale = 3,
	margin = 8
}

--------------------------------------------------------------------------------
-- drawing
--------------------------------------------------------------------------------

local draw = function(self)
	love.graphics.setColor(self.bgColor)
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.w, self.h)
	love.graphics.setLineStyle("rough")
	love.graphics.setLineWidth(1)
	love.graphics.setLineJoin("miter")
	love.graphics.setColor(self.shadingColor[1])
	love.graphics.line(self.pos.x, self.pos.y , self.pos.x+self.w, self.pos.y+1)

	love.graphics.setColor(self.shadingColor[2])
	love.graphics.line(self.pos.x+self.w, self.pos.y, self.pos.x+self.w, self.pos.y+self.h)

	love.graphics.setColor(self.shadingColor[4])
	love.graphics.line(self.pos.x, self.pos.y, self.pos.x+1, self.pos.y+self.h)
	love.graphics.setColor(self.shadingColor[3])
	love.graphics.line(self.pos.x+self.w, self.pos.y+self.h, self.pos.x, self.pos.y+self.h)
	
	
	if self.over then
		love.graphics.setColor(255,255,255,100)
		love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.w, self.h)

	end

	local x, y
	local font = love.graphics.getFont()
	local textWidth = 0
	if font then textWidth = font:getWidth(self.text) end
	local textHeight = 0
	if font then textHeight = font:getHeight() end
	textHeight = textHeight + 4
	love.graphics.setColor(255,255,255,32)
	love.graphics.printf(self.text, self.pos.x+2, self.pos.y+self.h/2-textHeight/2+2, self.w, "center")
	love.graphics.setColor(0,0,0,120)
	love.graphics.printf(self.text, self.pos.x+1, self.pos.y+self.h/2-textHeight/2+1, self.w, "center")
	love.graphics.setColor(self.fontColor)
	love.graphics.printf(self.text, self.pos.x, self.pos.y+self.h/2-textHeight/2, self.w, "center")
end

--------------------------------------------------------------------------------
-- drawing
--------------------------------------------------------------------------------

local update = function(self, dt)
	local x, y = love.mouse.getX()/self.scale, love.mouse.getY()/self.scale
	if  x > self.pos.x and x < self.pos.x + self.w and y > self.pos.y and y < self.pos.y + self.h then
		self.over = true
	else
		self.over = false
	end
end

--------------------------------------------------------------------------------
-- Constructor
--------------------------------------------------------------------------------

local new = function(options)
	local obj = Entity(options.parent, 0, 0)
	for k,v in pairs(default) do
		obj[k] = v
	end
	obj.scale = options.scale or obj.scale

	obj.w = options.w or default.w
	obj.h = options.h or default.h
	obj.text = options.text or "Button"

	obj.dynamicWidth = options.dynamicWidth
	if obj.dynamicWidth then
		obj.w = love.graphics.getFont():getWidth(obj.text) + default.margin * 2
	end
	
	if options.parent.next then
		options.parent.next(obj)
	end

	if options.pos then
		obj.pos.x, obj.pos.y = obj.pos.x + options.pos.x, obj.pos.y + options.pos.y
	end
	
	obj.draw = options.draw or draw
	obj.update = options.update or update
	obj.onClick = options.onClick
	obj.mousepressed = function(self)
		if self.over then self.onClick(obj) end
	end
	return obj
end

UIButton = new

return UIButton