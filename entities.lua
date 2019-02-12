require 'game'

Entity = function (x, y)
	local self = {}
	self.active = true
	self.x = x
	self.y = y
	self.w = Game.cellWidth
	self.h = Game.cellWidth

	self.graphicX = function ()
	    return self.x - Game.camera.x
	end

    self.graphicY = function ()
    	return self.y - Game.camera.y
    end

	return self
end

Tile = function (tileX, tileY, wall)
    local self = Entity(Game.cellWidth * tileX, Game.cellWidth * tileY)
    self.wall = wall

	function self.draw ()
		if self.wall then
	        love.graphics.setColor(0, 100, 100)
	    else
	    	love.graphics.setColor(50, 50, 50)
	    end
	    love.graphics.rectangle("fill", self.graphicX(), self.graphicY(), Game.cellWidth, Game.cellWidth)
	end

    return self
end

Player = function (startX, startY)
	local self = Entity(startX, startY)
	function self.draw ()
	    love.graphics.setColor(255, 255, 0)
	    love.graphics.rectangle("fill", self.graphicX(), self.graphicY(), Game.cellWidth, Game.cellWidth)
	end

	return self
end

