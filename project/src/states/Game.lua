--
--  Game
--

local Gamestate     = require (LIBRARYPATH.."hump.gamestate")
local pmath 		= require (LIBRARYPATH.."pale.math")
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

    local map = Map()
    for i=1, 50 do
    	local t = {blocked = true}
    	map:set(i, 1, t)
    	map:set(i, 36, t)
    end
    for i=1, 36 do
    	local t = {blocked = true}
    	map:set(1, i, t)
    	map:set(50,i, t)
    end
    stage.map = map
    

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
		local a = 1000
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

		if math.abs(self.vec.x) > 16 then self.vec.x = pmath.sig(self.vec.x)*16 end
		if math.abs(self.vec.y) > 16 then self.vec.y = pmath.sig(self.vec.y)*16 end
		
		self.movement = Vector(self.vec.x*dt*10, self.vec.y*dt*10)
		self:move(self.movement)
		-- self.pos.x = self.pos.x + self.movement.x
		-- self.pos.y = self.pos.y + self.movement.y
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