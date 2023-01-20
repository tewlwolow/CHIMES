local importer = {}

local cat = require("tew.CHIMES.cache.cat")
local log = require("tew.CHIMES.util.common").log

local i18n = mwse.loadTranslations("tew.CHIMES")
local messages = i18n("messages")

local musicFolder = "Data Files\\Music\\"

local function updateTracks(folder, array)
	for track in lfs.dir(musicFolder .. folder) do
		if track ~= ".." and track ~= "." then
			if string.endswith(track, ".mp3") then
				log(messages.trackImport .. track)
				table.insert(array, track)
			else
				log(messages.nonMP3)
			end
		end
	end
end

function importer.import(instance)
	log(messages.importStarted .. instance.chart.name)

	local i = #cat[instance.class] + 1
	cat[instance.class][i] = instance.chart
	for _, item in pairs(cat[instance.class][i].data) do
		if item.folder then
			item.tracks = {}
			log(messages.itemTrackImport .. item.id)
			updateTracks(item.folder, item.tracks)
		end
	end
end

return importer