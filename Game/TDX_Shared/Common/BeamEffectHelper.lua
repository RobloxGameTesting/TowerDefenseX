local BeamEffectHelper = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local Utilities = require(common:WaitForChild("Utilities"))
local EntityUtilities = require(common:WaitForChild("EntityUtilities"))
local ProjectileUtilities = require(common:WaitForChild("ProjectileUtilities"))

local function ScaleBeam(instance, p: number)
	if not instance:GetAttribute("OriginalWidth0") then
		instance:SetAttribute("OriginalWidth0", instance.Width0)
	end

	if not instance:GetAttribute("OriginalWidth1") then
		instance:SetAttribute("OriginalWidth1", instance.Width1)
	end

	instance.Width0 = instance:GetAttribute("OriginalWidth0") * p
	instance.Width1 = instance:GetAttribute("OriginalWidth1") * p
end

local function SetUpChainBeams(item, list)
	local count = #list

	if item.ChainSetUpCount < count then
		for i = item.ChainSetUpCount + 1, count do
			local clone = item.ParentInstance:Clone()
			clone.Name ..= "Chain" .. i
			clone.Parent = item.ParentInstance.Parent
			local start = clone:FindFirstChild("Start")
			local firstChild = clone:FindFirstChild("End")

			if start then
				start:Destroy()
			end

			if firstChild then
				table.insert(item.ChainAttachments, firstChild)
			end

			local v = {}

			for _, v2 in pairs(Utilities.GetAllBasepartDescendants(firstChild)) do
				table.insert(v, v2)
			end

			table.insert(item.ChainEndParts, v)
			local beams = {}

			for _, beam in pairs(clone:GetDescendants()) do
				if not beam:IsA("Beam") then
					continue
				end

				table.insert(beams, beam)

				if i == 1 then
					beam.Attachment0 = item.EndAttachment
				else
					beam.Attachment0 = item.ChainAttachments[i - 1]
				end
			end

			table.insert(item.ChainBeamsTable, beams)
			table.insert(
				item.ChainEffectWrappers,
				WrapperFactory.NewEmitterAndSoundWrapper(clone, item.SpeedMultiplier)
			)
		end

		item.ChainSetUpCount = count
	end
end

local function ToggleChainEffects(item, flag: boolean) -- 2 equivalent calls inferred from this helper
	local chainActiveCount = item.ChainActiveCount

	for i = 1, item.ChainSetUpCount do
		local chainEffectWrapper = item.ChainEffectWrappers[i]

		if not chainEffectWrapper then
			continue
		end

		if flag and i <= chainActiveCount then
			chainEffectWrapper:PlayAll()
		else
			chainEffectWrapper:StopContinuous()
		end
	end
end

local function ToggleChainBeams(item, flag: boolean)
	local chainActiveCount = item.ChainActiveCount

	for i = 1, item.ChainSetUpCount do
		local v = item.ChainBeamsTable[i]

		if not v then
			continue
		end

		for _, v2 in pairs(v) do
			v2.Enabled = flag and i <= chainActiveCount
		end
	end
end

