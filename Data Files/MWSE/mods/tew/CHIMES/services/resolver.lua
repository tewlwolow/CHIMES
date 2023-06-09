local resolver = {}
local cat = require("tew.CHIMES.cache.cat")

local defaultPriority = {
	[1] = cat.CHIMESTavernsChart,
	[2] = cat.CHIMESInteriorsChart,
	[3] = cat.CHIMESExteriorsChart,
	[4] = cat.CHIMESBiomesChart,
	[5] = cat.CHIMESWeathersChart,
	[6] = cat.CHIMESExploreChart
}

return resolver