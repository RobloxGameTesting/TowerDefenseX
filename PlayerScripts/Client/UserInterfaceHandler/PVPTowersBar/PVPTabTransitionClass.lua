local PVPTabTransitionClass = {}
PVPTabTransitionClass.__index = PVPTabTransitionClass
local TweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

function PVPTabTransitionClass.New()
	return (setmetatable({ BasePositions = {}, Tweens = {} }, PVPTabTransitionClass))
end

function PVPTabTransitionClass.Show(p, p2)
	local position = p.BasePositions[p2]

	if not position then
		position = p2.Position
		p.BasePositions[p2] = position
	end

	local tween = p.Tweens[p2]

	if tween then
		tween:Cancel()
	end

	p2.Position = position + UDim2.fromOffset(0, 10)
	local tween2 = TweenService:Create(p2, tweenInfo, { Position = position })
	p.Tweens[p2] = tween2
	tween2:Play()
end

return PVPTabTransitionClass