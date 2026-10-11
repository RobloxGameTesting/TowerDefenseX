local PVPEntranceClass = {}
PVPEntranceClass.__index = PVPEntranceClass
local TweenService = game:GetService("TweenService")

local function OffsetX(udim: UDim2, p: number) -- 2 equivalent calls inferred from this helper
	return UDim2.new(udim.X.Scale + p, udim.X.Offset, udim.Y.Scale, udim.Y.Offset)
end

local function CreateScale(parent) -- 2 equivalent calls inferred from this helper
	local uiScale = Instance.new("UIScale")
	uiScale.Parent = parent
	return uiScale
end

function PVPEntranceClass.New(elements)
	local v = {
		Elements = elements,
		FriendlyBasePosition = elements.FriendlyBar.Position,
		EnemyBasePosition = elements.EnemyBar.Position,
		FriendlyPortraitScale = CreateScale(elements.FriendlyPortrait), -- inferred equivalent call
		EnemyPortraitScale = CreateScale(elements.EnemyPortrait), -- inferred equivalent call
		Tweens = {}
	}
	return (setmetatable(v, PVPEntranceClass))
end

function PVPEntranceClass:PlayTween(p, p2, p3)
	local tween = TweenService:Create(p, p2, p3)
	table.insert(self.Tweens, tween)
	tween:Play()
end

function PVPEntranceClass:Play()
	for _, tween in self.Tweens do
		tween:Cancel()
	end

	table.clear(self.Tweens)
	local elements = self.Elements
	local tweenInfo = TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.In, 0, false, 0.5)
	local tweenInfo2 = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 1.2)
	local tweenInfo3 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 1.2)
	local parent = elements.FriendlyBar.Parent
	local screenGui = elements.FriendlyBar:FindFirstAncestorWhichIsA("ScreenGui")
	local v, v2

	if parent and screenGui and parent.AbsoluteSize.X > 0 then
		local x = parent.AbsoluteSize.X
		local x2 = parent.AbsolutePosition.X
		local v3 = x2 + self.FriendlyBasePosition.X.Scale * x + self.FriendlyBasePosition.X.Offset
		local v4 = x2 + self.EnemyBasePosition.X.Scale * x + self.EnemyBasePosition.X.Offset
		v = v3 / x + 0.05
		v2 = (screenGui.AbsoluteSize.X - v4) / x + 0.05
	else
		v = 2
		v2 = 2
	end

	elements.FriendlyBar.Position = OffsetX(self.FriendlyBasePosition, -v) -- inferred equivalent call
	elements.EnemyBar.Position = OffsetX(self.EnemyBasePosition, v2) -- inferred equivalent call
	self.FriendlyPortraitScale.Scale = 0
	self.EnemyPortraitScale.Scale = 0
	elements.FriendlyNameText.TextTransparency = 1
	elements.EnemyNameText.TextTransparency = 1
	self:PlayTween(elements.FriendlyBar, tweenInfo, { Position = self.FriendlyBasePosition })
	self:PlayTween(elements.EnemyBar, tweenInfo, { Position = self.EnemyBasePosition })
	self:PlayTween(self.FriendlyPortraitScale, tweenInfo2, { Scale = 1 })
	self:PlayTween(self.EnemyPortraitScale, tweenInfo2, { Scale = 1 })
	self:PlayTween(elements.FriendlyNameText, tweenInfo3, { TextTransparency = 0 })
	self:PlayTween(elements.EnemyNameText, tweenInfo3, { TextTransparency = 0 })
end

return PVPEntranceClass