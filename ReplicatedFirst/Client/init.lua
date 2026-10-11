debug.setmemorycategory("Client/Init")

local function bigprint(CLIENT_STATUS) -- 13 equivalent calls inferred from this helper
	workspace:SetAttribute("CLIENT_STATUS", CLIENT_STATUS)
end

if not workspace:GetAttribute("SERVER_LOADED") then
	bigprint("Waiting for server load...") -- inferred equivalent call

	repeat
		task.wait(0.2)
	until workspace:GetAttribute("SERVER_LOADED")
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local isStudio = RunService:IsStudio()
require(ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common"):WaitForChild("GlobalConstants"))
local RunService2 = game:GetService("RunService")
local v = RunService2:IsServer() and "(Server)" or "(Client)"
local Modules = ReplicatedStorage:WaitForChild("Modules")
local require = require

local function require2(p)
	os.clock()
	local v2 = false
	task.delay(5, function()
		if not v2 and isStudio then
			warn(script.Name, v, "//", p.Name, "is taking a long time to load...")
			bigprint(p.Name .. " is taking a long time to load...") -- inferred equivalent call
		end
	end)
	local module = require(p)
	v2 = true
	return module
end

local lastTime = os.clock()
bigprint("Loading...") -- inferred equivalent call
bigprint("Loading shared modules...") -- inferred equivalent call

for _, moduleScript in Modules:GetChildren() do
	if not moduleScript:IsA("ModuleScript") then
		continue
	end

	os.clock()
	local v2 = false
	local v3 = moduleScript
	task.delay(5, function()
		if not v2 and isStudio then
			warn(script.Name, v, "//", v3.Name, "is taking a long time to load...")
			bigprint(v3.Name .. " is taking a long time to load...") -- inferred equivalent call
		end
	end)
	require(moduleScript)
	v2 = true
end

for _, moduleScript in Modules.Parent:WaitForChild("TDX_Shared"):GetChildren() do
	if not moduleScript:IsA("ModuleScript") then
		continue
	end

	os.clock()
	local v2 = false
	local v3 = moduleScript
	task.delay(5, function()
		if not v2 and isStudio then
			warn(script.Name, v, "//", v3.Name, "is taking a long time to load...")
			bigprint(v3.Name .. " is taking a long time to load...") -- inferred equivalent call
		end
	end)
	require(moduleScript)
	v2 = true
end

bigprint("Loading main modules...") -- inferred equivalent call

for _, moduleScript in script:GetDescendants() do
	if not moduleScript:IsA("ModuleScript") then
		continue
	end

	os.clock()
	local v2 = false
	local v3 = moduleScript
	task.delay(5, function()
		if not v2 and isStudio then
			warn(script.Name, v, "//", v3.Name, "is taking a long time to load...")
			bigprint(v3.Name .. " is taking a long time to load...") -- inferred equivalent call
		end
	end)
	require(moduleScript)
	v2 = true
end

bigprint("Loading classes...") -- inferred equivalent call

for _, moduleScript in game.ReplicatedFirst.Classes:GetDescendants() do
	if not moduleScript:IsA("ModuleScript") then
		continue
	end

	os.clock()
	local v2 = false
	local v3 = moduleScript
	task.delay(5, function()
		if not v2 and isStudio then
			warn(script.Name, v, "//", v3.Name, "is taking a long time to load...")
			bigprint(v3.Name .. " is taking a long time to load...") -- inferred equivalent call
		end
	end)
	require(moduleScript)
	v2 = true
end

for _, moduleScript in game.ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Components"):GetDescendants() do
	if not moduleScript:IsA("ModuleScript") then
		continue
	end

	os.clock()
	local v2 = false
	local v3 = moduleScript
	task.delay(5, function()
		if not v2 and isStudio then
			warn(script.Name, v, "//", v3.Name, "is taking a long time to load...")
			bigprint(v3.Name .. " is taking a long time to load...") -- inferred equivalent call
		end
	end)
	require(moduleScript)
	v2 = true
end

bigprint("Loaded in " .. string.format("%.6f", os.clock() - lastTime) .. " seconds!") -- inferred equivalent call
task.delay(2, function()
	bigprint(nil) -- inferred equivalent call
end)