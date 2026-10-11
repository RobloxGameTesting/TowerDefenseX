local PVPSendButtonJuiceClass = {}
PVPSendButtonJuiceClass.__index = PVPSendButtonJuiceClass
local TweenService = game:GetService("TweenService")
local ScaleJuiceClass = require(script.Parent:WaitForChild("ScaleJuiceClass"))
local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local color = Color3.fromRGB(255, 80, 80)
local tweenInfo3 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

function PVPSendButtonJuiceClass.New()
	return (setmetatable(
		{
			ScaleJuice = ScaleJuiceClass.New(tweenInfo),
			RotationTweens = {},
			ColorTweens = {},
			OriginalLabelColors = {}
		},
		PVPSendButtonJuiceClass
	))
end

local function CancelTween(p, p2) -- 2 equivalent calls inferred from this helper
	local v = p[p2]

	if v then
		v:Cancel()
		p[p2] = nil
	end
end

function PVPSendButtonJuiceClass.Punch(p, p2)
	p.ScaleJuice:Play(p2, 1.15)
end

function PVPSendButtonJuiceClass.Deny(data, p, p2)
	CancelTween(data.RotationTweens, p) -- inferred equivalent call
	p.Rotation = -5
	local tween = TweenService:Create(p, tweenInfo2, { Rotation = 0 })
	data.RotationTweens[p] = tween
	tween:Play()

	if p2 then
		CancelTween(data.ColorTweens, p2) -- inferred equivalent call
		local textColor3 = data.OriginalLabelColors[p2]

		if not textColor3 then
			textColor3 = p2.TextColor3
			data.OriginalLabelColors[p2] = textColor3
		end

		p2.TextColor3 = color
		local tween2 = TweenService:Create(p2, tweenInfo3, { TextColor3 = textColor3 })
		data.ColorTweens[p2] = tween2
		tween2:Play()
	end
end

return PVPSendButtonJuiceClass