Game.mapWidth = 80
Game.mapHeight = 80

Game.map = (function ()
	local self = {}
	self.getVacantTile = function ()
	    local tileFound = false
	    local tile = {}
	    while tileFound == false do
	    	local x = math.floor(math.random() * 80)
	    	local y = math.floor(math.random() * 80)
	    	if (self[(y * Game.mapWidth) + x].active) then
	    		if (self[(y * Game.mapWidth) + x].wall == false) then
	    			tile = {x = x, y = y}
	    			tileFound = true
	    		end
	    	end
	    end
	    return tile
	end

	local createCircle = function (centerX, centerY, radius)
	    for y=centerY - radius, centerY + radius do
	    	for x=centerX - radius, centerX + radius do
	    		if math.sqrt((x - centerX)^2 + (y - centerY)^2) < radius then
                    self[(y * Game.mapWidth) + x] = Tile(x, y, false)
                end
            end
        end
    end

    local createSquare = function (centerX, centerY, halfWidth)
        for y = centerY - halfWidth, centerY + halfWidth do
        	for x = centerX - halfWidth, centerX + halfWidth do
        		self[(y * Game.mapWidth) + x] = Tile(x, y, false)
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
	        				    	    self[(y * Game.mapWidth) + x] = Tile(x, y, true)
	        				        end
	        				    end
	        				end
	        			end
	        		end
	        	end
        	end
        end
    end

    local digTunnel = function (p1, p2)
        while (p1.x ~= p2.x or p1.y ~= p2.y) do
        	if p1.x < p2.x then
        		p1.x = p1.x + 1
        	elseif p1.x > p2.x then
        		p1.x = p1.x - 1
        	end

        	if p1.y < p2.y then
        		p1.y = p1.y + 1
            elseif p1.y > p2.y then
                p1.y = p1.y - 1
            end
            createSquare(p1.x, p1.y, 1)
        end
    end

    local digRoom = function (centerX, centerY)
        createCircle(centerX, centerY, 5)
    	for i=1,5 do
			local dx = math.floor(math.random() * 10) - 5
			local dy = math.floor(math.random() * 10) - 5
			local chance = math.random()
			if (chance > .2) then
			    createCircle(centerX + dx, centerY + dy, 5)
			else
				createSquare(centerX + dx, centerY + dy, 5)
			end
		end
    end

    local roomCenters = {}
    for i=1,10 do
    	local centerX = math.floor(math.random() * 58) + 11
    	local centerY = math.floor(math.random() * 58) + 11
    	roomCenters[i] = {x = centerX, y = centerY}
        digRoom(centerX, centerY)
    end

    for i=1,9 do
    	digTunnel(roomCenters[i], roomCenters[i + 1])
    end

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

