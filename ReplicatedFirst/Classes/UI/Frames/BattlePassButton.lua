local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(game.ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local BattlePass = require(game.ReplicatedStorage.TDX_Shared.Modules.BattlePass)
local RunService = game:GetService("RunService")
local BattlePassButton = { ClassName = script.Name, ClassModule = script }
BattlePassButton.__index = BattlePassButton

function BattlePassButton.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, BattlePassButton))
end

function BattlePassButton:Init()
	local v = 0
	self.Cleaner:Add(RunService.Heartbeat:Connect(function()
		local now = tick()

		if now - v >= 0.33 then
			v = now
			self:Update()
		end
	end))
end

function BattlePassButton:Update()
	local visible = (BattlePass.GetCurrentPass() or _G.BATTLEPASS_REWORK_ENABLED) and true or false

	if self.Root.Visible ~= visible then
		self.Root.Visible = visible
	end
end

function BattlePassButton.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { BattlePassButton })
return BattlePassButton