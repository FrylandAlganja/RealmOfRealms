require 'game'
require 'entities'

love.window.setMode(Game.windowWidth, Game.windowHeight)

local map = (function ()
	local self = {}
	for y=1, 14 do
		for x=1, 25 do
			if x == 1 or x == 25 or y == 1 or y == 14 then
				self[(y * 56) + x] = Tile(x - 1, y - 1)
			end
		end
	end
	return self
	end)()

local step = (function ()
	msDelta = 0
	return (function ()
	    msDelta = msDelta + love.timer.getDelta()
	    if msDelta >= 0.017 then
		    msDelta = 0.017 - msDelta
		    return true
		else
			return false
		end
	end)
end)()

local p = Player(0, 0)

function love.update ()
	if step() then
		if love.keyboard.isDown("up") then
			p.y = p.y - 3
		end
		if love.keyboard.isDown("down") then
			p.y = p.y + 3
		end
		if love.keyboard.isDown("right") then
			p.x = p.x + 3
		end
		if love.keyboard.isDown("left") then
			p.x = p.x - 3
		end
	end
end

function love.draw()
	Game.camera.center(p)
	for y=1,23 do
		for x=1,56 do
			if map[(y * 56) + x] then
				map[(y * 56) + x].draw()
			end
		end
	end
	p.draw()

	love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 0, 0)
end