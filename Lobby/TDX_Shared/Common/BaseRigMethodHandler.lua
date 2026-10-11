local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Utilities = require(common:WaitForChild("Utilities"))
local Weld = Utilities.Weld
local GetPathFromParent = Utilities.GetPathFromParent

local function WeldAppearanceParts(folder, instance)
	instance:PivotTo(folder:GetPivot())
	instance.Parent = folder
	local parts = {}

	for _, part in folder:GetDescendants() do
		if part ~= folder.PrimaryPart and part:IsA("BasePart") then
			parts[GetPathFromParent(part, folder)] = part
		end
	end

	for _, folder2 in instance:GetChildren() do
		if folder2:IsA("Folder") and folder2.Name == "Animations" then
			folder2.Parent = folder
		end

		if folder2 == instance.PrimaryPart or folder2:IsA("Folder") then
			continue
		end

		local parent = parts[folder2.Name]

		if parent then
			for _, part in folder2:GetDescendants() do
				if part:IsA("BasePart") then
					Weld(folder2, part)
				end
			end

			Weld(parent, folder2)
			folder2.Parent = parent
			parent.Transparency = 1
		else
			warn(`ApplyMeshPartSkin: could not find matching instance for {folder2.Name}`)
		end
	end

	instance:Destroy()
end

local function CleanUpBaseRig(clone)
	local v = {
		clone:FindFirstChildOfClass("AnimationController"),
		clone:FindFirstChildOfClass("Humanoid"),
		clone:FindFirstChild("AnimSaves")
	}

	for _, v2 in pairs(v) do
		if v2 then
			v2:Destroy()
		end
	end
end

return {
	SetUp = function(instance, instance2)
		assert(instance, "BaseRigMethodHandler.SetUp: CharacterModel missing")
		assert(instance2, "BaseRigMethodHandler.SetUp: _Internal folder missing")
		local baseRigName = instance:GetAttribute("BaseRigName")

		if not baseRigName then
			error("BaseRigMethodHandler.SetUp: BaseRigName attribute not found")
		end

		local child = instance2:FindFirstChild(baseRigName)

		if not child then
			error(`BaseRigMethodHandler.SetUp: BaseRig {baseRigName} not found in _Internal folder`)
		end

		local clone = child:Clone()
		CleanUpBaseRig(clone)
		WeldAppearanceParts(clone, instance)
		return clone
	end
}