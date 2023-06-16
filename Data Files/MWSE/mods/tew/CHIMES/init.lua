-- This runs before any other `main.lua` files to expose our classes to CHIMES-compatible chart definitions
local CHIMES = {}

CHIMES.Biomes = require("tew.CHIMES.components.Biomes")
CHIMES.Explore = require("tew.CHIMES.components.Explore")
CHIMES.Towns = require("tew.CHIMES.components.Towns")
CHIMES.Interiors = require("tew.CHIMES.components.Interiors")
CHIMES.Taverns = require("tew.CHIMES.components.Taverns")
CHIMES.Weathers = require("tew.CHIMES.components.Weathers")

return CHIMES