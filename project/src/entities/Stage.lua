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
		local hash = {}
		local size = {x=64,y=64}
		local check = {}
		for i=#self.objects,1,-1 do
			local v = self.objects[i]
			if v then
				v:update(dt)
				if v.dead then
					if v.remove then v:remove() end
					table.remove(self.objects, i)
				elseif v.pos then
					-- put into hash
					local gx, gy = math.ceil(v.pos.x/size.x), math.ceil(v.pos.y/size.y)
					local idx = gx..","..gy
					hash[idx] = hash[idx] or {}
					table.insert(hash[idx], v)
					if #hash[idx] > 1 then check[idx] = hash[idx] end

					if v.w then
						local gx, gy = math.ceil((v.pos.x+v.w/2)/size.x), math.ceil((v.pos.y-v.h/2)/size.y)
						local idx2 = gx..","..gy
						if idx2 ~= idx then
							hash[idx2] = hash[idx2] or {}
							table.insert(hash[idx2], v)
							if #hash[idx2] > 1 then check[idx2] = hash[idx2] end
						end

						local gx, gy = math.ceil((v.pos.x-v.w/2)/size.x), math.ceil((v.pos.y-v.h/2)/size.y)
						local idx2 = gx..","..gy
						if idx2 ~= idx then
							hash[idx2] = hash[idx2] or {}
							table.insert(hash[idx2], v)
							if #hash[idx2] > 1 then check[idx2] = hash[idx2] end
						end

						local gx, gy = math.ceil((v.pos.x+v.w/2)/size.x), math.ceil((v.pos.y+v.h/2)/size.y)
						local idx2 = gx..","..gy
						if idx2 ~= idx then
							hash[idx2] = hash[idx2] or {}
							table.insert(hash[idx2], v)
							if #hash[idx2] > 1 then check[idx2] = hash[idx2] end
						end

						local gx, gy = math.ceil((v.pos.x-v.w/2)/size.x), math.ceil((v.pos.y+v.h/2)/size.y)
						local idx2 = gx..","..gy
						if idx2 ~= idx then
							hash[idx2] = hash[idx2] or {}
							table.insert(hash[idx2], v)
							if #hash[idx2] > 1 then check[idx2] = hash[idx2] end
						end
					end

				end
			end
		end

		for k,table in pairs(check) do
			for _,v in ipairs(table) do
				if not v.dead then
					for _,vv in ipairs(table) do
						if not vv.dead and vv ~= v and v:intersects(vv) then
							v:collision(vv)
						end
					end
				end
			end
		end


	end,
	draw = function(self)
		love.graphics.push()
		love.graphics.translate(self.pos.x, self.pos.y)
		for i,v in ipairs(self.objects) do
			v:draw()
		end
		love.graphics.pop()
		for i=1, 32 do
			love.graphics.line(0,i*64,800,i*64)
			love.graphics.line(i*64,0,i*64,600)
		end
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