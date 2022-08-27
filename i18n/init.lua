-- DO NOT MODIFY THIS --
------------------------------------------------------------------------------------------------
local log = require("tew.CHIMES.common").log

log("Starting translation verification.")

local defaultLanguage = require("tew.CHIMES.i18n.en")
local config = require("tew.CHIMES.config")
local language = require(config.language)

table.copymissing(language, defaultLanguage)

log("Translation verified. Missing values have been filled in with defaults.")
