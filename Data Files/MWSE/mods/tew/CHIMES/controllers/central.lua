local central = {}

local resolver = require("tew.CHIMES.util.resolver")
local trackSelector = require("tew.CHIMES.util.trackSelector")
local music = require("tew.CHIMES.services.music")

local previousItem = nil
local currentItem = nil
local previousTrack = nil
local currentTrack = nil

function central.check()
	if not tes3.player or (tes3.mobilePlayer and tes3.mobilePlayer.isDead) then return end
	if tes3.player.mobile.inCombat then	return end
	local controller = resolver.resolveController()
	if controller then
		currentItem = controller.item
		if not currentItem then return end
		if (currentItem.disable) or ((previousItem) and (previousItem.folder ~= currentItem.folder)) or not (previousItem) then
			debug.log(currentItem.folder)
			if previousItem then
				debug.log(previousItem.folder)
			end
			currentTrack = trackSelector.selectNew(currentItem, previousTrack)
			debug.log(currentTrack)
			music.play(currentTrack)
			previousTrack = currentTrack
			previousItem = currentItem
		end
	end
end

--- @param e musicSelectTrackEventData
function central.override(e)
	central.check()
	return false
end

function central.onMusicChangeTrack(e)

end


function central.purge()
	debug.log("Purging...")
	previousItem = nil
end

return central