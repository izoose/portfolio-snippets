local NotificationModule = require(game.ReplicatedStorage.MainModule)
local config = {
	title = "New Update!",
	description = "A new update has been released. Would you like to see the changelog?",
	buttons = {
		{
			ButtonText = "View",
			ButtonType = "Success",
			ButtonAction = { 
				type = "onClick",
				action = function (gui)
					print("hi")
				end,
			}
		},
		{
			ButtonText = "Close",
			ButtonType = "Danger",
			ButtonAction = { 
				type = "close",
			}
		}
	},
	style = NotificationModule.Styles.Random(),
	disableClose = true
}
local gui = NotificationModule.createNotification(config)
local displayConfig = {
	Gui = gui,
	plr = game.Players.LocalPlayer
}
NotificationModule.displayNotification(displayConfig)
