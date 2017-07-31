
local m = {
    UIActivity = require("app.game.ui.main.LayerActivity"),
    UIAddCard = require("app.game.ui.main.LayerAddCard"),
    UIBinding = require("app.game.ui.main.LayerBinding"),
    UIFeedback = require("app.game.ui.main.LayerFeedback"),
    UIJoinRoom = require("app.game.ui.main.LayerJoinRoom"),
    UICreateRoom = require("app.game.ui.main.CreateRoomLayer"),
    UIMessage = require("app.game.ui.main.LayerMessage"),
    UIRecord = require("app.game.ui.main.LayerRecord"),
    UIRule = require("app.game.ui.main.LayerRule"),
    UISelfInfo = require("app.game.ui.main.LayerSelfInfo"),
    UISetting = require("app.game.ui.main.LayerSetting"),
    UIShare = require("app.game.ui.main.LayerShare"),
    UIBindConfirm = require("app.game.ui.main.LayerBindConfirm"),
    UIReslutTotal = require("app.game.ui.main.LayerResultFinal"),
    UIReslutDetail = require("app.game.ui.main.LayerResultDetail"),
    UIQuitLayer = require("app.game.ui.main.LayerQuit"),
    UIDelegateRoomLsyer = require("app.game.ui.main.LayerDelegateRoom"),
}

return m