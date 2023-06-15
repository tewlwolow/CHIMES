local resolver = {}

local catalogue = require("tew.CHIMES.cache.catalogue")

local defaultPriority = {
	[1] = {
		name = "CHIMESTavernsChart",
		charts = {}
	},
	[2] = {
		name = "CHIMESInteriorsChart",
		charts = {}
	},
	[3] = {
		name = "CHIMESExteriorsChart",
		charts = {}
	},
	[4] = {
		name = "CHIMESBiomesChart",
		charts = {}
	},
	[5] = {
		name = "CHIMESWeathersChart",
		charts = {}
	},
	[6] = {
		name = "CHIMESExploreChart",
		charts = {}
	}
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
		for index, class in pairs(priority) do
			local className = class.name
			for _, chart in ipairs(catalogue[className]) do
				if not table.find(priority[index].charts, chart.name) then
					priority[index].charts[#priority[index].charts + 1] = chart.name
				end
			end
		end
		resolver.savePriority(priority)
		return json.loadfile(priorityPath)
	else
		return resolver.createPriority()
	end
end

function resolver.savePriority(priority)
	saveJSON(priority)
end


return resolver