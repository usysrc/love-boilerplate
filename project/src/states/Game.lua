--
--  Game
--

local Gamestate     = require (LIBRARYPATH.."hump.gamestate")
local timer         = require (LIBRARYPATH.."hump.timer")
local Vector        = require (LIBRARYPATH.."hump.vector"	)
local tween         = timer.tween

Game = Gamestate.new()

local color = { 255, 255, 255, 0 }

local center = {
    x = love.graphics.getWidth() / 2, 
    y = love.graphics.getHeight() / 2
}

local bigFont   =   love.graphics.newFont(32)
local smallFont =   love.graphics.newFont(16)

local stage

function Game:enter()
    stage = Stage()
    for i=1,50 do
	    local rectangle = Entity(stage, math.random(0,800), math.random(0,600))
	    rectangle.w, rectangle.h = math.random(16,32), math.random(16,32)
	    rectangle.r = 0
	    rectangle.rect = true
	    rectangle.go = Vector(math.random(-1,1)*32, math.random(-1,1)*32)
	    rectangle.update = function(self, dt)
	    	self.pos = self.pos + self.go * dt
	    	if self.pos.x < 0 or self.pos.y < 0 then
	    		self.pos = Vector(math.random(0,800), math.random(0,600))
	    	end
		end

	    rectangle.draw = function(self)
	    	love.graphics.setColor(255,255,255)
	    	love.graphics.rectangle("line", self.pos.x-self.w/2, self.pos.y-self.h/2, self.w, self.h)
		end
	end

	local ship = Entity(stage, 600, 200)
    ship.w, ship.h = 32, 32
    ship.r = 0

    ship.draw = function(self)
    	love.graphics.setColor(255,255,255)
    	love.graphics.rectangle("line", self.pos.x-self.w/2, self.pos.y-self.h/2, self.w, self.h)
    	love.graphics.circle("fill", self.pos.x ,self.pos.y, 4, 32)
	end

	ship.update = function(self, dt)
		self.vec = self.vec or {x=0, y=0}
		local a = 100
		if love.keyboard.isDown("left") then
			self.vec.x = self.vec.x-dt*a
		end
		if love.keyboard.isDown("right") then
			self.vec.x = self.vec.x+dt*a
		end
		if love.keyboard.isDown("up") then
			self.vec.y = self.vec.y-dt*a
		end
		if love.keyboard.isDown("down") then
			self.vec.y = self.vec.y+dt*a
		end
		self.vec.x = self.vec.x*0.96
		self.vec.y =  self.vec.y*0.96
		if math.abs(self.vec.x) > 10 then self.vec.x = self.vec.x*0.9 end
		if math.abs(self.vec.y) > 10 then self.vec.y =  self.vec.y*0.9 end

		self.pos.x = self.pos.x + self.vec.x*dt*10
		self.pos.y = self.pos.y + self.vec.y*dt*10
	end

	ship.collision = function(self, other)
		if other.rect then
			other.dead = true
		end
	end


end

function Game:update( dt )
    timer.update(dt)
    stage:update(dt)
end

function Game:draw()
    stage:draw()
    love.graphics.print(love.timer.getFPS(), 0, 0)
end