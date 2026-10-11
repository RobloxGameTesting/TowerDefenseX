local ObjectPoolClass = {}
ObjectPoolClass.__index = ObjectPoolClass
local Lighting = game:GetService("Lighting")

function ObjectPoolClass.New(name: string, items, createFunction)
	local folder = Instance.new("Folder", Lighting)
	folder.Name = name
	local v = {
		PoolName = name,
		CreateFunction = createFunction,
		InactiveItemPool = {},
		InactiveItemStorageLocation = folder
	}

	for k in pairs(items) do
		v.InactiveItemPool[k] = {}
	end

	return (setmetatable(v, ObjectPoolClass))
end

function ObjectPoolClass:_GetPool(p: string)
	local v = self.InactiveItemPool[p]

	if not v then
		warn("Pool doesn't exist for " .. p .. " in pool " .. self.PoolName)
	end

	return v
end

function ObjectPoolClass:Get(p: string)
	local pool = self:_GetPool(p)

	if not pool then
		error("Pool doesn't exist for " .. p .. " in pool " .. self.PoolName)
		return
	end

	local count = #pool

	if count > 0 then
		return (table.remove(pool, count))
	end

	return self.CreateFunction(p)
end

function ObjectPoolClass:Recycle(p: string, instance)
	local instances = self:_GetPool(p)

	if not instances then
		warn("Pool doesn't exist for " .. p .. " in pool " .. self.PoolName)
	end

	if #instances >= 10 then
		instance:Destroy()
		return
	end

	instance.Parent = self.InactiveItemStorageLocation
	table.insert(instances, instance)
end

return ObjectPoolClass