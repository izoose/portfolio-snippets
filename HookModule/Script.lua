local module = require(game.ServerStorage.MainModule)

local embed = module.Embed()
	:SetTitle("Embed Test")
	:SetDescription("This is a test embed with a selected color.")
	:SetColor(module.Colors.DarkBlue)
	:AddField("Field 1", "Value 1", true)
	:SetFooter("Footer text", "https://example.com/icon.png")
	:Post("embed url here lol")

