local createVector = vector.create
local EasterEngineerCustomCodeClass = {}
EasterEngineerCustomCodeClass.__index = EasterEngineerCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
local Utilities = require(common:WaitForChild("Utilities"))
local LightAnimationHandlerClass = require(common:WaitForChild("LightAnimationHandlerClass"))
local MapHandler = require(common:WaitForChild("MapHandler"))
require(common:WaitForChild("PlacementHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local EntityUtilities = require(common:WaitForChild("EntityUtilities"))
local ReplacementPieceHandlerClass = require(common:WaitForChild("ReplacementPieceHandlerClass"))
local isClient = RunService:IsClient()
local v = { Cloak = 1, Eradicator = 2, Predator = 3, WarMachine = 4 }
local v2 = {
	[v.Cloak] = "Cloak",
	[v.Eradicator] = "Eradicator",
	[v.Predator] = "Predator",
	[v.WarMachine] = "WarMachine"
}
local v3 = { [v.Eradicator] = true, [v.Predator] = true, [v.WarMachine] = true }
local v4 = { [v.Eradicator] = 3.3, [v.Predator] = 4.4, [v.WarMachine] = 4.4 }
local v5 = { [v.Eradicator] = 1, [v.Predator] = 2, [v.WarMachine] = 3 }
local numberRange = NumberRange.new(70, 80)
local numberRange2 = NumberRange.new(-10, 10)
local Hidden = Lighting:WaitForChild("Hidden")
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local event = BindableHandler.GetEvent("SetSpeedMultiplier")
local event2 = BindableHandler.GetEvent("EasterEngineerStart")
local count = 0
local v6 = {}
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER

local function HideInstances(list)
	for _, instance in ipairs(list) do
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

local function ShowInstances(stageToNonReplacementInstance)
	for _, instance in ipairs(stageToNonReplacementInstance) do
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

local function ExplodePiece(folder, rootPart, value: number?, fadeOutCustomTime: number?, position: Vector3?)
	for _, jointInstance in pairs(folder:GetChildren()) do
		if jointInstance:IsA("JointInstance") then
			jointInstance.Enabled = false
		end
	end

	if position then
		folder.CFrame = CFrame.new(position) * folder.CFrame.Rotation
	end

	local unit = (folder.Position - rootPart.Position + createVector(0, 3, 0)).Unit
	local mass = folder:GetMass()
	folder:ApplyImpulse(math.random(40, 60) * unit * mass)
	task.delay(0.07, function()
		folder.CanCollide = true
		task.wait(value or 4)
		local total = 0
		fadeOutCustomTime = fadeOutCustomTime or 1.5

		while total < fadeOutCustomTime do
			total += task.wait()
			folder.Transparency = total / fadeOutCustomTime
		end

		folder.Anchored = true
		folder.CanCollide = false

		for _, emitter in pairs(folder:GetDescendants()) do
			if emitter:IsA("ParticleEmitter") then
				emitter.Enabled = false
			end
		end

		task.wait(3)
		folder:Destroy()
	end)
end

local function NewSupportPod(supportPod)
	local hash = count + 1
	count += 1
	local center = MapHandler.GetCenter()
	local randomNumberInNumberRange = Utilities.GetRandomNumberInNumberRange(numberRange)
	local vector = Vector3.new(
		Utilities.GetRandomNumberInNumberRange(numberRange2),
		randomNumberInNumberRange,
		Utilities.GetRandomNumberInNumberRange(numberRange2)
	)
	local cframe = CFrame.new(center + vector)
	supportPod:PivotTo(cframe + createVector(0, 500, 0))
	supportPod.Parent = raycastIgnore
	local primaryPart = supportPod.PrimaryPart
	primaryPart.Anchored = true
	local main_Body = primaryPart:FindFirstChild("Main_Body")
	main_Body.C0 = CFrame.new(main_Body.C0.Position) * CFrame.Angles(-0.05235987755982989, 0, 0)
	main_Body.C0 *= CFrame.Angles(0, math.rad((math.random(0, 360))), 0)
	local idleVFX = supportPod:FindFirstChild("IdleVFX")
	local emitterAndSoundWrapper = WrapperFactory.NewEmitterAndSoundWrapper(idleVFX, DEFAULT_SPEED_MULTIPLIER)
	emitterAndSoundWrapper:PlayAll()
	local deathVFX = supportPod:FindFirstChild("DeathVFX")
	local emitterAndSoundWrapper2 = WrapperFactory.NewEmitterAndSoundWrapper(deathVFX, DEFAULT_SPEED_MULTIPLIER)
	local crashStartVFX = supportPod:FindFirstChild("CrashStartVFX")
	local emitterAndSoundWrapper3 = WrapperFactory.NewEmitterAndSoundWrapper(crashStartVFX, DEFAULT_SPEED_MULTIPLIER)
	local animationHandler = LightAnimationHandlerClass.New(supportPod, DEFAULT_SPEED_MULTIPLIER)
	animationHandler:Play("Idle")
	local v7 = {
		Hash = hash,
		CharacterModel = supportPod,
		RootPart = primaryPart,
		MainBodyMotor6D = main_Body,
		AnimationHandler = animationHandler,
		HoverHeight = randomNumberInNumberRange,
		CFrame = cframe,
		IdleEffectsWrapper = emitterAndSoundWrapper,
		DeathEffectsWrapper = emitterAndSoundWrapper2,
		CrashStartEffectsWrapper = emitterAndSoundWrapper3,
		SpawnTimeLeft = 3,
		CrashStartPosition = nil,
		CrashGoalPosition = nil,
		CrashTimeLeft = 3.9,
		CrashStarted = false,
		Crashed = false,
		TimeUntilCanCleanUp = 5,
		CanCleanUp = false,
		DoorToOpen = nil,
		TimeUntilOpenDoor = nil,
		DoorForwardAttachments = {
			Utilities.TryGetInstanceFromPath(supportPod, "Door1>ForwardsPart>Forward"),
			Utilities.TryGetInstanceFromPath(supportPod, "Door2>ForwardsPart>Forward"),
			Utilities.TryGetInstanceFromPath(supportPod, "Door3>ForwardsPart>Forward")
		},
		GetBezierP1ForDoor = function(self, p: number, p2: number)
			local doorForwardAttachment = self.DoorForwardAttachments[p]

			if doorForwardAttachment then
				local position = primaryPart.CFrame.Position
				return position + p2 * (doorForwardAttachment.WorldCFrame.Position - position).Unit
			end

			warn("Door attachment not found for support pod")
			return primaryPart.CFrame.Position
		end,
		Run = function(self, p: number)
			if self.CanCleanUp then
				return
			end

			if not self.Crashed then
				self.MainBodyMotor6D.C0 *= CFrame.Angles(0, math.rad(p * 36), 0)

				if self.SpawnTimeLeft > 0 then
					self.SpawnTimeLeft -= p
					local vector2 = Vector3.new(0, math.clamp(self.SpawnTimeLeft / 3, 0, 1) ^ 4 * 500, 0)
					supportPod:PivotTo(self.CFrame + vector2)
				end

				self:_RunDoor(p)
			end

			if self.CrashStarted then
				self.CrashTimeLeft -= p

				if self.CrashTimeLeft > 0 then
					local v7 = (self.CrashTimeLeft / 3.9) ^ 0.4
					local lerped = self.CrashStartPosition:Lerp(self.CrashGoalPosition, 1 - v7)
					supportPod:PivotTo(CFrame.new(lerped) * supportPod:GetPivot().Rotation)
				else
					if not self.Crashed then
						self:_Crashed()
					end

					self.TimeUntilCanCleanUp -= p

					if self.TimeUntilCanCleanUp <= 0 then
						self.CanCleanUp = true
					end
				end
			end
		end,
		OpenDoor = function(self, doorToOpen: number, value: number?)
			self.DoorToOpen = doorToOpen
			self.TimeUntilOpenDoor = value or 0
		end,
		_RunDoor = function(self, p: number)
			if not self.DoorToOpen then
				return
			end

			self.TimeUntilOpenDoor -= p

			if self.TimeUntilOpenDoor <= 0 then
				self.AnimationHandler:Play("Door" .. tostring(self.DoorToOpen))
				self.DoorToOpen = nil
			end
		end,
		SpeedMultiplierChanged = function(self, p: number)
			self.AnimationHandler:SetSpeedMultiplier(p)
			self.IdleEffectsWrapper:SpeedMultiplierChanged(p)
			self.DeathEffectsWrapper:SpeedMultiplierChanged(p)
			self.CrashStartEffectsWrapper:SpeedMultiplierChanged(p)
		end,
		Death = function(self)
			self.AnimationHandler:PauseAdditiveAnimations()
			self.AnimationHandler:Play("Death")
			self.CrashStartEffectsWrapper:PlayAll()
			self.CrashStartPosition = supportPod:GetPivot().Position
			self.CrashGoalPosition = EntityUtilities.GetCrashLocation(
				supportPod:GetPivot().Position,
				self.HoverHeight,
				6.7
			)
			self.CrashStarted = true
		end,
		_Crashed = function(self)
			emitterAndSoundWrapper:StopContinuous()
			emitterAndSoundWrapper2:PlayAll()
			EntityUtilities.ExplodeParts(self.CharacterModel)
			self.Crashed = true
		end,
		CleanUp = function(self)
			supportPod:Destroy()
			v6[self.Hash] = nil
		end
	}
	v6[hash] = v7
	return v7
end

function EasterEngineerCustomCodeClass.New(speedMultiplier: number)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Include
	raycastParams.FilterDescendantsInstances = MapHandler.GetMapInstances()
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		PreviousAbilityName = nil,
		SupportPod = nil,
		RootPart = nil,
		ForwardAttachmentForReplacementParts = nil,
		PreviousParent = nil,
		ForceSpawnInTimeLeft = nil,
		Dead = false,
		BeamRaycastParams = raycastParams,
		LaserSweepOn = false,
		LaserArcBeam = nil,
		LaserArcAttachment = nil,
		Stage = nil,
		PreviousStage = nil,
		StageToNonReplacementInstances = {},
		StageToReplacementPieceHandler = {},
		StageToReplacementPieces = {},
		_TimingHelpers = { DeathTeleport = nil },
		_Wrappers = { LaserArcBeamEffects = nil }
	}, EasterEngineerCustomCodeClass))
