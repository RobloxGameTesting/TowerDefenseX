local Cleaner = {}
Cleaner.__index = Cleaner

local function clean(task)
	if type(task) == "function" then
		task()
	elseif typeof(task) == "RBXScriptConnection" then
		task:Disconnect()
	elseif type(task) == "table" then
		if type(task.Disconnect) == "function" then
			task:Disconnect()
		elseif type(task.Destroy) == "function" then
			task:Destroy()
		end
	elseif typeof(task) == "Instance" then
		task:Destroy()
	else
		warn(`Cannot cleanup task of type {typeof(task)}`)
	end
end

function Cleaner.new()
	return (setmetatable({ Tasks = {}, Cleaned = false }, Cleaner))
end

function Cleaner:Add(p)
	if self.Cleaned then
		self.Cleaned = false
	end

	local typeName = typeof(p)
	local typeName2 = type(p)

	if typeName2 == "function" or typeName == "RBXScriptConnection" or typeName == "Instance" then
		table.insert(self.Tasks, p)
	elseif typeName2 ~= "table" then
		error("Cleaner // Provided object is unsupported")
	elseif type(p.Disconnect) == "function" or type(p.Destroy) == "function" then
		table.insert(self.Tasks, p)
	else
		error("Cleaner // Provided object has no Destroy or Disconnect method")
	end
end

function Cleaner:Clean()
	for _, task in ipairs(self.Tasks) do
		clean(task)
	end

	table.clear(self.Tasks)
	self.Cleaned = true
end

return Cleaner