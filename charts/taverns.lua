-- Do not modify - required for interop to work

-- Import CHIMES namespace and make sure it successful
local CHIMES = include("tew.CHIMES")
if not CHIMES then return end

---------------------------------------------------

-- Make your changes here
local chart = {
	name = "taverns",
	useRaces = "true",
	data =
	{
		{
			id = "Dark Elf",
			folder = "dark elf"
		},
		{
			id = "Imperial",
			folder = "imperial"
		},
		{
			id = "Nord",
			folder = "nord"
		}
	}
}

---------------------------------------------------
-- Do not modify - required for interop to work

-- Create instance of the class
CHIMES.Taverns(chart)