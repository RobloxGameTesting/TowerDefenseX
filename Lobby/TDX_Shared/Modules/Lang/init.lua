local CollectionService = game:GetService("CollectionService")
local English = require(script.List.English)
local Signal = require(game.ReplicatedStorage.TDX_Shared.Modules.Signal)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local TextInstance = require(game.ReplicatedStorage.TDX_Shared.Components.TextInstance)

local function convertArgsToStrings(...)
	local v = table.create(select("#", ...))

	for k, v2 in { ... } do
		v[k] = tostring(v2)
	end

	return table.concat(v, "$£$")
end

local function setupPointer()
	local class = {}

	function class.__index(p, path)
		local v = rawget(p, "__PATH")

		if v then
			path = v .. "." .. path or path
		end

		return (setmetatable({ __PATH = path }, class))
	end

	return (setmetatable({}, class))
end

local module = English
local Lang = { Strings = setupPointer(), LanguageUpdated = Signal.new() }

function Lang.UpdateLanguage(childName: string)
	module = require(script.List:FindFirstChild(childName) or script.List.English)
	Lang.LanguageUpdated:Fire(childName)
end

function Lang.Set(instance, p, ...)
	instance:SetAttribute("LangIndex", p.__PATH)
	instance:SetAttribute("LangStrings", convertArgsToStrings(...))

	if not CollectionService:HasTag(instance, "TextInstance") then
		CollectionService:AddTag(instance, "TextInstance")
	end

	task.spawn(function()
		Director.GetClassObjectYields(instance, TextInstance):Update()
	end)
end

function Lang.GetInternal(value: string)
	local v = string.split(value, ".")
	local v2 = module

	for _, v3 in v do
		v2 = v2[v3]

		if v2 == nil then
			break
		end
	end

	return v2
end

function Lang:Get(...)
	debug.profilebegin("Lang.Get")
	local v = string.split(self.__PATH, ".")
	local v2 = module

	for _, v3 in v do
		v2 = v2[v3]

		if v2 == nil then
			break
		end
	end

	debug.profileend()
	return v2 and string.format(v2, ...)
end

Lang.LanguageUpdated:Connect(function()
	for _, v in Director.GetItemsFromClass(TextInstance) do
		task.defer(v.Update, v)
	end
end)
Lang.UpdateLanguage("English")
return Lang