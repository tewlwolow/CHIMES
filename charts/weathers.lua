-- Do not modify - required for interop to work

-- Import CHIMES namespace and make sure it successful
local CHIMES = include("tew.CHIMES")
if not CHIMES then return end

---------------------------------------------------

-- Make your changes here
local chart = {
	name = "weathers",
	data =
	{
		{
			id = "Ashstorm",
			disable = "true"
		},
		{
			id = "Blight",
			disable = true
		},
		{
			id = "Blizzard",
			disable = true
		},
		{
			id = "Thunderstorm",
			disable = true,
			folder = "thunderstorm"
		},
		{
			id = "Rain",
			folder = "rain"
		},
		{
			id = "Snow",
			folder = "snow"
		},
		{
			id = "Foggy",
		}
	}
}

---------------------------------------------------
-- Do not modify - required for interop to work

-- Create instance of the class
CHIMES.Weathers(chart)