-- Do not modify - required for interop to work

-- Import CHIMES namespace and make sure it successful
local CHIMES = include("tew.CHIMES")
if not CHIMES then return end

---------------------------------------------------

-- Make your changes here
local chart = {
	name = "exteriors",
	data =
	{
		{
			id = "Hlaalu",
			folder = "hlaalu",
			method = "tileset",
			strings = {
				"ex_hlaalu_",
				"mal_balmora_"
			}
		},
		{
			id = "Redoran",
			method = "tileset",
			strings = {
				"ex_redoran_"
			}
		},
		{
			id = "Vivec",
			folder = "vivec",
			method = "tileset",
			strings = {
				"ex_vivec",
				"ex_mh_"
			}
		},
		{
			id = "Telvanni",
			folder = "telvanni",
			method = "tileset",
			strings = {
				"ex_t_"
			}
		},
		{
			id = "Imperial",
			folder = "imperial",
			strings = {
				"ex_common_",
				"ex_imp"
			}
		},
		{
			id = "Nord",
			folder = "nord",
			method = "tileset",
			strings = {
				"ex_nord_",
				"ex_s_",
				"t_rga_setreach"
			}
		},
		{
			id = "Towns",
			folder = "towns",
			method = "tileset",
			strings = {
				"ex_de_shack"
			}
		},
		{
			id = "Ashlander",
			folder = "ashlander",
			method = "tileset",
			strings = {
				"ex_ashl_"
			}
		}
	}
}

---------------------------------------------------
-- Do not modify - required for interop to work

-- Create instance of the class
CHIMES.Exteriors(chart)