local trackSelector = {}

local function getRandom(item)
	return string.format("%s\\%s", item.folder, table.choice(item.tracks))
end

function trackSelector.selectNew(item, previousTrack)
	local newTrack = getRandom(item)
	repeat
		newTrack = getRandom(item)
	until(newTrack ~= previousTrack)
	return newTrack
end

return trackSelector