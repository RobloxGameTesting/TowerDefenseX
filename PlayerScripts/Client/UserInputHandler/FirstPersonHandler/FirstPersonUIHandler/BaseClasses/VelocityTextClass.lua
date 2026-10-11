local VelocityTextClass = {}
VelocityTextClass.__index = VelocityTextClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("MapHandler"))

function VelocityTextClass.New(textLabel, _)
	return (setmetatable(
		{ TextLabel = textLabel, LastPosition = nil, TimeSinceLastUpdate = 0, Tower = nil },
		VelocityTextClass
	))
end

function VelocityTextClass:SetEnabled(enabled: boolean)
	self.Enabled = enabled
	self:_UpdateState()
end

function VelocityTextClass:SetTower(tower)
	self.Tower = tower

	if tower then
		local position = tower:GetPosition()
		self.LastPosition = Vector3.new(position.X, 0, position.Z)
		self.TimeSinceLastUpdate = 0
	end
end

function VelocityTextClass:Run(p: number)
	if not (self.Enabled and self.Tower) then
		return
	end

	if not (self.TimeSinceLastUpdate > 0.2) then
		self.TimeSinceLastUpdate += p
		return
	end

	local position = self.Tower:GetPosition()
	local vector = Vector3.new(position.X, 0, position.Z)
	local v = (vector - self.LastPosition) / self.TimeSinceLastUpdate
	self.TextLabel.Text = `VELOCITY: {math.round(v.Magnitude)}`
	self.LastPosition = vector
	self.TimeSinceLastUpdate = 0
end

function VelocityTextClass:_UpdateState()
	self.TextLabel.Visible = self.Enabled
end

return VelocityTextClass