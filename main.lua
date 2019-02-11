local x = 0

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
function love.draw()
	if (step()) then
		p.x = p.x + 3
	end
	p.draw()
end