end

function EasterEngineerCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local characterModel = self.CharacterModel
	local primaryPart = characterModel.PrimaryPart
	local appearance = characterModel:FindFirstChild("Appearance")
	self.RootPart = primaryPart
	self.ForwardAttachmentForReplacementPieces = primaryPart:FindFirstChild("ForwardAttachmentForReplacementPieces")
	local replacementPieceJet = characterModel:FindFirstChild("ReplacementPieceJet")
	local supportPod = characterModel:FindFirstChild("SupportPod")

	if supportPod then
		self.SupportPod = NewSupportPod(supportPod)
	else
		warn("Support pod character model not found")
	end

	for _, v7 in pairs(v) do
		local folder = appearance:FindFirstChild("Arm_" .. v2[v7])

		if folder then
			local descendants = {}

			for _, descendant in pairs(folder:GetDescendants()) do
				if
					descendant:GetAttribute("AttachTime")
					or not (descendant:IsA("BasePart") or descendant:IsA("FaceInstance"))
				then
					continue
				end

				table.insert(descendants, descendant)
			end

			self.StageToNonReplacementInstances[v7] = descendants

			if v3[v7] then
				local children = {}

				for _, child in pairs(folder:GetChildren()) do
					if child:GetAttribute("AttachTime") then
						table.insert(children, child)
					end
				end

				self.StageToReplacementPieceHandler[v7] = ReplacementPieceHandlerClass.New(
					characterModel,
					children,
					DEFAULT_SPEED_MULTIPLIER,
					supportPod,
					folder,
					1.8,
					replacementPieceJet
				)
				self.StageToReplacementPieces[v7] = children
			end
		else
			self.StageToNonReplacementInstances[v7] = {}
		end
	end

	self:SetStage(v.Cloak)
	local beam = characterModel:FindFirstChild("PredLaserArc"):FindFirstChild("Beam")
	local beam2 = beam:FindFirstChild("Beam")
	local firstChild = beam:FindFirstChild("End")
	self.LaserArcBeam = beam2
	self.LaserArcAttachment = firstChild
	self._Wrappers.LaserArcBeamEffects = WrapperFactory.NewEmitterAndSoundWrapper(beam, DEFAULT_SPEED_MULTIPLIER)
	self._TimingHelpers.DeathTeleport = TimingHelperClass.New({
		TimeUntilCallback = 6.1,
		Callback = function()
			HideInstances(Utilities.GetAllBasepartDescendants(self.CharacterModel))
		end
	})

	if workspace:GetAttribute("MapName") == Enums.Maps.Manufactorum then
		self.AnimationHandler:SetAnimationStateSpeed("Spawn", 0)
		self.PreviousParent = characterModel.Parent
		self.CharacterModel.Parent = Hidden
		self.ForceSpawnInTimeLeft = 6
		event2:AttachOnceCallback(function()
			if self.Dead then
				return
			end

			self:_ManufactorumSpawnIn()
		end)
	end
