local sorter = {}

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
		name = "CHIMESTownsChart",
		charts = {}
	},
	[4] = {
		name = "CHIMESWeathersChart",
		charts = {}
	},
	[5] = {
		name = "CHIMESBiomesChart",
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

function sorter.createPriority()
	saveJSON(defaultPriority)
	return json.loadfile(priorityPath)
end

function sorter.loadPriority()
	local priority = json.loadfile(priorityPath)
	if priority then
		for index, class in pairs(priority) do
			local className = class.name
			local catalogueChartNames = {}
			for _, chart in ipairs(catalogue[className]) do
				if not table.find(priority[index].charts, chart.name) then
					priority[index].charts[#priority[index].charts + 1] = chart.name
				end
				table.insert(catalogueChartNames, chart.name)
			end
			if not table.empty(catalogueChartNames) then
				for catIndex, catChart in ipairs(class.charts) do
					if not table.find(catalogueChartNames, catChart) then
						table.remove(class.charts, catIndex)
					end
				end
			end
		end
		sorter.savePriority(priority)
		return json.loadfile(priorityPath)
	else
		return sorter.createPriority()
	end
end

function sorter.savePriority(priority)
	saveJSON(priority)
end


return sorter