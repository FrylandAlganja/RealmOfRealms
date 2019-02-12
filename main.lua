require 'game'
require 'entities'
require 'map'

love.window.setMode(Game.windowWidth, Game.windowHeight)

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
			p.y = p.y - 8
		end
		if love.keyboard.isDown("down") then
			p.y = p.y + 8
		end
		if love.keyboard.isDown("right") then
			p.x = p.x + 8
		end
		if love.keyboard.isDown("left") then
			p.x = p.x - 8
		end
	end
end

function love.draw()
	Game.camera.center(p)
	for y=1,Game.mapHeight do
		for x=1,Game.mapWidth do
			if Game.map[(y * Game.mapWidth) + x].active then
				if Game.collides(Game.map[(y * Game.mapWidth) + x], p) == false then
				    Game.map[(y * Game.mapWidth) + x].draw()
				end
			end
		end
	end
	p.draw()

	love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 0, 0)
end