end

function EasterEngineerCustomCodeClass:_ManufactorumSpawnIn()
	self.AnimationHandler:SetAnimationStateSpeed("Spawn", 1)
	self.CharacterModel.Parent = self.PreviousParent
	self.ForceSpawnInTimeLeft = nil
end

function EasterEngineerCustomCodeClass:_GetReplacementPieceBezierP1(p: number, p2: number)
	local v7 = v5[p2]
	return self.SupportPod:GetBezierP1ForDoor(v7, p)
end

function EasterEngineerCustomCodeClass:_GetReplacementPieceBezierP2(p: number)
	local position = self.RootPart.CFrame.Position
	return position + p * (self.ForwardAttachmentForReplacementPieces.WorldCFrame.Position - position).Unit
end

function EasterEngineerCustomCodeClass:_GetStartBezierDataForStage(p: number)
	local magnitude = (self.RootPart.CFrame.Position - self.SupportPod.RootPart.CFrame.Position).Magnitude
	return {
		P1 = self:_GetReplacementPieceBezierP1(magnitude / 2, p),
		P2 = self:_GetReplacementPieceBezierP2(magnitude / 1.5)
	}
end

function EasterEngineerCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	if self.SupportPod then
		for k, v7 in pairs(self.StageToReplacementPieceHandler) do
			v7:Run(p)

			if v7:IsRunning() then
				v7:UpdateStartBezierData(self:_GetStartBezierDataForStage(k))
			end
		end
	end

	if self.ForceSpawnInTimeLeft then
		self.ForceSpawnInTimeLeft -= p

		if self.ForceSpawnInTimeLeft <= 0 then
			self:_ManufactorumSpawnIn()
		end
	end

	self:_RunLaserSweep()
