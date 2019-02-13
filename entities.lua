require 'game'

Game.Entity = function (x, y)
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

Game.Tile = function (tileX, tileY, wall)
    local self = Game.Entity(Game.cellWidth * (tileX - 1), Game.cellWidth * (tileY - 1))
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

Game.Player = function (startX, startY)
	local self = Game.Entity(startX, startY)
	self.vx = 0
	self.vy = 0
	function self.draw ()
	    love.graphics.setColor(255, 255, 0)
	    love.graphics.rectangle("fill", self.graphicX(), self.graphicY(), Game.cellWidth, Game.cellWidth)
	end

	return self
end

