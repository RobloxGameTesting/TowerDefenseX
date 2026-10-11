local createVector = vector.create
local RingHandlerClass = {}
RingHandlerClass.__index = RingHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo3 = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local tweenInfo4 = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local color = Color3.fromRGB(59, 255, 101)
local color2 = Color3.fromRGB(43, 190, 116)
local color3 = Color3.fromRGB(87, 126, 255)
local color4 = Color3.fromRGB(73, 152, 255)
local color5 = Color3.fromRGB(255, 231, 125)
local color6 = Color3.fromRGB(245, 214, 72)
local color7 = Color3.fromRGB(255, 0, 0)
local color8 = Color3.fromRGB(255, 28, 28)
local color9 = Color3.fromRGB(255, 152, 56)
local color10 = Color3.fromRGB(253, 156, 66)
local color11 = Color3.fromRGB(255, 82, 82)
local color12 = Color3.fromRGB(255, 98, 98)
local color13 = Color3.fromRGB(133, 57, 255)
local color14 = Color3.fromRGB(143, 67, 255)
local color15 = Color3.fromRGB(25, 25, 25)
local color16 = Color3.fromRGB(35, 35, 35)
local colorSequence = ColorSequence.new({
	ColorSequenceKeypoint.new(0, color),
	ColorSequenceKeypoint.new(0.5, color2),
	ColorSequenceKeypoint.new(1, color)
})
local colorSequence2 = ColorSequence.new({
	ColorSequenceKeypoint.new(0, color5),
	ColorSequenceKeypoint.new(0.5, color6),
	ColorSequenceKeypoint.new(1, color5)
})
local colorSequence3 = ColorSequence.new({
	ColorSequenceKeypoint.new(0, color3),
	ColorSequenceKeypoint.new(0.5, color4),
	ColorSequenceKeypoint.new(1, color3)
})
local colorSequence4 = ColorSequence.new({
	ColorSequenceKeypoint.new(0, color7),
	ColorSequenceKeypoint.new(0.5, color8),
	ColorSequenceKeypoint.new(1, color7)
})
local colorSequence5 = ColorSequence.new({
	ColorSequenceKeypoint.new(0, color9),
	ColorSequenceKeypoint.new(0.5, color10),
	ColorSequenceKeypoint.new(1, color9)
})
local colorSequence6 = ColorSequence.new({
	ColorSequenceKeypoint.new(0, color11),
	ColorSequenceKeypoint.new(0.5, color12),
	ColorSequenceKeypoint.new(1, color11)
})
local colorSequence7 = ColorSequence.new({
	ColorSequenceKeypoint.new(0, color13),
	ColorSequenceKeypoint.new(0.5, color14),
	ColorSequenceKeypoint.new(1, color13)
})
local colorSequence8 = ColorSequence.new({
	ColorSequenceKeypoint.new(0, color15),
	ColorSequenceKeypoint.new(0.5, color16),
	ColorSequenceKeypoint.new(1, color15)
})
local Hidden = Lighting:WaitForChild("Hidden")

function RingHandlerClass.New(parent, p: number, value: number?, ownedByLocalPlayer: boolean, flag: boolean?)
	local miscResource = ResourceManager.GetMiscResource("Ring")
	local beams = {}
	local curveSize = p * (4 / 3) * 0.198912367379658
	local color17

	if ownedByLocalPlayer then
		if flag then
			color17 = colorSequence4
		else
			color17 = colorSequence
		end
	else
		color17 = colorSequence2
	end

	for _, beam in pairs(miscResource:GetChildren()) do
		if not beam:IsA("Beam") then
			continue
		end

		beam.Color = color17
		beam.CurveSize0 = curveSize
		beam.CurveSize1 = curveSize
		table.insert(beams, beam)
	end

	for i = 1, 8 do
		local child = miscResource:FindFirstChild((tostring(i)))
		local v = (i - 1) * 6.283185307179586 / 8
		local vector = Vector3.new(p * math.cos(v), 0, p * math.sin(v))
		child.Position = createVector(0, 0, 0)
		TweenService:Create(child, tweenInfo3, { Position = vector }):Play()
	end

	local vector = Vector3.new(0, value or 0, 0)
	miscResource.Position = parent.Position + vector
	miscResource.Parent = parent
	return (setmetatable({
		Ring = miscResource,
		RingBeams = beams,
		OwnedByLocalPlayer = ownedByLocalPlayer,
		Position = parent.Position,
		Offset = vector,
		Torso = parent
	}, RingHandlerClass))
end

function RingHandlerClass:SetOffset(value: number?)
	self.Offset = Vector3.new(0, value or 0, 0)
	self.Ring.Position = self.Position + self.Offset
end

function RingHandlerClass:SetPosition(position: Vector3)
	self.Position = position
	self.Ring.Position = position + self.Offset
end

function RingHandlerClass.SetIsInvalid(p, flag: boolean)
	local color17

	if flag then
		color17 = colorSequence4
	else
		color17 = colorSequence3
	end

	for _, ringBeam in pairs(p.RingBeams) do
		ringBeam.Color = color17
	end