end

function EasterEngineerCustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName
	local eradicator = nil
	local v7 = nil
	local v8 = nil
	local v9 = nil

	if previousAbilityName == Enums.EnemyAbilities.EasterEngineerArm_Eradicator then
		eradicator = v.Eradicator
		self.Enemy:SetBossMusicName("EasterEngineerBossMusic_Erad")
	elseif previousAbilityName == Enums.EnemyAbilities.EasterEngineerArm_Predator then
		eradicator = v.Predator
		self.Enemy:SetBossMusicName("EasterEngineerBossMusic_Pred")
	elseif previousAbilityName == Enums.EnemyAbilities.EasterEngineerArm_WarMachine then
		eradicator = v.WarMachine
		self.Enemy:SetBossMusicName("EasterEngineerBossMusic_WM")
	end

	if eradicator then
		v7 = v5[eradicator]
		v8 = v4[eradicator]
		v9 = self.StageToReplacementPieceHandler[eradicator]
	end

	if v7 and self.SupportPod then
		self.SupportPod:OpenDoor(v7, v8)
	end

	if v9 and self.SupportPod then
		v9:Start(self:_GetStartBezierDataForStage(eradicator))
	end

	if eradicator then
		self:_BlowOffPreviousStage()
		self.PreviousStage = eradicator
	end
end

function EasterEngineerCustomCodeClass:AbilityAnimationKeyframeReached(p: string, p2: string)
	if p == Enums.EnemyAbilities.EasterEngineerArm_Eradicator then
		if p2 == "Transition" then
			self:SetStage(v.Eradicator)
		end
	elseif p == Enums.EnemyAbilities.EasterEngineerArm_Predator then
		if p2 == "Transition" then
			self:SetStage(v.Predator)
		end
	elseif p == Enums.EnemyAbilities.EasterEngineerArm_WarMachine then
		if p2 == "Transition" then
			self:SetStage(v.WarMachine)
			local character = self.Character
			local characterModel = self.CharacterModel
			local v7 = {
				characterModel:FindFirstChild("EasterEngineerWMRocket1"),
				(characterModel:FindFirstChild("EasterEngineerWMRocket2"))
			}

			for _, v8 in pairs(v7) do
				for _, part in pairs(v8:GetChildren()) do
					if part:IsA("MeshPart") then
						part:SetAttribute("OriginalTransparency", 0)
					end
				end

				character:RegenerateProjectile(v8, 1, 1)
			end
		end
	elseif p == Enums.EnemyAbilities.EasterEngineerPredLaserArc then
		if p2 == "LaserStart" then
			self:_StartLaserSweep()
		elseif p2 == "LaserEnd" then
			self:_StopLaserSweep()
		end
	end
