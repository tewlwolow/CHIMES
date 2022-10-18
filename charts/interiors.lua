-- Do not modify - required for interop to work

-- Import CHIMES namespace and make sure it successful
local CHIMES = include("tew.CHIMES")
if not CHIMES then return end

---------------------------------------------------

-- Make your changes here
local chart = {
	name = "interiors",
	id = "interior",
	data =
	{
		{
			id = "Abandoned",
			folder = "abandoned",
			method = "tileset",
			strings = {
				"in_stronghold",
				"in_strong",
				"in_strongruin",
				"in_sewer",
				"t_ayl_dngruin",
				"t_bre_dngruin",
				"t_de_dngrtrongh",
				"t_he_dngdirenni",
				"t_imp_dngruincyr",
				"t_imp_dngsewers",
				"in_om_"
			}
		},
		{
			id = "Caves",
			folder = "caves",
			method = "tileset",
			strings = {
				"in_moldcave",
				"in_mudcave",
				"in_lavacave",
				"in_pycave",
				"in_bonecave",
				"in_bc_cave",
				"in_m_sewer",
				"in_sewer",
				"ab_in_kwama",
				"ab_in_lava",
				"ab_in_mvcave",
				"t_cyr_cavegc",
				"t_glb_cave",
				"t_mw_cave",
				"t_sky_cave",
				"bm_ic_",
				"bm_ka"
			}
		},
		{
			id = "Daedric",
			folder = "daedric",
			method = "tileset",
			strings = {
				"in_dae_hall",
				"in_dae_room",
				"in_dae_pillar",
				"t_dae_dngruin"
			}
		},
		{
			id = "Dwemer",
			folder = "dwemer",
			method = "tileset",
			strings = {
				"in_dwrv_hall",
				"in_dwrv_corr",
				"in_dwe_corr",
				"in_dwe_archway",
				"t_dwe_dngruin"
			}
		},
		{
			id = "Temples",
			folder = "temples",
			method = "names",
			strings = {
				"Temple",
				"Maar Gan, Shrine",
				"Vos Chapel",
				"High Fane",
				"Fane of the Ancestors",
				"Tiriramannu"
			}
		},
		{
			id = "Tombs",
			folder = "tombs",
			method = "names",
			strings = {
				"Tomb",
				"Burial",
				"Crypt",
				"Barrow",
				"Catacomb"
			}
		}
	}
}

---------------------------------------------------
-- Do not modify - required for interop to work

-- Create instance of the class
CHIMES.Interiors(chart)