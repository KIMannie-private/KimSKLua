client.log("     Get good Get gamesense")
client.color_log(0, 255, 216, "[gamesense] @author KIMAnnie")
client.color_log(0, 255, 216, "[gamesense] ♛KIM-MASTER.CFG♛")
client.color_log(0, 255, 216, "[gamesense] AA lua V4: 2020/04/07")
client.color_log(0, 255, 216, "[gamesense] CFG Update: 2020/04/07")
client.color_log(0, 255, 0, "[gamesense] For premium&id=????")

local s = require "./♛KIM-Beta♛/KL- AimLog"
local s = require "./♛KIM-Beta♛/helper"

client.log("Wrapper Enabling...")
local x = nil

require("./♛KIM-Beta♛/KIM/havoc_zeus_warning_config")
require("./♛KIM-Beta♛/KIM/havoc_zeus_warning")


require("./♛KIM-Beta♛/KIM/KS- KIM Best AA-V4")
require("./♛KIM-Beta♛/KIM/KS- skybox_changer")
require("./♛KIM-Beta♛/KIM/KS- quick_peek")
require("./♛KIM-Beta♛/KIM/KS- KimAnnieDT")

x = require("./♛KIM-Beta♛/KIM/KS- adaptive")
x.auth()
require("./♛KIM-Beta♛/KIM/KS- alive3-Fix")

require("./♛KIM-Beta♛/KIM/KL- Fake Indicators")
require("./♛KIM-Beta♛/KIM/KL- KIM")
require("./♛KIM-Beta♛/KIM/KL- hud print chat")
require("./♛KIM-Beta♛/KIM/KL- grenade_esp")
require("./♛KIM-Beta♛/KIM/KL- Indicators")
require("./♛KIM-Beta♛/KIM/KL- havoc_announcer_1_4")
require("./♛KIM-Beta♛/KIM/KL- ChenRainbow")
require("./♛KIM-Beta♛/KIM/KL- watermark")

require("./♛KIM-Beta♛/KIM/KK- Twin Towers")
require("./♛KIM-Beta♛/KIM/KK- Twin clantag")
require("./♛KIM-Beta♛/KIM/KK- autobuy")
require("./♛KIM-Beta♛/KIM/KK- KANTOUPIAO")



--x = require("./♛KIM-Beta♛/KIM/KS- exploit")
--x.auth()

require("./♛KIM-Beta♛/KK- bloom")
require("./♛KIM-Beta♛/KK- fudu")
require("./♛KIM-Beta♛/KK- spam_Dabeizhou")
require("./♛KIM-Beta♛/KL- AimLog")

require("./♛KIM-Beta♛/neverlose")

















client.log("Wrapper Enabled")
client.color_log(255, 0, 255, "All ♛KIM-MASTER.♛ luas r loaded")