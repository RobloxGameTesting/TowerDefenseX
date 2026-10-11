local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local PingConfig = require(common:WaitForChild("PingConfig"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local pingVFX = common:WaitForChild("Resources"):WaitForChild("Misc"):WaitForChild("PingVFX")
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")

local function GetPingsFolder()
	local pings = raycastIgnore:FindFirstChild("Pings")

	if pings then
		return pings
	end

	local folder = Instance.new("Folder")
	folder.Name = "Pings"
	folder.Parent = raycastIgnore
	return folder
end

local function SyncEmitterLifetimes(clone)
	local numberRange = NumberRange.new(PingConfig.WorldLifetimeSeconds)
	local ringAttachment = clone:FindFirstChild("RingAttachment")

	if ringAttachment then
		for _, emitter in ipairs(ringAttachment:GetChildren()) do
			if not (emitter:IsA("ParticleEmitter") and string.match(emitter.Name, "^Ring Main")) then
				continue
			end

			emitter.Lifetime = numberRange
		end
	end

	local flagAttachment = clone:FindFirstChild("FlagAttachment")

	if flagAttachment then
		for _, emitter in ipairs(flagAttachment:GetChildren()) do
			if emitter:IsA("ParticleEmitter") and emitter.Name == "Flag" then
				emitter.Lifetime = numberRange
			end
		end
	end
end

local function EmitAll(folder)
	for _, emitter in ipairs(folder:GetDescendants()) do
		if not emitter:IsA("ParticleEmitter") then
			continue
		end

		local emitCount = emitter:GetAttribute("EmitCount")
		emitter:Emit(type(emitCount) ~= "number" and 1 or emitCount)
	end
end

return {
	Render = function(pingSlotIndex: number, vector: Vector3, _: string?, senderUserId: number?)
		local ping = PingConfig.Pings[pingSlotIndex]

		if not ping then
			return
		end

		local part = pingVFX:FindFirstChild(ping.Id)

		if not (part and part:IsA("BasePart")) then
			return
		end

		local clone = part:Clone()
		clone.CFrame = CFrame.new(vector + Vector3.new(0, clone.Size.Y * 0.5, 0) + PingConfig.WorldOffset)
		clone:SetAttribute("PingSlotIndex", pingSlotIndex)

		if senderUserId then
			clone:SetAttribute("SenderUserId", senderUserId)
		end

		local parent = raycastIgnore:FindFirstChild("Pings")

		if not parent then
			parent = Instance.new("Folder")
			parent.Name = "Pings"
			parent.Parent = raycastIgnore
		end

		clone.Parent = parent
		CollectionService:AddTag(clone, PingConfig.ActivePingTag)
		SyncEmitterLifetimes(clone)
		EmitAll(clone)
		SoundHandler.Play(ping.Sfx)
		task.delay(PingConfig.WorldLifetimeSeconds, function()
			if clone.Parent then
				clone:Destroy()
			end
		end)
	end
}