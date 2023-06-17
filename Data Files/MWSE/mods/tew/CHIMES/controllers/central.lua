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
			debug.log(currentItem.folder)
			if previousItem then
				debug.log(previousItem.folder)
			end
			currentTrack = trackSelector.selectNew(currentItem, previousTrack)
			music.play(currentTrack)
			previousTrack = currentTrack
			previousItem = currentItem
		end
	end
end

function central.override(e)
	if tes3.player.mobile.inCombat then return end
	local controller = resolver.resolveController()
	if controller then
		currentItem = controller.item
		if ((previousItem) and (previousItem.folder ~= currentItem.folder)) or not (previousItem) then
			currentTrack = trackSelector.selectNew(currentItem, previousTrack)
			music.play(currentTrack)
			e.music = currentTrack
			e.situation = tes3.musicSituation.explore
			previousTrack = currentTrack
			previousItem = currentItem
		end
	end
end

function central.purge()
	previousItem = nil
	previousTrack = nil
end

return central