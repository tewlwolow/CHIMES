local resolver = {}

local defaultPriority = {
	[1] = "CHIMESTavernsChart",
	[2] = "CHIMESInteriorsChart",
	[3] = "CHIMESExteriorsChart",
	[4] = "CHIMESBiomesChart",
	[5] = "CHIMESWeathersChart",
	[6] = "CHIMESExploreChart"
}

local priorityPath = "config\\CHIMES\\priority"

local function saveJSON(tab)
	lfs.mkdir("Data Files\\MWSE\\config")
    lfs.mkdir("Data Files\\MWSE\\config\\CHIMES")
	json.savefile(priorityPath, tab)
end

function resolver.createPriority()
	saveJSON(defaultPriority)
	return json.loadfile(priorityPath)
end

function resolver.loadPriority()
	local priority = json.loadfile(priorityPath)
	if priority then
		return priority
	else
		return resolver.createPriority()
	end
end

function resolver.savePriority(priority)
	saveJSON(priority)
end


return resolver