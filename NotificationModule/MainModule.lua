local TweenService = game:GetService("TweenService")
local module = {}

module.ButtonActions = {
	onClick = function(gui, action)
		if action and typeof(action) == "function" then
			action(gui)
		end
	end,
	close = function(gui)
		local styleFrame
		for _, child in pairs(gui:GetChildren()) do
			if child:IsA("Frame") and child.Visible then
				styleFrame = child
				break
			end
		end

		local startX = styleFrame.Position.X.Scale
		local targetProperties = {Position = UDim2.new(startX, 0, -1, 0)}

		local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

		local tween = TweenService:Create(styleFrame, tweenInfo, targetProperties)
		tween.Completed:Connect(function()
			gui:Destroy()
		end)
		tween:Play()
	end,

	mouseEnter = function(gui, action)
		if action and typeof(action) == "function" then
			action(gui)
		end
	end,
	mouseLeave = function(gui, action)
		if action and typeof(action) == "function" then
			action(gui)
		end
	end
}

module.ButtonStyles = {
	Success = {BackgroundColor3 = Color3.new(0.25098, 1, 0.462745)},
	Danger = {BackgroundColor3 = Color3.new(1, 0.176471, 0.192157)},
}

module.Styles = {
	Cartoony = "Cartoony",
	Blue = "Blue",
	Green = "Green",
}

module.Styles.Random = function()
	local stylesList = {}
	for k, _ in pairs(module.Styles) do
		if k ~= "Random" then
			table.insert(stylesList, k)
		end
	end
	return stylesList[math.random(#stylesList)]
end

for _, v in pairs(script.Notification:GetChildren()) do
	if not module.Styles[v.Name] then
		module.Styles[v.Name] = v.Name
	end
end

function module.createNotification(config)
	local Gui = script.Notification:Clone()
	Gui.Enabled = true

	for _, child in pairs(Gui:GetChildren()) do
		if module.Styles[child.Name] then
			child.Visible = false
		end
	end

	local StyleFrame = Gui[module.Styles[config.style or "Cartoony"]]
	StyleFrame.Visible = true

	if config.title and typeof(config.title) == "string" then
		StyleFrame.Title.Text = config.title:upper()
	end

	if config.description and typeof(config.description) == "string" then
		StyleFrame.Description.Text = config.description:upper()
	end

	local exitButton = StyleFrame:FindFirstChild("ExitButton")
	if config.disableClose and exitButton then
		exitButton.Visible = not config.disableClose
	end

	local button1 = StyleFrame.SuccessButton
	local button2 = StyleFrame.DangerButton
	button1.Visible = false
	button2.Visible = false

	if config.buttons and typeof(config.buttons) == "table" and #config.buttons > 0 then
		for i, buttonData in ipairs(config.buttons) do
			local targetButton = (i == 1) and button1 or button2
			targetButton.Visible = true

			if buttonData.ButtonText and typeof(buttonData.ButtonText) == "string" then
				targetButton.TextLabel.Text = buttonData.ButtonText:upper()
			end

			if buttonData.ButtonType and module.ButtonStyles[buttonData.ButtonType] then
				local style = module.ButtonStyles[buttonData.ButtonType]
				targetButton.BackgroundColor3 = style.BackgroundColor3
			end

			if buttonData.ButtonAction then
				if module.ButtonActions[buttonData.ButtonAction.type] then
					if buttonData.ButtonAction.type == "mouseEnter" then
						targetButton.MouseEnter:Connect(function()
							module.ButtonActions.mouseEnter(Gui, buttonData.ButtonAction.action)
						end)
					elseif buttonData.ButtonAction.type == "mouseLeave" then
						targetButton.MouseLeave:Connect(function()
							module.ButtonActions.mouseLeave(Gui, buttonData.ButtonAction.action)
						end)
					else
						targetButton.TextButton.MouseButton1Click:Connect(function()
							module.ButtonActions[buttonData.ButtonAction.type](Gui, buttonData.ButtonAction.action)
						end)
					end
				end
			end
		end

		if #config.buttons == 1 then
			button1.Position = UDim2.new(0.5, -button1.Size.X.Offset/2, button1.Position.Y.Scale, button1.Position.Y.Offset)
		end
	end
	return Gui
end

function module.displayNotification(input, playerObject)
	if typeof(input) == "table" then
		local gui = input.Gui
		local player = input.plr or playerObject
		gui.Parent = player:WaitForChild("PlayerGui")
	else
		input.Parent = playerObject:WaitForChild("PlayerGui")
	end
end

return module
