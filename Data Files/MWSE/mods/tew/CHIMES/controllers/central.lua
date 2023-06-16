local central = {}

local resolver = require("tew.CHIMES.util.resolver")
local trackSelector = require("tew.CHIMES.util.trackSelector")
local music = require("tew.CHIMES.services.music")

local previousItem = nil
local currentItem = nil
local previousTrack = nil
local currentTrack = nil

function central.check()
	local controller = resolver.resolveController()
	if controller then
		currentItem = controller.item
		if ((previousItem) and (previousItem.folder ~= currentItem.folder)) or not (previousItem) then
			currentTrack = trackSelector.selectNew(currentItem, previousTrack)
			debug.log(currentTrack)
			music.play(currentTrack)
			previousTrack = currentTrack
			previousItem = currentItem
		end
	end
end

return central