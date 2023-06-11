-- When translating these, please make sure that punctuation, case, and spacing is preserved. --
------------------------------------------------------------------------------------------------
local en = {}

en.messages = {
	mainSettings = "Main Settings",
	authors = "by tewlwolow and Morrowind Modding Community.",
	modDescription = "Simple and lightweight lua-based music system.",
	settings = "Settings",
	default = "Default",
	open = "Open",
	close = "Close",
	save = "Save",

	superMatch = "More than one cell type detected. You may want to verify your config to exclude cross-matches. Cell types detected:",
	priority = "Priority",
	cellType = "cell type",
	priorityMessage = "CHIMES will use a higher priority item.",

	nexusLink = "CHIMES on NexusMods",

	exteriorsPage = "Exteriors",
	minStatics = "Minimum number of statics that needs to be detected for tileset matching.",

	validationStarted = "Validating chart: %s of class %s.",
	importStarted = "Starting import for chart: ",
	itemTrackImport = "Importing tracks for item: ",
	trackImport = "Importing track: ",
	nonMP3 = "Found non-MP3 file. Skipping.",
	editPriority = "Edit chart priority",
	enableDebug = "Enable debug messages?",
	priorityPage = "Priority Editor"
}

en.errors = {
	valueInvalid = "Invalid value: <%s> for field: <%s>.",
	dataFieldInvalidType = "Invalid type for data item with key #%s.",
	itemFieldInvalid = "Invalid value: <%s> for field: <%s> in item: #%s.",
	typeExpectedGot = "Expected type: <%s>, got: <%s>.",
	extraChartField = "Chart field: <%s> with value: <%s> not found in schema.",
	missingRequired = "Missing one or more required fields for item #%s.",
	mutuallyExclusive = "Found both mutually exclusive fields for item #%s.",
	weatherRequiredFields = "Expected either 'disable' or 'folder' fields.",

	errorsFound = "ERRORS FOUND:",

	fixErrors = "Please make sure the errors are fixed.",
	reminder = "The mod will continue to work, but might behave in unexpected ways.",
	questions = "Feel free to ask here in case of questions:"
}

return en
