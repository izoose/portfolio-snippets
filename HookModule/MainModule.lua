local module = {}

local HttpService = game:GetService("HttpService")

local Colors = { -- got from google lol
	Default = 0x000000,
	White = 0xffffff,
	Aqua = 0x1abc9c,
	Green = 0x57f287,
	Blue = 0x3498db,
	Yellow = 0xfee75c,
	Purple = 0x9b59b6,
	LuminousVividPink = 0xe91e63,
	Fuchsia = 0xeb459e,
	Gold = 0xf1c40f,
	Orange = 0xe67e22,
	Red = 0xed4245,
	Grey = 0x95a5a6,
	Navy = 0x34495e,
	DarkAqua = 0x11806a,
	DarkGreen = 0x1f8b4c,
	DarkBlue = 0x206694,
	DarkPurple = 0x71368a,
	DarkVividPink = 0xad1457,
	DarkGold = 0xc27c0e,
	DarkOrange = 0xa84300,
	DarkRed = 0x992d22,
	DarkGrey = 0x979c9f,
	DarkerGrey = 0x7f8c8d,
	LightGrey = 0xbcc0c0,
	DarkNavy = 0x2c3e50,
	Blurple = 0x5865f2,
	Greyple = 0x99aab5,
	DarkButNotBlack = 0x2c2f33,
	NotQuiteBlack = 0x23272a,
}

local Embed = {}
Embed.__index = Embed

function Embed.new()
	local self = setmetatable({}, Embed)
	self:Clear()
	return self
end

function Embed:Clear()
	self.title = nil
	self.description = nil
	self.color = nil
	self.fields = {}
	self.footer = nil
	self.author = nil
	return self
end

function Embed:SetTitle(title)
	self.title = title
	return self
end

function Embed:SetDescription(description)
	self.description = description
	return self
end

function Embed:SetColor(color)
	self.color = color
	return self
end

function Embed:AddField(name, value, inline)
	table.insert(self.fields, {
		name = name,
		value = value,
		inline = inline or false
	})
	return self
end

function Embed:SetFooter(text, icon_url)
	self.footer = {
		text = text,
		icon_url = icon_url
	}
	return self
end

function Embed:SetAuthor(name, icon_url, url)
	self.author = {
		name = name,
		icon_url = icon_url,
		url = url
	}
	return self
end

function Embed:Build()
	return {
		title = self.title,
		description = self.description,
		color = self.color,
		fields = self.fields,
		footer = self.footer,
		author = self.author,
	}
end

function Embed:Post(webhook_url)
	local payload = {
		embeds = { self:Build() }
	}
	local json_payload = HttpService:JSONEncode(payload)

	local success, response = pcall(function()
		return HttpService:PostAsync(webhook_url, json_payload, Enum.HttpContentType.ApplicationJson)
	end)

	if not success then
		error("failed: " .. tostring(response))
	end

	return response
end

module.Embed = function()
	return Embed.new()
end

module.Colors = Colors

return module
