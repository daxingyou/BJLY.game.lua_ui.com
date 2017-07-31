

local UILayer = {
    Common = {
        LayerTipError = require("app.game.ui.common.LayerTipError"),
    },
    Main = require("app.game.ui.main.MainUIInit"),
    SecondLevel = {
    	LayerConfirmLogout = require("app.game.ui.SecondLevelLayer.LayerConfirmLogout")
    },
    RoomScene = {
    	LayerChat = require("app.game.ui.RoomSceneLayer.LayerChat")
    },

}
return UILayer