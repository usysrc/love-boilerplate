---@diagnostic disable: duplicate-set-field
--
--
--  Created by Tilmann Hars
--
require("libs.strict")
require("globals")

local Gamestate = requireLibrary("hump.gamestate")

-- Require all files in a folder and its subfolders, this way we do not have to require every new file
local function recursiveRequire(folder, subtree)
	local tree = subtree or {}
	for _, file in ipairs(love.filesystem.getDirectoryItems(folder)) do
		local filename = folder .. "/" .. file
		if love.filesystem.getInfo(filename, "directory") then
			recursiveRequire(filename)
		elseif file ~= ".DS_Store" then
			require(filename:gsub(".lua", ""))
		end
	end
	return tree
end

-- Initialization
function love.load()
	math.randomseed(os.time())
	love.graphics.setDefaultFilter("nearest", "nearest")
	-- love.mouse.setVisible(false)
	-- print "Require Sources:"
	recursiveRequire("src")
	Gamestate.registerEvents()
	Gamestate.switch(Game)
end

-- Logic
function love.update() end

-- Rendering
function love.draw() end

-- Input
function love.keypressed() end

function love.keyreleased() end

function love.mousepressed() end

function love.mousereleased() end

function love.joystickpressed() end

function love.joystickreleased() end

-- Get console output working with sublime text terminal
io.stdout:setvbuf("no")
