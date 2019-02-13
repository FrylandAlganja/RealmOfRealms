require 'game'
require 'map'
require 'entities'

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

local startPosition = Game.map.getVacantTile()
local p = Game.Player((startPosition.x - 1) * Game.cellWidth, (startPosition.y - 1) * Game.cellWidth)

function love.update ()
	if step() then
		p.vx = 0
		p.vy = 0
		if love.keyboard.isDown("up") then
			p.vy = -8
		end
		if love.keyboard.isDown("down") then
			p.vy = 8
		end
		if love.keyboard.isDown("right") then
			p.vx = 8
		end
		if love.keyboard.isDown("left") then
			p.vx = -8
		end

		if p.vx ~= 0 then
		    p.x = p.x + p.vx
			for y = 1, Game.mapHeight do
				for x = 1, Game.mapWidth do
					local tile = Game.map[(y * Game.mapWidth) + x]

					if tile.active and tile.wall and Game.collides(tile, p) then
						while Game.collides(tile, p) do
							local xDiff = math.abs(p.x - tile.x)
							local yDiff = math.abs(p.y - tile.y)
							if p.vx > 0 then
								p.x = p.x - 1
							elseif p.vx < 0 then
								p.x = p.x + 1
							end
						end
					end
				end
			end
		end
        
        if p.vy ~= 0 then
			p.y = p.y + p.vy
			for y = 1, Game.mapHeight do
				for x = 1, Game.mapWidth do
					local tile = Game.map[(y * Game.mapWidth) + x]

					if tile.active and tile.wall and Game.collides(tile, p) then
						while Game.collides(tile, p) do
							if (p.vy > 0) then
								p.y = p.y - 1
							elseif (p.vy < 0) then
								p.y = p.y + 1
							end
						end
					end
				end
			end
		end


	end
end

function love.draw()
	Game.camera.center(p)
	for y=1,Game.mapHeight do
		for x=1,Game.mapWidth do
			local tile = Game.map[(y * Game.mapWidth) + x]
		    if tile.active then
	     		tile.draw()
			end
		end
	end
	p.draw()

	--love.graphics.draw(Game.map.minimap)

	love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 0, 0)
end