function BeamEffectHelper.NewBeamEffects(p, list, speedMultiplier: number, targetEntityUniqueId: number?)
	local result = {}

	for i, v in ipairs(list) do
		local ignoreIfNotFound = v.IgnoreIfNotFound
		local makeNewBeam = v.MakeNewBeam
		local v2 = {
			Index = i,
			Duration = v.BeamDuration or 1e999,
			OverrideDelay = v.BeamOverrideDelay,
			GoalPosition = Vector3.new(),
			GoalPositionOffset = Vector3.new(),
			TrackCharacter = nil,
			TargetHead = v.TargetHead,
			TargetGround = v.TargetGround,
			TargetEntityUniqueId = targetEntityUniqueId,
			Active = false,
			On = false,
			ParentInstance = nil,
			IgnoreIfNotFound = ignoreIfNotFound,
			DestroyOnFinish = makeNewBeam,
			TimeUntilDestroy = nil,
			Destroyed = false,
			StartAttachment = nil,
			EndAttachment = nil,
			Beams = {},
			EffectWrapper = nil,
			Scale = 1,
			TimeUntilStart = 0,
			TimeUntilStop = 0,
			OscillationXZ = v.OscillationXZ,
			OscillationXZPeriod = v.OscillationXZPeriod,
			OscillationY = v.OscillationY,
			OscillationYPeriod = v.OscillationYPeriod,
			Lifetime = 0,
			CurrentOffset = Vector3.new(),
			NoTriggerEffects = false,
			SpeedMultiplier = speedMultiplier,
			ChainBeamsTable = {},
			ChainAttachments = {},
			ChainEndParts = {},
			ChainGoalPositionOffsets = {},
			ChainTrackCharacters = {},
			ChainEffectWrappers = {},
			ChainSetUpCount = 0,
			ChainActiveCount = 0,
			ChainOnCount = 0
		}
		local beamParentInstancePath = v.BeamParentInstancePath
		local beamParentInstanceName = v.BeamParentInstanceName
		local folder

		if beamParentInstancePath then
			folder = p

			for _, childName in pairs(beamParentInstancePath) do
				folder = folder:FindFirstChild(childName)

				if folder then
					continue
				end

				warn("BeamEffectHelper.NewBeamEffects: Beam effect parent instance path not found: " .. childName)
				return
			end
		elseif beamParentInstanceName then
			folder = Utilities.TryGetInstanceFromPath(p, beamParentInstanceName)
		else
			warn("BeamEffectHelper.NewBeamEffects: Beam effect parent instance path or name not found")
			return
		end

		if folder then
			if makeNewBeam then
				local clone = folder:Clone()
				clone.Name = folder.Name .. #result + 1
				clone.Parent = folder.Parent
				folder = clone
			end

			local start = folder:FindFirstChild("Start")

			if not start then
				warn("BeamEffectHelper.NewBeamEffects: start attachment not found")
				return
			end

			local firstChild = folder:FindFirstChild("End")

			if not firstChild then
				warn("BeamEffectHelper.NewBeamEffects: end attachment not found")
				return
			end

			for _, beam in pairs(folder:GetDescendants()) do
				if beam:IsA("Beam") then
					table.insert(v2.Beams, beam)
				end
			end

			v2.ParentInstance = folder
			v2.StartAttachment = start
			v2.EndAttachment = firstChild
			v2.EffectWrapper = WrapperFactory.NewEmitterAndSoundWrapper(folder, speedMultiplier)
			local endParts = {}

			for _, v3 in pairs(Utilities.GetAllBasepartDescendants(firstChild)) do
				table.insert(endParts, v3)
			end

			v2.EndParts = endParts

			if v.OriginVarianceXZ or v.OriginVarianceY then
				local randomOffsetPosition = ProjectileUtilities.RandomOffsetPosition(
					Vector3.new(),
					v.OriginVarianceXZ,
					v.OriginVarianceY
				)
				start.CFrame += randomOffsetPosition
			end

			table.insert(result, v2)
		elseif not ignoreIfNotFound then
			warn("BeamEffectHelper.NewBeamEffects: Beam effect parent instance not found")
			return
		end
	end

	BeamEffectHelper.SpeedMultiplierChanged(speedMultiplier, result)
	return result
end

