-- Import CHIMES namespace and make sure it successful
local CHIMES = include("tew.CHIMES")
if not CHIMES then return end

-- Get info about the source file
local path = string.sub(debug.getinfo(1).source, 12, -1)

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

-- Create instance of the class
CHIMES.Taverns(chart, path)