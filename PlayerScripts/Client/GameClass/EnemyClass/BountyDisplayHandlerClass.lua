local createVector = vector.create
local BountyDisplayHandlerClass = {}
BountyDisplayHandlerClass.__index = BountyDisplayHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local parent = script.Parent.Parent
local VisualEffectHandler = require(parent:WaitForChild("VisualEffectHandler"))
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")

function BountyDisplayHandlerClass.New(isBoss: boolean, flag: boolean, object, p: number?)
	local head = object:GetHead()
	local v = {
		Initialized = false,
		IsBoss = isBoss,
		IsMiniBoss = flag,
		Head = head,
		RealTorso = object:GetRealTorso(),
		HeadOffset = Vector3.new(0, (isBoss and 1.5 or flag and 1 or 0.75) + head.Size.Y / 2, 0),
		Rotation = nil,
		BountySymbol = nil,
		BountyCount = 0
	}
	setmetatable(v, BountyDisplayHandlerClass)

	if p then
		v:SetBountyCount(p)
	end

	return v
end

function BountyDisplayHandlerClass:_Initialize()
	local miscResource = ResourceManager.GetMiscResource("BountySymbol")
	local head = self.Head
	local rotation = math.random() * 2 * 3.141592653589793

	if self.IsBoss then
		miscResource:ScaleTo(1.6)
	elseif self.IsMiniBoss then
		miscResource:ScaleTo(1.3)
	end

	miscResource:PivotTo(CFrame.new(head.Position + self.HeadOffset) * CFrame.Angles(0, rotation, 0))
	miscResource.Parent = raycastIgnore
	self.BountySymbol = miscResource
	self.Rotation = rotation
	self.Initialized = true
end

function BountyDisplayHandlerClass:SetBountyCount(bountyCount: number)
	if bountyCount <= 0 then
		return
	end

	if not self.Initialized then
		self:_Initialize()
	end

	if bountyCount == self.BountyCount or bountyCount > 4 then
		return
	end

	local child = self.BountySymbol:FindFirstChild((tostring(bountyCount)))

	if not child then
		warn("BountyDisplayHandlerClass:SetBountyCount - NextSymbol not found for Count: " .. bountyCount)
		return
	end

	local size = child.Size
	child.Size = createVector(0, 0, 0)
	TweenService:Create(child, tweenInfo, { Size = size }):Play()
	child.Transparency = 0
	self.BountyCount = bountyCount
end

function BountyDisplayHandlerClass:Run(p: number)
	local bountySymbol = self.BountySymbol

	if not bountySymbol then
		return
	end

	local head = self.Head
	self.Rotation += p * 1.3
	bountySymbol:PivotTo(CFrame.new(head.Position + self.HeadOffset) * CFrame.Angles(0, self.Rotation, 0))
end

function BountyDisplayHandlerClass:Destroy(flag: boolean?, flag2: boolean?)
	if not self.Initialized then
		return
	end

	local bountySymbol = self.BountySymbol

	if flag or flag2 then
		bountySymbol:Destroy()
		return
	end

	local realTorso = self.RealTorso
	local bountySmall = Enums.VisualEffects.BountySmall

	if self.IsBoss then
		bountySmall = Enums.VisualEffects.BountyLarge
	elseif self.IsMiniBoss then
		bountySmall = Enums.VisualEffects.BountyMedium
	end

	local v = { Name = bountySmall, Position = realTorso.Position }
	VisualEffectHandler.NewVisualEffect(v)

	for i = 1, 4 do
		TweenService:Create(bountySymbol:FindFirstChild((tostring(i))), tweenInfo2, {
			Transparency = 1
		}):Play()
	end

	task.delay(tweenInfo2.Time + 0.5, function()
		bountySymbol:Destroy()
	end)
end

return BountyDisplayHandlerClass