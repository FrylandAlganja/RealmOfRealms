Game = (function ()
    local self = {}

    self.cellWidth = 32
    self.entities = {}
    self.windowWidth = 800
    self.windowHeight = 450

    self.camera = (function ()
    	self.x = 0
    	self.y = 0
    	self.center = function (target)
    	    self.x = target.x - math.floor(self.windowWidth / 2)
    	    self.y = target.y - math.floor(self.windowHeight / 2)
    	end

    	return self
    end)()

    return self
end)()