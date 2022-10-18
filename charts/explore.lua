-- Import CHIMES namespace
local CHIMES = include("tew.CHIMES")
if not CHIMES then return end

-- Get info about the source file
local path = string.sub(debug.getinfo(1).source, 12, -1)

---------------------------------------------------

-- Make your changes here
local chart = {
	name = "explore",
	data =  "Explore"
}

---------------------------------------------------

-- Create instance of the class
CHIMES.Explore(chart, path)