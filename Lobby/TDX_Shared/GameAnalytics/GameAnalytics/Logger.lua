game:GetService("RunService")
local Logger = {
	_infoLogEnabled = false,
	_infoLogAdvancedEnabled = false,
	_debugEnabled = false,
	setDebugLog = function(p, debugEnabled)
		p._debugEnabled = debugEnabled
	end
}

function Logger:setInfoLog(infoLogEnabled)
	self._infoLogEnabled = infoLogEnabled
end

function Logger:setVerboseLog(infoLogAdvancedEnabled)
	self._infoLogAdvancedEnabled = infoLogAdvancedEnabled
end

function Logger:i(p)
	if not self._infoLogEnabled then
		return
	end

	local v = "Info/GameAnalytics: " .. p
	print(v)
end

function Logger.w(_, p)
	local v = "Warning/GameAnalytics: " .. p
	warn(v)
end

function Logger.e(_, p)
	task.spawn(function()
		local v = "Error/GameAnalytics: " .. p
		error(v, 0)
	end)
end

function Logger:d(p)
	if not self._debugEnabled then
		return
	end

	local v = "Debug/GameAnalytics: " .. p
	print(v)
end

function Logger:ii(p)
	if not self._infoLogAdvancedEnabled then
		return
	end

	local v = "Verbose/GameAnalytics: " .. p
	print(v)
end

return Logger