local taverns = {}

local catalogue = require("tew.CHIMES.cache.catalogue")

taverns.item = nil

function taverns.isRelevant()
	local cell = tes3.player.cell
	if not cell then return end
	if cell.isOrBehavesAsExterior then return end

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

			local charts = catalogue.CHIMESTavernsChart
			for _, chart in ipairs(charts) do
				if not chart.useRaces then
					taverns.item = chart.data[1]
					return true
				else
					for _, item in ipairs(chart.data) do
						if (item.id:lower() == race) or (item.id:lower() == "fallback") then
							taverns.item = item
							return true
						end
					end
				end
			end
		end
	end
end

return taverns