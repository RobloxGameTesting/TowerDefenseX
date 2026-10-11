local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local function SetEmittersEnabled(folder, enabled: boolean)
	for _, descendant in folder:GetDescendants() do
		if descendant:IsA("ParticleEmitter") then
			descendant.Enabled = enabled
		elseif descendant:IsA("Beam") then
			descendant.Enabled = enabled
		elseif descendant:IsA("ObjectValue") and descendant.Value then
			SetEmittersEnabled(descendant.Value, enabled)
		end
	end
end

local NameTagPart = { ClassName = script.Name, ClassModule = script }
NameTagPart.__index = NameTagPart

function NameTagPart.new(root)
	return (setmetatable({ Root = root, EffectsEnabled = true }, NameTagPart))
end

function NameTagPart.Init(p)
	p.Root.DescendantAdded:Connect(function(emitter)
		if emitter:IsA("ParticleEmitter") then
			emitter.Enabled = p.EffectsEnabled
		end
	end)
end

function NameTagPart:Update(flag: boolean)
	if not flag then
		self:_SetEffectsEnabled(false)
		return
	end

	local nameTag = self.Root:FindFirstChild("NameTag")

	if not nameTag then
		return
	end

	local worldToScreenPoint, _ = workspace.CurrentCamera:WorldToScreenPoint(self.Root.Position)
	self:_SetEffectsEnabled(worldToScreenPoint.Z <= nameTag.MaxDistance + 1)
end

function NameTagPart:_SetEffectsEnabled(effectsEnabled: boolean)
	if effectsEnabled == self.EffectsEnabled then
		return
	end

	self.EffectsEnabled = effectsEnabled
	SetEmittersEnabled(self.Root, effectsEnabled)
end

Director.Register(script.Name, { NameTagPart }, workspace)
return NameTagPart