local configPath = "CHIMES"
local config = require("tew.CHIMES.options.config")
local defaults = require("tew.CHIMES.options.defaults")
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
    name = "CHIMES",
    headerImagePath = "\\Textures\\tew\\CHIMES\\chimes_logo.tga"}

    local mainPage = template:createPage{
        label = messages.mainSettings, noScroll=true
    }
    mainPage:createCategory{
        label = string.format("CHIMES %s\n%s %s\n\n%s:", version, messages.authors, messages.modDescription, messages.settings)
    }

    local exteriorsPage = template:createPage{
        label = messages.exteriorsPage
    }
    exteriorsPage:createSlider {
        label = string.format(" %s = %s\n%s", messages.default, defaults.minStatics, messages.minStatics),
        min = 0,
        max = 50,
        step = 1,
        jump = 10,
        variable = registerVariable("minStatics")
    }

template:saveOnClose(configPath, config)
mwse.mcm.register(template)