end

function EasterEngineerCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	for _, v7 in pairs(self.StageToReplacementPieceHandler) do
		v7:SpeedMultiplierChanged(speedMultiplier)
	end
end

function EasterEngineerCustomCodeClass:EnemyDestroyed(flag: boolean?, _: boolean?)
	self.Dead = true

	if flag then
		for _, v7 in pairs(self.StageToReplacementPieceHandler) do
			v7:InstantCleanUp()
		end

		if self.SupportPod then
			self.SupportPod:CleanUp()
		end
	else
		for _, v7 in pairs(self.StageToReplacementPieceHandler) do
			v7:Stop(true)
		end

		if self.SupportPod then
			self.SupportPod:Death()
		end

		self:_BlowOffPreviousStage()
		self._TimingHelpers.DeathTeleport:Start()
	end
end

function EasterEngineerCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function EasterEngineerCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function EasterEngineerCustomCodeClass:SetStage(stage: string)
	if self.Stage ~= stage then
		for k, stageToNonReplacementInstance in pairs(self.StageToNonReplacementInstances) do
			if k == stage then
				ShowInstances(stageToNonReplacementInstance)
			else
				HideInstances(stageToNonReplacementInstance)
			end
		end

		self.Stage = stage
	end
end

function EasterEngineerCustomCodeClass:_BlowOffPreviousStage()
	if self.PreviousStage then
		local stageToReplacementPiece = self.StageToReplacementPieces[self.PreviousStage]

		if stageToReplacementPiece then
			for _, v7 in pairs(stageToReplacementPiece) do
				local attachmentHelperPath = v7:GetAttribute("AttachmentHelperPath")
				local v8 = attachmentHelperPath
					and Utilities.TryGetInstanceFromPath(self.CharacterModel, attachmentHelperPath)
				ExplodePiece(
					v7,
					self.RootPart,
					(self.Config.FadeOutRemoveDelay or 0) + 5,
					self.Config.FadeOutCustomTime,
					v8 and v8.CFrame.Position
				)
			end
		end

		self.StageToReplacementPieces[self.PreviousStage] = nil
	end
end

function EasterEngineerCustomCodeClass:_StartLaserSweep()
	self.LaserSweepOn = true
	self.LaserArcBeam.Enabled = true
	self:_RunLaserSweep()
	self._Wrappers.LaserArcBeamEffects:PlayAll()
end

function EasterEngineerCustomCodeClass:_StopLaserSweep()
	self.LaserSweepOn = false
	self.LaserArcBeam.Enabled = false
	self:_RunLaserSweep()
	self._Wrappers.LaserArcBeamEffects:StopContinuous()
end

function EasterEngineerCustomCodeClass:_RunLaserSweep()
	if self.LaserSweepOn then
		local function RaycastForBeamHit(laserArcAttachment)
			if not self.BeamRaycastParams then
				warn("No BeamRaycastParams")
			end

			local parent = laserArcAttachment.Parent
			local position = parent.CFrame.Position
			local v7 = 30 * ((parent.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)).LookVector.Unit - createVector(0, 0.35, 0))
			local raycastResult = workspace:Raycast(position, v7, self.BeamRaycastParams)

			if raycastResult then
				laserArcAttachment.WorldCFrame = CFrame.new(raycastResult.Position)
			else
				laserArcAttachment.CFrame = CFrame.new(-30, 0, 0)
			end
		end

		RaycastForBeamHit(self.LaserArcAttachment)
	end
end

if isClient then
	RunService.Heartbeat:Connect(function(dt: number)
		local v7 = dt * DEFAULT_SPEED_MULTIPLIER

		for _, v8 in pairs(v6) do
			v8:Run(v7)

			if v8.CanCleanUp then
				v8:CleanUp()
			end
		end
	end)
	event:AttachCallback(function(p: number)
		DEFAULT_SPEED_MULTIPLIER = p

		for _, v7 in pairs(v6) do
			v7:SpeedMultiplierChanged(p)
		end
	end)
end

return EasterEngineerCustomCodeClass