function BeamEffectHelper.StartBeamEffects(items, value: number?, p: number?, goalPosition: Vector3?, trackCharacter, noTriggerEffects: boolean?, list, p2: number?)
	local function GetGoalPositionOffset(position: Vector3, object, targetHead: boolean?, targetGround: boolean?)
		if object and object:GetCharacterModel():GetAttribute("TargetTorsoBounds") then
			local effectFollowPart = EntityUtilities.GetEffectFollowPart(object, targetHead, targetGround)
			return EntityUtilities.GetPointOnPartBounds(position, effectFollowPart) - effectFollowPart.Position
		else
			return (Vector3.new())
		end
	end

	for _, item in pairs(items) do
		if not (not p2 or item.Index == p2) then
			continue
		end

		if goalPosition then
			item.GoalPosition = goalPosition
		end

		item.GoalPositionOffset = GetGoalPositionOffset(
			item.StartAttachment.WorldCFrame.Position,
			trackCharacter,
			item.TargetHead,
			item.TargetGround
		)
		item.TrackCharacter = trackCharacter
		item.TimeUntilStart = item.OverrideDelay or value or 0
		item.TimeUntilStop = p or item.Duration
		item.NoTriggerEffects = noTriggerEffects

		if list then
			SetUpChainBeams(item, list)

			for k, v in pairs(list) do
				local endAttachment = k == 1 and item.EndAttachment or item.ChainAttachments[k - 1]
				item.ChainTrackCharacters[k] = v
				item.ChainGoalPositionOffsets[k] = GetGoalPositionOffset(
					endAttachment.WorldCFrame.Position,
					v,
					item.TargetHead,
					item.TargetGround
				)
			end

			item.ChainActiveCount = #list
		end

		item.Active = true
	end
end

function BeamEffectHelper.StopBeamEffects(items)
	for _, item in pairs(items) do
		item.EffectWrapper:StopContinuous()
		item.EffectWrapper:FadeOutPlayingTriggeredSounds()
		ToggleChainEffects(item, false) -- inferred equivalent call

		for _, beam in pairs(item.Beams) do
			beam.Enabled = false
		end

		ToggleChainBeams(item, false)
		item.TimeUntilStop = 0
		item.On = false
		item.Active = false
	end
end

function BeamEffectHelper.RunBeamEffects(p: number, items)
	for _, item in pairs(items) do
		if item.ParentInstance.Parent == nil and not item.IgnoreIfNotFound then
			item.Destroyed = true
		end

		if item.Destroyed then
			continue
		end

		if item.TimeUntilDestroy then
			item.TimeUntilDestroy -= p

			if item.TimeUntilDestroy <= 0 then
				item.ParentInstance:Destroy()
				item.Destroyed = true
			end
		end

		item.Lifetime += p

		if item.TimeUntilStart > 0 then
			item.TimeUntilStart -= p
		else
			if item.Active then
				if not item.On then
					if not item.NoTriggerEffects then
						item.EffectWrapper:PlayAll()
					end

					for _, beam in pairs(item.Beams) do
						beam.Enabled = true
					end

					item.On = true
				end

				local oscillationXZ = item.OscillationXZ
				local oscillationY = item.OscillationY

				if oscillationXZ then
					local oscillationXZPeriod = item.OscillationXZPeriod
					item.CurrentOffset = Vector3.new(
						math.sin(6.283185307179586 * item.Lifetime / oscillationXZPeriod) * oscillationXZ,
						item.CurrentOffset.Y,
						math.cos(6.283185307179586 * item.Lifetime / oscillationXZPeriod) * oscillationXZ
					)
				end

				if oscillationY then
					local oscillationYPeriod = item.OscillationYPeriod
					item.CurrentOffset = Vector3.new(
						item.CurrentOffset.X,
						math.sin(6.283185307179586 * item.Lifetime / oscillationYPeriod) * oscillationY,
						item.CurrentOffset.Z
					)
				end
			end

			if item.ChainActiveCount ~= item.ChainOnCount then
				if not item.NoTriggerEffects then
					ToggleChainEffects(item, true)
				end

				ToggleChainBeams(item, true)
				item.ChainOnCount = item.ChainActiveCount
			end

			local v

			if item.TrackCharacter then
				v = EntityUtilities.GetEffectFollowPart(item.TrackCharacter, item.TargetHead, item.TargetGround)
			end

			local position = v and v.Position or item.GoalPosition
			local cframe = CFrame.new(position + item.GoalPositionOffset + item.CurrentOffset)
			item.EndAttachment.WorldCFrame = cframe

			for _, endPart in pairs(item.EndParts) do
				endPart.CFrame = cframe
			end

			for i, chainAttachment in ipairs(item.ChainAttachments) do
				local chainTrackCharacter = item.ChainTrackCharacters[i]

				if not chainTrackCharacter then
					continue
				end

				local effectFollowPart = EntityUtilities.GetEffectFollowPart(
					chainTrackCharacter,
					item.TargetHead,
					item.TargetGround
				)
				local cframe2 = CFrame.new(effectFollowPart.Position + item.ChainGoalPositionOffsets[i] + item.CurrentOffset)
				chainAttachment.WorldCFrame = cframe2

				for _, v2 in pairs(item.ChainEndParts[i]) do
					v2.CFrame = cframe2
				end
			end

			if item.TimeUntilStop > 0 then
				item.TimeUntilStop -= p
			elseif item.On then
				item.EffectWrapper:StopContinuous()
				ToggleChainEffects(item, false) -- inferred equivalent call

				for _, beam in pairs(item.Beams) do
					beam.Enabled = false
				end

				ToggleChainBeams(item, false)
				item.On = false
				item.Active = false
				item.ChainActiveCount = 0

				if item.DestroyOnFinish then
					item.TimeUntilDestroy = 5
				end
			end
		end
	end
