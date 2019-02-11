local tileWidth = 10
local Tile = function (tileX, tileY)
    local self = {}
    self.x = tileWidth * tileX
    self.y = tileWidth * tileY

	function self.draw ()
	    love.graphics.setColor(0, 100, 100)
	    love.graphics.rectangle("fill", self.x, self.y, 10, 10)
	end

    return self
end

local map = (function ()
	local self = {}
	for y=1, 23 do
		for x=1, 56 do
			if x == 1 or x == 11 or x == 23 or x == 34 or x == 45 or x == 56 or y == 1 or y == 11 or y == 23 then
				self[(y * 56) + x] = Tile(x - 1, y - 1)
			end
		end
	end
	return self
	end)()

local Player = function (startX, startY)
	local self = {}
	self.x = 0
	self.y = 0
	function self.draw ()
	    love.graphics.setColor(255, 255, 0)
	    love.graphics.rectangle("fill", self.x, self.y, 10, 10)
	end

	return self
end

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
	for y=1,23 do
		for x=1,56 do
			if map[(y * 56) + x] then
				map[(y * 56) + x].draw()
			end
		end
	end
	p.draw()
end