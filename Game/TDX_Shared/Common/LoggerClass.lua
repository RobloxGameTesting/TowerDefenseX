local LoggerClass = {}
LoggerClass.__index = LoggerClass
local count = 0

function LoggerClass.New()
	count += 1
	return (setmetatable({ Id = count, Events = {} }, LoggerClass))
end

function LoggerClass.Log(p, p2)
	table.insert(p.Events, p2)
end

return LoggerClass