end

function BeamEffectHelper.GetBeamsByTargetEntityUniqueId(items, p: number)
	local result = {}

	for _, item in pairs(items) do
		for _, v in pairs(item) do
			if v.TargetEntityUniqueId == p then
				table.insert(result, v)
			end
		end
	end

	return result
end

function BeamEffectHelper.ScaleTo(items, scale: number, p: number?)
	local v = p or scale

	for _, item in pairs(items) do
		if item.Scale == scale then
			continue
		end

		item.Scale = scale
		item.EffectWrapper:ScaleEmitters(scale)

		for _, beam in pairs(item.Beams) do
			ScaleBeam(beam, v)
		end

		for _, chainEffectWrapper in pairs(item.ChainEffectWrappers) do
			chainEffectWrapper:ScaleEmitters(scale)
		end

		for _, v2 in pairs(item.ChainBeamsTable) do
			for _, v3 in pairs(v2) do
				ScaleBeam(v3, v)
			end
		end
	end
end

function BeamEffectHelper.SpeedMultiplierChanged(speedMultiplier: number, items)
	for _, item in pairs(items) do
		item.SpeedMultiplier = speedMultiplier
		item.EffectWrapper:SpeedMultiplierChanged(speedMultiplier)

		for _, beam in pairs(item.Beams) do
			if not beam:GetAttribute("OriginalTextureSpeed") then
				beam:SetAttribute("OriginalTextureSpeed", beam.TextureSpeed)
			end

			beam.TextureSpeed = beam:GetAttribute("OriginalTextureSpeed") * speedMultiplier
		end

		for _, chainEffectWrapper in pairs(item.ChainEffectWrappers) do
			chainEffectWrapper:SpeedMultiplierChanged(speedMultiplier)
		end

		for _, v in pairs(item.ChainBeamsTable) do
			for _, v2 in pairs(v) do
				if not v2:GetAttribute("OriginalTextureSpeed") then
					v2:SetAttribute("OriginalTextureSpeed", v2.TextureSpeed)
				end

				v2.TextureSpeed = v2:GetAttribute("OriginalTextureSpeed") * speedMultiplier
			end
		end
	end
end

function BeamEffectHelper.ReadyToCleanUp(items)
	for _, item in pairs(items) do
		if not item.Destroyed then
			return false
		end
	end

	return true
end

return BeamEffectHelper