-- When translating these, please make sure that punctuation, case, and spacing is preserved. --
------------------------------------------------------------------------------------------------
local en = {}

en.messages = {
	mainSettings = "Main Settings",
	mainLabel = "by tewlwolow and Morrowind Modding Community.\nSimple and lightweight lua-based music system.",
	settings = "Settings",
	skipping = "Skipping.",

	validateInit = "Running initial chart validation.",
	validateFinished = "Charts validated.",
	chartImportInit = "Running import for chart:",
	chartImportFinished = "Chart loaded.",
	noFolderFound = "No folder found in file:",
	skippingImport = "Skipping import.",
	tracksInit = "Running track validation and import.",
	tracksFinished = "Tracks loaded.",
	fileOutOfChart = "Found file outside chart definitions:",
	interfaceInit = "Running interface functions.",
	interfaceFinished = "Interface functions finished.\n",

	superMatch = "More than one cell type detected. You may want to verify your config to exclude cross-matches. Cell types detected:",
	priority = "Priority",
	cellType = "cell type",
	priorityMessage = "CHIMES will use a higher priority item.",

	emptyStrings = "Empty strings found in file:",

	nexusLink = "CHIMES on NexusMods"
}

en.errors = {
	noChartNameFound = "No chart name found for file:",
	noChartDataFound = "No chart data found for file:",
	jsonLoadError = "JSON file could not be parsed. You should check for syntax errors. File:",
	noJSONFound = "Non-JSON file found in charts folder. Skipping.",
	noMethodFound = "No method found in file:",
	chartItemId = "Chart item id:",
	errorsFound = "ERRORS FOUND:",
	reminder = "Please make sure the errors are fixed.\nThe mod will continue to work, but might behave in unexpected ways.\nFeel free to ask here in case of questions:"
}

return en
