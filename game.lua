Game = (function ()
    local self = {}
    self.seed = math.randomseed(os.time())

    self.cellWidth = 8
    self.entities = {}
    self.windowWidth = 800
    self.windowHeight = 450
    self.map = {}

    self.camera = (function ()
    	self.x = 0
    	self.y = 0
    	self.center = function (target)
    	    self.x = target.x - math.floor(self.windowWidth / 2)
    	    self.y = target.y - math.floor(self.windowHeight / 2)
    	end

    	return self
    end)()

    self.collides = function (e1, e2)
        return e1.x < e2.x + e2.w and
               e2.x < e1.x + e1.w and
               e1.y < e2.y + e2.h and
               e2.y < e1.y + e1.h
    end

    return self
end)()