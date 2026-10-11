local Signal = require(game.ReplicatedStorage.TDX_Shared.Modules.Signal)
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local v = RunService:IsServer() and "(Server)" or "(Client)"
local Director = {
	Classes = {},
	Registered = {},
	RegisteredObjects = {},
	ItemsWithClasses = {},
	ClassesWithItems = {},
	ClassObjectInstantiated = Signal.new()
}

local function doDestroy(p)
	if not p.Destroy then
		return
	end

	pcall(p.Destroy, p)
end

local function doCreate(p, descendant) -- 1 equivalent call inferred from this helper
	local v2 = p.new(descendant)
	task.spawn(function()
		v2:Init()
	end)
	return v2
end

local connectionsByClassName = {}
local v2 = {}
local v3 = {}

function Director.Register(tag: string, items, instance)
	if Director.Registered[tag] then
		warn(tag, "is already registered!")
		return
	end

	local function added(descendant)
		if instance and not instance:IsAncestorOf(descendant) then
			return
		end

		local v4 = Director.ItemsWithClasses[descendant] or {}

		for _, item in pairs(items) do
			if v4[item] then
				continue
			end

			local v5 = item
			task.spawn(function()
				local v6 = doCreate(v5, descendant) -- inferred equivalent call

				if v6 then
					v4[v5] = v6
					Director.RegisteredObjects[descendant] = true
					Director.Classes[v5.ClassName] = v5
					Director.ClassesWithItems[v5] = Director.ClassesWithItems[v5] or {}
					table.insert(Director.ClassesWithItems[v5], v6)
					Director.ClassObjectInstantiated:Fire(v5, descendant, v6)
				end
			end)
		end

		Director.ItemsWithClasses[descendant] = v4
	end

	local function removed(p)
		if not Director.RegisteredObjects[p] then
			return
		end

		local itemsWithClass = Director.ItemsWithClasses[p]

		if not itemsWithClass then
			return
		end

		for k, v4 in pairs(itemsWithClass) do
			local index = table.find(Director.ClassesWithItems[k], v4)

			if index then
				table.remove(Director.ClassesWithItems[k], index)
			end

			task.spawn(doDestroy, v4)
		end

		Director.ItemsWithClasses[p] = nil
		Director.RegisteredObjects[p] = nil
	end

	for _, v4 in pairs(CollectionService:GetTagged(tag)) do
		added(v4)
	end

	v2[tag] = CollectionService:GetInstanceAddedSignal(tag):Connect(added)
	v3[tag] = CollectionService:GetInstanceRemovedSignal(tag):Connect(removed)
	Director.Registered[tag] = true

	if RunService:IsStudio() then
		for _, item in items do
			if connectionsByClassName[item.ClassName] then
				continue
			end

			local v4 = item
			connectionsByClassName[item.ClassName] = item.ClassModule.Changed:Connect(function()
				Director.ReloadClass(v4.ClassModule)
			end)
		end
	end
end

function Director.GetItemsFromClass(p)
	return Director.ClassesWithItems[p] or {}
end

function Director.GetFirstItemFromClass(p)
	return (Director.ClassesWithItems[p] or {})[1]
end

function Director.GetClassesFromItem(p)
	return Director.ItemsWithClasses[p] or {}
end

function Director.GetClassObjectYields(instance, instance2)
	if instance2 == nil then
		error(`[Director] Class cannot be nil (instance = {instance:GetFullName()})`)
	end

	local classes = Director.GetClassesFromItem(instance)

	if classes[instance2] then
		return classes[instance2]
	end

	local thread = task.delay(3, function()
		warn(`[Director] Possible timeout waiting for class {instance2.ClassName} (instance = {instance:GetFullName()})`)
	end)
	local v4

	repeat
		local v5, v6
		v5, v6, v4 = Director.ClassObjectInstantiated:Wait()
	until instance == v6 and v5 == instance2

	task.cancel(thread)
	return v4
end

function Director.Tag(instance, tag: string)
	CollectionService:AddTag(instance, tag)
end

function Director.ReloadClass(instance)
	warn("Director " .. v .. " // Reloading", instance.Name)
	local module = require(instance)

	for _, v4 in Director.GetItemsFromClass(Director.Classes[module.ClassName]) do
		v4:Destroy()
	end

	Director.ClassesWithItems[module] = nil
	Director.Classes[module.ClassName] = nil
	Director.Registered[module.ClassName] = nil
	v2[module.ClassName]:Disconnect()
	v2[module.ClassName] = nil
	v3[module.ClassName]:Disconnect()
	v3[module.ClassName] = nil

	for k, list in Director.ItemsWithClasses do
		for k2, v4 in list do
			if v4 ~= module then
				continue
			end

			table.remove(list, k2)
			break
		end

		if #list <= 0 then
			Director.RegisteredObjects[k] = nil
		end
	end

	local tagged = CollectionService:GetTagged("Reloaded" .. module.ClassName)

	if #tagged > 0 then
		for _, v4 in tagged do
			v4:Destroy()
		end
	end

	local clone = instance:Clone()
	CollectionService:AddTag(clone, "Reloaded" .. module.ClassName)
	clone.Parent = instance.Parent
	require(clone)
end

return Director