local Achievements = {}
require(script.AchievementTypes)

local function handleChild(moduleScript)
	if not moduleScript:IsA("ModuleScript") then
		return
	end

	local name = moduleScript.Name
	local module = require(moduleScript)

	for k, v in module do
		if Achievements[k] then
			error(`COULD NOT IMPORT ACHIEVEMENT DATA FROM {moduleScript.Name} DUE TO DUPLICATE NAME -> {k}`)
		end

		v._Category = name
		v.Name = k
		Achievements[k] = v
	end
end

script.List.DescendantAdded:Connect(handleChild)

for _, child in script.List:GetChildren() do
	task.spawn(handleChild, child)
end

return Achievements