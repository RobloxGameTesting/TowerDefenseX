local HealthbarClass = {}
HealthbarClass.__index = HealthbarClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local GameSoundHandler = require(TDX_Shared.Components.GameSoundHandler)

function HealthbarClass.New(frame, flag: boolean?)
	local bar = frame.Bar
	local criticalBox = frame.CriticalBox
	criticalBox.Visible = false
	local sound = criticalBox:FindFirstChildOfClass("Sound")

	if sound then
		GameSoundHandler.AddSoundToSoundGroup(sound, "SFX")
	end

	local v = {
		Frame = frame,
		BarJuice = bar,
		CriticalFrame = criticalBox,
		CriticalSound = sound,
		Vertical = flag or false,
		CurrentHealthHandler = nil,
		Enabled = false,
		TimePassed = 0,
		LastCriticalSoundTime = 0
	}
	setmetatable(v, HealthbarClass)
	v:_UpdateState()
	return v
end

function HealthbarClass:SetEnabled(enabled: boolean)
	self.Enabled = enabled
	self:_UpdateState()
end

function HealthbarClass:SetHealthHandler(currentHealthHandler)
	self.CurrentHealthHandler = currentHealthHandler
end

function HealthbarClass:_UpdateState()
	self.Frame.Visible = self.Enabled
end

function HealthbarClass:Run(p: number)
	local currentHealthHandler = self.CurrentHealthHandler

	if not (currentHealthHandler and self.Enabled) then
		return
	end

	local barJuice = self.BarJuice
	local criticalFrame = self.CriticalFrame
	local v = currentHealthHandler:GetHealth() / currentHealthHandler:GetMaxHealth()

	if self.Vertical then
		barJuice.Size = UDim2.new(1, 0, v, 0)
	else
		barJuice.Size = UDim2.new(v, 0, 1, 0)
	end

	self.TimePassed += p

	if v <= 0.25 then
		if math.floor(self.TimePassed / 0.5) % 2 == 0 then
			criticalFrame.Visible = true
		else
			criticalFrame.Visible = false
		end

		if self.CriticalSound and os.clock() - self.LastCriticalSoundTime >= 0.333 then
			self.CriticalSound:Play()
			self.LastCriticalSoundTime = os.clock()
		end
	else
		criticalFrame.Visible = false
	end
end

return HealthbarClass