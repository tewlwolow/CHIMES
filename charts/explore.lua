-- Do not modify - required for interop to work

-- Import CHIMES namespace and make sure it successful
local CHIMES = include("tew.CHIMES")
if not CHIMES then return end

---------------------------------------------------

-- Make your changes here
local chart = {
	name = "explore",
	data =
	{
		{
			id = "Explore",
			folder = "explore"
		}
	}
}

---------------------------------------------------
-- Do not modify - required for interop to work

-- Create instance of the class
CHIMES.Explore(chart)