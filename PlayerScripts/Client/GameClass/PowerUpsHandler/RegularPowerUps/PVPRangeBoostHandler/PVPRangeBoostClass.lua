local PVPRangeBoostClass = {}
PVPRangeBoostClass.__index = PVPRangeBoostClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
require(common.Resources.Misc.RegularPowerUps.PVPRangeBoost.Types)
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local modelTemplate = common.Resources.Misc.RegularPowerUps.PVPRangeBoost.ModelTemplate

function PVPRangeBoostClass.New(p, speedMultiplier: number)
	local clone = modelTemplate:Clone()
	clone.Name = modelTemplate.Parent.Name
	clone:PivotTo(CFrame.new(p.Location))
	clone.Parent = raycastIgnore
	local v = {
		Hash = p.Hash,
		TimePassed = 0,
		TotalTime = 7,
		SpeedMultiplier = speedMultiplier,
		Destroyed = false,
		Model = clone,
		_Wrappers = {
			VFXWrapper = WrapperFactory.NewEmitterAndSoundWrapper(clone, speedMultiplier)
		}
	}

	for _, wrapper in pairs(v._Wrappers) do
		wrapper:PlayTriggered()
	end

	setmetatable(v, PVPRangeBoostClass)
	return v
end

function PVPRangeBoostClass:Run(p: number)
	self.TimePassed += p

	if self.TimePassed >= self.TotalTime then
		self:Destroy()
	end
end

function PVPRangeBoostClass.CanCleanup(p)
	return p.Destroyed
end

function PVPRangeBoostClass:Destroy()
	self.Model:Destroy()
	self.Destroyed = true
end

function PVPRangeBoostClass:SpeedMultiplierChanged(speedMultiplier: number)
	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	self.SpeedMultiplier = speedMultiplier
end

return PVPRangeBoostClass