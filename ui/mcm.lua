local configPath = "CHIMES"
local config = require("tew.CHIMES.config")
local metadata = require("tew.CHIMES.metadata")
local version = metadata.version
local i18n = mwse.loadTranslations("tew.CHIMES")
local messages = i18n("messages")

local function registerVariable(id)
    return mwse.mcm.createTableVariable{
        id = id,
        table = config
    }
end

local template = mwse.mcm.createTemplate{
    name="CHIMES",
    headerImagePath="\\Textures\\tew\\CHIMES\\chimes_logo.tga"}

    local mainPage = template:createPage{label=messages.mainSettings, noScroll=true}
    mainPage:createCategory{
        label = string.format("CHIMES %s\n%s %s\n\n%s:", version, messages.authors, messages.modDescription, messages.settings)
    }

template:saveOnClose(configPath, config)
mwse.mcm.register(template)

