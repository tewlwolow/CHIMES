local taverns = {}

local catalogue = require("tew.CHIMES.cache.catalogue")

taverns.folder = nil

function taverns.isRelevant()
	local cell = tes3.player.cell
	if not cell then return end

	for npc in cell:iterateReferences(tes3.objectType.npc) do
		local class = npc.object.class.id
        if (
			(class) and
			(class == "Publican") or
			(class == "T_Sky_Publican") or
			(class == "T_Cyr_Publican")
		)
		-- and (npc.object.mobile and not npc.object.mobile.isDead)
		then
			local race = npc.object.race.id:lower()

			local charts = catalogue.CHIMESBiomesChart
			for _, chart in ipairs(charts) do
				if not chart.useRaces then
					taverns.folder = chart.data[1].folder
					return true
				else
					for _, item in ipairs(chart.data) do
						if item.id:lower() == race then
							taverns.folder = item.folder
							return true
						end
					end
					if chart.fallbackFolder then
						taverns.folder = chart.fallbackFolder
						return true
					end
				end
			end
		end
	end
end

return taverns