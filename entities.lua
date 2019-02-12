require 'game'

Entity = function (x, y)
	local self = {}
	self.x = x
	self.y = y

	return self
end

Tile = function (tileX, tileY)
    local self = Entity(Game.cellWidth * tileX, Game.cellWidth * tileY)

	function self.draw ()
	    love.graphics.setColor(0, 100, 100)
	    love.graphics.rectangle("fill", self.x, self.y, Game.cellWidth, Game.cellWidth)
	end

    return self
end

Player = function (startX, startY)
	local self = Entity(startX, startY)
	function self.draw ()
	    love.graphics.setColor(255, 255, 0)
	    love.graphics.rectangle("fill", self.x, self.y, Game.cellWidth, Game.cellWidth)
	end

	return self
end

