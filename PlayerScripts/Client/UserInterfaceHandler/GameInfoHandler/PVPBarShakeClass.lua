local PVPBarShakeClass = {}
PVPBarShakeClass.__index = PVPBarShakeClass

function PVPBarShakeClass.New(bar)
	return (setmetatable({ Bar = bar, BasePosition = bar.Position, Strength = 0, TimeLeft = 0 }, PVPBarShakeClass))
end

function PVPBarShakeClass:Trigger(p: number)
	local strength = math.clamp(p * 10, 0.2, 1)

	if strength < self.Strength * (self.TimeLeft / 0.65) then
		return
	end

	self.Strength = strength
	self.TimeLeft = 0.65
end

function PVPBarShakeClass:Step(p: number)
	if self.TimeLeft <= 0 then
		return
	end

	self.TimeLeft = math.max(self.TimeLeft - p, 0)

	if self.TimeLeft <= 0 then
		self.Strength = 0
		self.Bar.Position = self.BasePosition
	else
		local v = self.TimeLeft / 0.65
		local v2 = self.Bar.AbsoluteSize.Y * 0.18 * self.Strength * v
		self.Bar.Position = self.BasePosition + UDim2.fromOffset(
			math.round((math.random() * 2 - 1) * v2),
			(math.round((math.random() * 2 - 1) * v2))
		)
	end
end

return PVPBarShakeClass