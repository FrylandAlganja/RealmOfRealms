Game.mapWidth = 80
Game.mapHeight = 80

Game.map = (function ()
	local self = {}
	local createCircle = function (centerX, centerY, radius)
	    for y=centerY - radius, centerY + radius do
	    	for x=centerX - radius, centerX + radius do
	    		if math.sqrt((x - centerX)^2 + (y - centerY)^2) < radius then
                    self[(y * Game.mapWidth) + x] = Tile(x - 1, y - 1, false)
                end
            end
        end
    end

    local wallUp = function ()
        for y=1, Game.mapHeight do
        	for x=1, Game.mapWidth do
        		if self[(y * Game.mapWidth) + x].active == false then
	        		--Check surrounding tiles to see if they are active
	        		for j=-1,1 do
	        			for i=-1,1 do
	        				local dx = x + i
	        				local dy = y + j
	        				if ((j == 0 and i == 0) == false) and
	        				   dx > 0 and dy > 0 and
	        				   dx <= Game.mapWidth and dy <= Game.mapHeight then
	        				    if self[(dy * Game.mapWidth) + dx].active then
	        				    	if self[(dy * Game.mapWidth) + dx].wall == false then
	        				    	    self[(y * Game.mapWidth) + x] = Tile(x - 1, y - 1, true)
	        				        end
	        				    end
	        				end
	        			end
	        		end
	        	end
        	end
        end
    end

    
    createCircle(40, 40, 20)
	for y=1, Game.mapHeight do
		for x=1, Game.mapWidth do
			if self[(y * Game.mapWidth) + x] == nil then
		    	self[(y * Game.mapWidth) + x] = {active = false}
			end
		end
	end
	wallUp()
	return self
	end)()

