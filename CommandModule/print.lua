local CommandBuilder = require(script.Parent.Parent.Packages.CommandBuilder)

local cmd = CommandBuilder.new('print')
	:addParameter("string", "value", "Hello World!")
	:addParameter("string", "thingy", "Hello World!")
	:onExecute(function(player, args)
		local value = args.value or "Player"
		print(value, args.thingy)
	end)

return cmd
