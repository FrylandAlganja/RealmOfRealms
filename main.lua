local x = 0

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
function love.draw()
	if (step()) then
		x = x + 3
	end
	love.graphics.print(string.sub(tostring(delta), 1, 5), x, 0)
end