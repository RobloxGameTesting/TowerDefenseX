local ScaleJuiceClass = {}
ScaleJuiceClass.__index = ScaleJuiceClass
local TweenService = game:GetService("TweenService")

local function GetScale(parent) -- 1 equivalent call inferred from this helper
	local v = parent:FindFirstChildWhichIsA("UIScale")

	if not v then
		v = Instance.new("UIScale")
		v.Parent = parent
	end

	return v
end

function ScaleJuiceClass.New(tweenInfo)
	return (setmetatable({ TweenInfo = tweenInfo, Tweens = {} }, ScaleJuiceClass))
end

function ScaleJuiceClass:Cancel(p)
	local tween = self.Tweens[p]

	if tween then
		tween:Cancel()
		self.Tweens[p] = nil
	end
end

function ScaleJuiceClass:Play(parent, scale: number)
	self:Cancel(parent)
	local scale2 = GetScale(parent) -- inferred equivalent call
	scale2.Scale = scale
	local tween = TweenService:Create(scale2, self.TweenInfo, { Scale = 1 })
	self.Tweens[parent] = tween
	tween:Play()
end

return ScaleJuiceClass