end

function RingHandlerClass.Rebuilding(p, flag: boolean)
	for _, ringBeam in pairs(p.RingBeams) do
		if p.OwnedByLocalPlayer then
			ringBeam.Color = colorSequence5
		else
			ringBeam.Color = colorSequence2
		end

		if flag then
			TweenService:Create(ringBeam, tweenInfo4, { Brightness = 2, LightEmission = 1 }):Play()
			TweenService:Create(ringBeam, tweenInfo, { Width0 = 1.5, Width1 = 1.5 }):Play()
		else
			TweenService:Create(ringBeam, tweenInfo4, { Brightness = 1, LightEmission = 0.3 }):Play()
			TweenService:Create(ringBeam, tweenInfo2, { Width0 = 1, Width1 = 1 }):Play()
		end
	end
end

function RingHandlerClass.Reviving(p, flag: boolean)
	for _, ringBeam in pairs(p.RingBeams) do
		if p.OwnedByLocalPlayer then
			ringBeam.Color = colorSequence6
		else
			ringBeam.Color = colorSequence2
		end

		if flag then
			TweenService:Create(ringBeam, tweenInfo4, { Brightness = 2, LightEmission = 1 }):Play()
			TweenService:Create(ringBeam, tweenInfo, { Width0 = 1.5, Width1 = 1.5 }):Play()
		else
			TweenService:Create(ringBeam, tweenInfo4, { Brightness = 1, LightEmission = 0.3 }):Play()
			TweenService:Create(ringBeam, tweenInfo2, { Width0 = 1, Width1 = 1 }):Play()
		end
	end
end

function RingHandlerClass.Converted(p, flag: boolean)
	for _, ringBeam in pairs(p.RingBeams) do
		if p.OwnedByLocalPlayer then
			ringBeam.Color = colorSequence7
		else
			ringBeam.Color = colorSequence2
		end

		if flag then
			TweenService:Create(ringBeam, tweenInfo4, { Brightness = 2, LightEmission = 1 }):Play()
			TweenService:Create(ringBeam, tweenInfo, { Width0 = 1.5, Width1 = 1.5 }):Play()
		else
			TweenService:Create(ringBeam, tweenInfo4, { Brightness = 1, LightEmission = 0.3 }):Play()
			TweenService:Create(ringBeam, tweenInfo2, { Width0 = 1, Width1 = 1 }):Play()
		end
	end
end

function RingHandlerClass.Dead(p)
	for _, ringBeam in pairs(p.RingBeams) do
		ringBeam.Color = colorSequence8
		TweenService:Create(ringBeam, tweenInfo4, { Brightness = 1, LightEmission = 0.3 }):Play()
		TweenService:Create(ringBeam, tweenInfo2, { Width0 = 1, Width1 = 1 }):Play()
	end
end

function RingHandlerClass.SetPreviewMode(p)
	for _, ringBeam in pairs(p.RingBeams) do
		ringBeam.Color = colorSequence3
		ringBeam.Brightness = 2
		ringBeam.LightEmission = 1
		TweenService:Create(ringBeam, tweenInfo, { Width0 = 1.5, Width1 = 1.5 }):Play()
	end
end

function RingHandlerClass.SetDefaultMode(p)
	for _, ringBeam in pairs(p.RingBeams) do
		if p.OwnedByLocalPlayer then
			ringBeam.Color = colorSequence
		else
			ringBeam.Color = colorSequence2
		end

		TweenService:Create(ringBeam, tweenInfo4, { Brightness = 1, LightEmission = 0.3 }):Play()
		TweenService:Create(ringBeam, tweenInfo2, { Width0 = 1, Width1 = 1 }):Play()
	end
end

function RingHandlerClass.Select(p)
	for _, ringBeam in pairs(p.RingBeams) do
		ringBeam.Color = colorSequence3
		TweenService:Create(ringBeam, tweenInfo4, { Brightness = 2, LightEmission = 1 }):Play()
		TweenService:Create(ringBeam, tweenInfo, { Width0 = 1.5, Width1 = 1.5 }):Play()
	end
end

function RingHandlerClass.Deselect(p)
	for _, ringBeam in pairs(p.RingBeams) do
		if p.OwnedByLocalPlayer then
			ringBeam.Color = colorSequence
		else
			ringBeam.Color = colorSequence2
		end

		TweenService:Create(ringBeam, tweenInfo4, { Brightness = 1, LightEmission = 0.3 }):Play()
		TweenService:Create(ringBeam, tweenInfo2, { Width0 = 1, Width1 = 1 }):Play()
	end
end

function RingHandlerClass.FadeOutDestroy(p)
	for _, ringBeam in pairs(p.RingBeams) do
		TweenService:Create(ringBeam, tweenInfo2, { Width0 = 0, Width1 = 0 }):Play()
	end
end

function RingHandlerClass:Destroy()
	self.Ring:Destroy()
end

function RingHandlerClass.ToggleVisible(p, flag: boolean)
	if flag then
		p.Ring.Parent = p.Torso
	else
		p.Ring.Parent = Hidden
	end
end

return RingHandlerClass