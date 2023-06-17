local trackSelector = {}

local function getRandom(item)
	return string.format("%s\\%s", item.folder, table.choice(item.tracks))
end

function trackSelector.selectNew(item, previousTrack)
	local newTrack = getRandom(item)
	if #item.tracks > 1 then
		repeat newTrack = getRandom(item) until newTrack ~= previousTrack
	end
	return newTrack
end

return trackSelector