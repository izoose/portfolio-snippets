local CommandBuilder = {}
CommandBuilder.__index = CommandBuilder

function CommandBuilder.new(name)
	local self = setmetatable({}, CommandBuilder)
	self.name = name
	self.parameters = {}
	return self
end

function CommandBuilder:addParameter(paramType, name, defaultValue)
	table.insert(self.parameters, { type = paramType, name = name, value = defaultValue })
	return self
end

function CommandBuilder:setDescription(description)
	self.description = description
	return self
end

function CommandBuilder:onExecute(callback)
	self.execute = callback
	return self
end

function CommandBuilder:build()
	return self
end

return CommandBuilder
