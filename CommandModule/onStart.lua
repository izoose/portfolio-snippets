local module = {}
local commandsFolder = script.Parent.Parent.Commands
local prefix = ":"

function module.onStart()
	local commandModules = {}

	for _, commandModule in ipairs(commandsFolder:GetChildren()) do
		if commandModule:IsA("ModuleScript") then
			local command = require(commandModule)
			if command and command.name then
				print(prefix..command.name.." has been loaded!")
				commandModules[command.name] = command
			end
		end
	end
	print("✅ | All commands loaded.")
	game.Players.PlayerAdded:Connect(function(player)
		player.Chatted:Connect(function(message)
			if message:sub(1, #prefix) == prefix then
				local args = message:sub(#prefix + 1):split(" ")
				local commandName = table.remove(args, 1)
				local command = commandModules[commandName]

				if command and type(command.execute) == "function" then
					local parsedArgs = {}
					for i, param in ipairs(command.parameters or {}) do
						local arg = args[i]
						if param.type == "int" then
							parsedArgs[param.name] = tonumber(arg) or param.value
						elseif param.type == "string" then
							parsedArgs[param.name] = arg or param.value
						else
							parsedArgs[param.name] = param.value
						end
					end
					command.execute(player, parsedArgs)
				end
			end
		end)
	end)
end

return module
