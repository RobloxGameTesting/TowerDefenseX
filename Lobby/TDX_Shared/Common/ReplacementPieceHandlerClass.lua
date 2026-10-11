local ReplacementPieceHandlerClass = {}
ReplacementPieceHandlerClass.__index = ReplacementPieceHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Utilities = require(common:WaitForChild("Utilities"))
require(common:WaitForChild("MapHandler"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local BezierClass = require(common:WaitForChild("BezierClass"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")

local function GetRandomBreakOffVelocity() -- 1 equivalent call inferred from this helper
	return (Vector3.new(math.random(-25, 25), math.random(30, 55), math.random(-22, 22)))
end

local function GetRandomBreakOffAngularImpulse() -- 1 equivalent call inferred from this helper
	return (Vector3.new(math.random(-25, 25) / 100, math.random(-35, 35) / 100, 0))
end

local function RagdollPiece(part, p: number?) -- 1 equivalent call inferred from this helper
	if not part.Parent or part.Transparency > 0.99 then
		return
	end

	part.CanCollide = true
	part.Parent = raycastIgnore

	if p then
		local mass = part:GetMass()
		part:ApplyImpulse(GetRandomBreakOffVelocity() * mass * p) -- inferred equivalent call
		part:ApplyAngularImpulse(GetRandomBreakOffAngularImpulse() * mass * p) -- inferred equivalent call
	end

	task.delay(4, function()
		local total = 0

		while total < 1.5 do
			total += task.wait()
			part.Transparency = total / 1.5
		end

		part:Destroy()
	end)
end

local function HideInstanceAndDescendants(folder)
	local descendants = folder:GetDescendants()
	table.insert(descendants, folder)

	for _, instance in descendants do
		if not (instance:IsA("BasePart") or instance:IsA("FaceInstance")) then
			continue
		end

		instance:SetAttribute("StealthShimmerOverrideMinTransparency", 1)

		if not instance:GetAttribute("OriginalTransparency") then
			instance:SetAttribute("OriginalTransparency", instance.Transparency)
		end

		instance.Transparency = 1

		if not instance:IsA("BasePart") then
			continue
		end

		if not instance:GetAttribute("OriginalCanQuery") then
			instance:SetAttribute("OriginalCanQuery", instance.CanQuery)
		end

		instance.CanQuery = false
	end
end

local function ShowInstanceAndDescendants(folder)
	local descendants = folder:GetDescendants()
	table.insert(descendants, folder)

	for _, instance in descendants do
		if not (instance:IsA("BasePart") or instance:IsA("FaceInstance")) then
			continue
		end

		instance:SetAttribute("StealthShimmerOverrideMinTransparency", nil)
		instance.Transparency = instance:GetAttribute("OriginalTransparency") or 0

		if instance:IsA("BasePart") and instance:GetAttribute("OriginalCanQuery") ~= nil then
			instance.CanQuery = instance:GetAttribute("OriginalCanQuery")
		end
	end
end

local function EaseInQuad(p: number, p2: number, p3: number, p4: number) -- 1 equivalent call inferred from this helper
	local v = p / p4
	return p3 * v * v + p2
end

local function EaseOutQuad(p: number, p2: number, p3: number, p4: number) -- 1 equivalent call inferred from this helper
	local v = p / p4
	return -p3 * v * (v - 2) + p2
end

local function EaseOutInQuad(p: number, p2: number, p3: number, p4: number)
	if p < p4 / 2 then
		return EaseInQuad(p * 2, p2, p3 / 2, p4) -- inferred equivalent call
	else
		return EaseOutQuad(p * 2 - p4, p2 + p3 / 2, p3 / 2, p4) -- inferred equivalent call
	end
end

local function FindPieceAttachWeld(folder, ancestor)
	for _, jointInstance in pairs(folder:GetDescendants()) do
		if not jointInstance:IsA("JointInstance") then
			continue
		end

		local part0 = jointInstance.Part0
		local part1 = jointInstance.Part1
		local v = nil

		if part0 == ancestor then
			v = part1
		elseif part1 == ancestor then
			v = part0
		end

		if v and not v:IsDescendantOf(ancestor) then
			return jointInstance
		end
	end

	warn(`No attach weld found in character model for replacement piece {ancestor.Name}`)
	return nil
end

local function GenerateInternalPiece(instance, item, p: number, startParent, defaultParent, value: number?, instance2)
	local primaryPart = instance.PrimaryPart
	local attachmentHelperPath = item:GetAttribute("AttachmentHelperPath")
	local weldStart = nil
	local weldEnd = nil
	local attachWeld2 = nil
	local v = nil
	local goalOffset = nil
	local v2

	if attachmentHelperPath then
		weldStart = Utilities.FindFirstChildWithWarning(item, "WeldStart")
		weldEnd = Utilities.FindFirstChildWithWarning(item, "WeldEnd")
		v2 = Utilities.TryGetInstanceFromPath(instance, attachmentHelperPath)
		goalOffset = v2:GetPivot():ToObjectSpace(item:GetPivot())
		v = Utilities.GetAttributeWithWarning(item, "AttachOffsetFromRoot")
	else
		attachWeld2 = FindPieceAttachWeld(instance, item)
		v2 = item
	end

	local hideOnAttachInstance = Utilities.TryReadChildValue(item, "HideOnAttach")

	if item:FindFirstChild("HideOnAttach") and not hideOnAttachInstance then
		warn(`HideOnAttach ObjectValue is empty for replacement piece {item.Name}`)
	end

	local v3 = item:GetAttribute("PlayConnectVFX") and v2 and Utilities.FindFirstChildWithWarning(v2, "ConnectVFX")
	local connectEffectsWrapper

	if v3 then
		connectEffectsWrapper = WrapperFactory.NewEmitterAndSoundWrapper(v3, p)
	end

	local clone, flyingEffectsWrapper

	if instance2 then
		clone = instance2:Clone()
		clone.Name = item.Name .. "_JetVFXAttachment"
		clone.CFrame = CFrame.new()
		local parent = primaryPart:FindFirstChild("ReplacementPieceJetVFX")

		if not parent then
			parent = Instance.new("Attachment")
			parent.Name = "ReplacementPieceJetVFX"
			parent.Parent = primaryPart
		end

		clone.Parent = parent
		flyingEffectsWrapper = WrapperFactory.NewEmitterAndSoundWrapper(clone, p)
	end

	local attachOffsetFromRoot = v and CFrame.new(instance:GetScale() * v.Position) * v.Rotation
	return {
		Root = primaryPart,
		Part = item,
		StartParent = startParent,
		DefaultParent = defaultParent,
		WeldStart = weldStart,
		WeldEnd = weldEnd,
		AttachWeld = attachWeld2,
		BezierCFrameOffset = item:GetAttribute("BezierCFrameOffset") or CFrame.new(),
		StartCFrame = CFrame.new(),
		GoalCFrame = CFrame.new(),
		AttachOffsetFromRoot = attachOffsetFromRoot,
		GoalOffset = goalOffset,
		HideOnAttachInstance = hideOnAttachInstance,
		ElapsedTime = 0,
		StartDelay = Utilities.GetAttributeWithWarning(item, "StartDelay") or 0,
		TotalTime = Utilities.GetAttributeWithWarning(item, "AttachTime"),
		AlphaExponent = item:GetAttribute("AlphaExponent") or value or 1,
		Running = false,
		Launched = false,
		StartBezierData = nil,
		Bezier = nil,
		ConnectEffectsWrapper = connectEffectsWrapper,
		FlyingEffectsWrapper = flyingEffectsWrapper,
		FlyingEffectsAttachment = clone,
		FlyingEffectsOn = false,
		FlyingEffectsScaled = false,
		DebugParts = {},
		Init = function(self)
			if self.WeldEnd then
				self.WeldEnd.Enabled = false
			end

			if self.WeldStart then
				self.WeldStart.Enabled = true
			end

			if self.AttachWeld then
				self.AttachWeld.Enabled = false
				self.Part.Anchored = true
			end

			if self.StartParent then
				self.Part.Parent = self.StartParent
			end
		end,
		Start = function(self, startBezierData)
			self.ElapsedTime = 0
			self.Running = true
			self.Launched = false
			self.StartBezierData = startBezierData
			self.Bezier = nil
			self:_CleanUpDebugParts()
		end,
		Stop = function(self, flag: boolean?)
			self:_CleanUpDebugParts()

			if not self.Running then
				return
			end

			self:_End(not flag)

			if flag then
				RagdollPiece(self.Part) -- inferred equivalent call
			end
		end,
		BreakOff = function(self, value2: number?)
			self:_CleanUpDebugParts()

			if self.Running then
				self:_End(false)
			end

			if self.HideOnAttachInstance then
				ShowInstanceAndDescendants(self.HideOnAttachInstance)
			end

			local attachWeld = self.AttachWeld or self.WeldEnd

			if attachWeld then
				attachWeld.Enabled = false
			end

			self.Part.Anchored = false
			RagdollPiece(self.Part, value2 or 1)
		end,
		Run = function(self, p2: number)
			if not self.Running or p2 <= 0 then
				return
			end

			if self.ElapsedTime >= self.TotalTime then
				if self.Running then
					self:_End(true, true)
				end
			else
				self.ElapsedTime += p2
				local startDelay = self.StartDelay

				if self.ElapsedTime < startDelay then
					return
				end

				if not self.Launched then
					self:_Launch()
				end

				if self.AttachWeld then
					self.GoalCFrame = self:_GetWeldGoalCFrame() or self.GoalCFrame
				end

				local v4 = (self.ElapsedTime - startDelay) / (self.TotalTime - startDelay)
				local v5 = math.clamp(v4, 0, 1) ^ self.AlphaExponent
				local v6

				if self.Bezier then
					local pointAt = self.Bezier:GetPointAt(v5)
					local v7

					if v4 < 0.5 then
						local v8 = v4 * 2 / 1
						v7 = v8 * 0.5 * v8 + 0
					else
						local v8 = (v4 * 2 - 1) / 1
						v7 = v8 * -0.5 * (v8 - 2) + 0.5
					end

					local lerped = self.StartCFrame.Rotation:Lerp(self.GoalCFrame.Rotation, v7)
					v6 = CFrame.new(pointAt) * lerped
				else
					v6 = self.StartCFrame:Lerp(self.GoalCFrame, v5)
				end

				local position = self.Part.CFrame.Position
				self:_HandleFlyingEffects((v6.Position - position).Unit)
				self.Part:PivotTo(v6)
			end
		end,
		UpdateStartBezierData = function(self, startBezierData)
			self.StartBezierData = startBezierData
		end,
		SpeedMultiplierChanged = function(self, p2: number)
			if self.ConnectEffectsWrapper then
				self.ConnectEffectsWrapper:SpeedMultiplierChanged(p2)
			end

			if self.FlyingEffectsWrapper then
				self.FlyingEffectsWrapper:SpeedMultiplierChanged(p2)
			end
		end,
		_Launch = function(self)
			self.StartCFrame = self.Part.CFrame

			if self.AttachWeld then
				self.GoalCFrame = self:_GetWeldGoalCFrame() or self.GoalCFrame
			else
				self.GoalCFrame = self.Root.CFrame * self.AttachOffsetFromRoot * self.GoalOffset
			end

			if self.WeldStart then
				self.WeldStart.Enabled = false
			end

			if self.WeldEnd then
				self.WeldEnd.Enabled = false
			end

			self.Part.Anchored = true

			if self.DefaultParent then
				self.Part.Parent = self.DefaultParent
			end

			self.Launched = true

			if self.FlyingEffectsWrapper then
				self.FlyingEffectsWrapper:PlayAll()
			end

			if self.StartBezierData then
				self.Bezier = BezierClass.New(
					self.StartCFrame.Position,
					self.StartBezierData.P1,
					self.StartBezierData.P2,
					self.GoalCFrame.Position
				)
			end
		end,
		_GetWeldGoalCFrame = function(self)
			local attachWeld = self.AttachWeld
			local part0 = attachWeld.Part0
			local part1 = attachWeld.Part1

			if part0 and part1 then
				if part1 == self.Part then
					return part0.CFrame * attachWeld.C0 * attachWeld.C1:Inverse()
				end

				return part1.CFrame * attachWeld.C1 * attachWeld.C0:Inverse()
			else
				return nil
			end
		end,
		_End = function(self, flag: boolean?, flag2: boolean?)
			if flag2 then
				if self.ConnectEffectsWrapper then
					self.ConnectEffectsWrapper:PlayAll()
				end

				if self.HideOnAttachInstance then
					HideInstanceAndDescendants(self.HideOnAttachInstance)
				end
			end

			if self.FlyingEffectsWrapper then
				self.FlyingEffectsWrapper:StopContinuous()
				self.FlyingEffectsOn = false
			end

			self.Part.Anchored = false

			if self.WeldStart then
				self.WeldStart.Enabled = false
			end

			local attachWeld = self.AttachWeld or self.WeldEnd

			if attachWeld then
				attachWeld.Enabled = flag or false
			end

			if flag then
				local transparency = self.Part.Transparency
				self.Part.Transparency = 1
				self.Part.Transparency = transparency
			end

			self.Running = false
		end,
		_HandleFlyingEffects = function(self, vector: Vector3)
			if not self.FlyingEffectsWrapper then
				return
			end

			local size = item.Size
			local v4 = math.min(size.X, size.Y, size.Z)

			if not self.FlyingEffectsScaled then
				local autoScaleBaseline = self.FlyingEffectsAttachment:GetAttribute("AutoScaleBaseline")

				if autoScaleBaseline then
					local v5 = v4 / autoScaleBaseline

					for _, emitter in pairs(self.FlyingEffectsAttachment:GetDescendants()) do
						if emitter:IsA("ParticleEmitter") then
							Utilities.ScaleParticleEmitter(emitter, v5)
						end
					end
				end

				self.FlyingEffectsScaled = true
			end

			local v5 = self.Part.Position - v4 * 0.4 * vector
			self.FlyingEffectsAttachment.WorldCFrame = CFrame.new(v5, v5 + vector)

			if not self.FlyingEffectsOn then
				self.FlyingEffectsWrapper:PlayAll()
				self.FlyingEffectsOn = true
			end
		end,
		_CleanUpDebugParts = function(self)
			for _, debugPart in self.DebugParts do
				debugPart:Destroy()
			end

			table.clear(self.DebugParts)
		end
	}
end

function ReplacementPieceHandlerClass.New(p, items, p2: number, startParent, defaultParent, p3: number?, p4)
	local internalPieces = {}

	for _, item in items do
		table.insert(internalPieces, (GenerateInternalPiece(p, item, p2, startParent, defaultParent, p3, p4)))
	end

	local v = { InternalPieces = internalPieces }
	setmetatable(v, ReplacementPieceHandlerClass)
	v:_Init()
	return v
end

function ReplacementPieceHandlerClass:_Init()
	for _, internalPiece in self.InternalPieces do
		internalPiece:Init()
	end
end

function ReplacementPieceHandlerClass:Start(p)
	for _, internalPiece in self.InternalPieces do
		internalPiece:Start(p)
	end
end

function ReplacementPieceHandlerClass:UpdateStartBezierData(p)
	for _, internalPiece in self.InternalPieces do
		internalPiece:UpdateStartBezierData(p)
	end
end

function ReplacementPieceHandlerClass:Run(p: number)
	for _, internalPiece in self.InternalPieces do
		internalPiece:Run(p)
	end
end

function ReplacementPieceHandlerClass.IsRunning(p)
	for _, internalPiece in p.InternalPieces do
		if internalPiece.Running then
			return true
		end
	end

	return false
end

function ReplacementPieceHandlerClass:BreakOff(p: number?)
	for _, internalPiece in self.InternalPieces do
		internalPiece:BreakOff(p)
	end
end

function ReplacementPieceHandlerClass:Stop(flag: boolean?)
	for _, internalPiece in self.InternalPieces do
		internalPiece:Stop(flag)
	end
end

function ReplacementPieceHandlerClass.InstantCleanUp(p)
	for _, internalPiece in p.InternalPieces do
		internalPiece:Stop()
	end
end

function ReplacementPieceHandlerClass:SpeedMultiplierChanged(p: number)
	for _, internalPiece in self.InternalPieces do
		internalPiece:SpeedMultiplierChanged(p)
	end
end

return ReplacementPieceHandlerClass