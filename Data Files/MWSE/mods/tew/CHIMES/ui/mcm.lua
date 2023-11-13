local configPath = "CHIMES"
local config = require("tew.CHIMES.options.config")
local defaults = require("tew.CHIMES.options.defaults")
local priorityMenu = require("tew.CHIMES.ui.PriorityMenu")
local metadata = toml.loadMetadata("CHIMES")
local version = metadata.package.version
local i18n = mwse.loadTranslations("tew.CHIMES")
local messages = i18n("messages")

local function registerVariable(id)
    return mwse.mcm.createTableVariable {
        id = id,
        table = config,
    }
end

local template = mwse.mcm.createTemplate {
    name = "CHIMES",
    headerImagePath = "\\Textures\\tew\\CHIMES\\chimes_logo.tga" }

local mainPage = template:createPage {
    label = messages.mainSettings, noScroll = true,
}
mainPage:createCategory {
    label = string.format("CHIMES %s\n%s %s\n\n%s:", version, messages.authors, messages.modDescription, messages.settings),
}
local priorityButton = mainPage:createButton {
    id = "CHIMES_PriorityMenu_Button",
    buttonText = messages.openPriorityEditor,
    callback = function()
        priorityMenu.create()
    end,
}
priorityButton.paddingAllSides = 10
priorityButton.paddingBottom = nil
priorityButton.borderAllSides = 8
mainPage:createYesNoButton {
    label = messages.enableDebug,
    variable = registerVariable("debugLogOn"),
    restartRequired = true,
}

local townsPage = template:createPage {
    label = messages.townsPage,
}
townsPage:createSlider {
    label = string.format(" %s = %s\n%s", messages.default, defaults.minStatics, messages.minStatics),
    min = 0,
    max = 50,
    step = 1,
    jump = 10,
    variable = registerVariable("minStatics"),
}


template:saveOnClose(configPath, config)
mwse.mcm.register(template)
