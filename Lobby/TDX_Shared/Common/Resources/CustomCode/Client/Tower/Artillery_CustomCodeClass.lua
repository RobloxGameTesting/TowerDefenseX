local ArtilleryCustomCodeClass = {}
ArtilleryCustomCodeClass.__index = ArtilleryCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
require(common:WaitForChild("WrapperFactory"))

function ArtilleryCustomCodeClass.New(_: number)
	return (setmetatable({
		Tower = nil,
		ShellModel = nil,
		Charge = nil,
		LevelOnPath1 = 0,
		Reloading = false,
		ShellVisible = true,
		ChargeVisible = true,
		TimeUntilShowShell = 0,
		TimeUntilHideShell = 0,
		TimeUntilShowCharge = 0,
		TimeUntilHideCharge = 0
	}, ArtilleryCustomCodeClass))
end

function ArtilleryCustomCodeClass:Initialize(tower, _)
	self.Tower = tower
	self:_GetShellAndCharge()
end

function ArtilleryCustomCodeClass:Run_FromCharacter(p: number)
	if self.ShellModel then
		if self.Reloading then
			self.TimeUntilShowShell -= p
			self.TimeUntilHideShell -= p

			if self.TimeUntilHideShell <= 0 then
				self:_HideShellModel()
			elseif self.TimeUntilShowShell <= 0 then
				self:_ShowShellModel()
			end
		else
			self:_HideShellModel()
		end
	end

	if self.Charge then
		if self.Reloading then
			self.TimeUntilShowCharge -= p
			self.TimeUntilHideCharge -= p

			if self.TimeUntilHideCharge <= 0 then
				self:_HideCharge()
			elseif self.TimeUntilShowCharge <= 0 then
				self:_ShowCharge()
			end
		else
			self:_HideCharge()
		end
	end
end

function ArtilleryCustomCodeClass.AbilityUsed(_, _) end

function ArtilleryCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function ArtilleryCustomCodeClass.SpeedMultiplierChanged_FromCharacter(_, _: number) end

function ArtilleryCustomCodeClass:Upgraded(_)
	self:_GetShellAndCharge()
end

function ArtilleryCustomCodeClass.CharacterCleanedUp(_) end

function ArtilleryCustomCodeClass:AnimationStateChanged(p: string, _)
	if p ~= "Reload" then
		self.Reloading = false
		return
	end

	if self.LevelOnPath1 == 5 then
		self.TimeUntilShowShell = 0.666
		self.TimeUntilHideShell = 3.1
		self.TimeUntilShowCharge = 3.65
		self.TimeUntilHideCharge = 4
	elseif self.LevelOnPath1 >= 3 then
		self.TimeUntilShowShell = 0.833
		self.TimeUntilHideShell = 2.5
		self.TimeUntilShowCharge = 3.1
		self.TimeUntilHideCharge = 3.5
	else
		self.TimeUntilShowShell = 1.5
		self.TimeUntilHideShell = 3.33
	end

	self.Reloading = true
end

function ArtilleryCustomCodeClass.Attacked(_, _, _: boolean?) end

function ArtilleryCustomCodeClass.Death(_) end

function ArtilleryCustomCodeClass:_GetShellAndCharge()
	self.LevelOnPath1 = self.Tower.LevelHandler:GetLevelOnPath(1)
	local character = self.Tower.Character
	local skinName = self.Tower.SkinName
	local artyLoader = character:GetCharacterModel():FindFirstChild("ArtyLoader")
	local shell

	if skinName == "Party" then
		shell = artyLoader and artyLoader:FindFirstChild("Appearance"):FindFirstChild("Shell")
	elseif skinName == "Easter" then
		return
	else
		shell = artyLoader and artyLoader:FindFirstChild("Shell")
	end

	if shell then
		for _, part in pairs(shell:GetDescendants()) do
			if not part:IsA("BasePart") or part:GetAttribute("OriginalTransparency") then
				continue
			end

			part:SetAttribute("OriginalTransparency", part.Transparency)
		end

		self.ShellVisible = true
	end

	self.ShellModel = shell
	self:_HideShellModel()

	if self.LevelOnPath1 >= 3 then
		local rightArm = artyLoader:FindFirstChild("Right Arm")
		self.Charge = rightArm and rightArm:FindFirstChildOfClass("MeshPart")
	end
end

function ArtilleryCustomCodeClass:_HideShellModel()
	if self.ShellModel and self.ShellVisible then
		self.ShellVisible = false

		for _, part in pairs(self.ShellModel:GetDescendants()) do
			if part:IsA("BasePart") then
				part.Transparency = 1
			end
		end

		if self.ShellModel:IsA("BasePart") then
			self.ShellModel.Transparency = 1
		end
	end
end

function ArtilleryCustomCodeClass:_ShowShellModel()
	if self.ShellModel and not self.ShellVisible then
		self.ShellVisible = true

		for _, part in pairs(self.ShellModel:GetDescendants()) do
			if part:IsA("BasePart") then
				part.Transparency = part:GetAttribute("OriginalTransparency")
			end
		end

		if self.ShellModel:IsA("BasePart") then
			self.ShellModel.Transparency = 0
		end
	end
end

function ArtilleryCustomCodeClass:_HideCharge()
	if self.Charge and self.ChargeVisible then
		self.ChargeVisible = false
		self.Charge.Transparency = 1
	end
end

function ArtilleryCustomCodeClass:_ShowCharge()
	if self.Charge and not self.ChargeVisible then
		self.ChargeVisible = true
		self.Charge.Transparency = 0
	end
end

return ArtilleryCustomCodeClass