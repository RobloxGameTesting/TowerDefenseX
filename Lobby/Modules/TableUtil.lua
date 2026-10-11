local HttpService = game:GetService("HttpService")
local random = Random.new()

local function Copy(list, flag: boolean?) -- 10 equivalent calls inferred from this helper
	if flag then
		local function DeepCopy(list2)
			local result = table.create(#list2)

			for k, v in pairs(list2) do
				if type(v) == "table" then
					result[k] = DeepCopy(v)
				else
					result[k] = v
				end
			end

			return result
		end

		return (DeepCopy(list))
	end

	if #list > 0 then
		return table.move(list, 1, #list, 1, table.create(#list))
	end

	return (table.clone(list))
end

local function Sync(list, item)
	assert(type(list) == "table", "First argument must be a table")
	assert(type(item) == "table", "Second argument must be a table")
	local result = Copy(list, false) -- inferred equivalent call

	for k, v in pairs(result) do
		local item2 = item[k]

		if item2 == nil then
			result[k] = nil
		elseif type(v) == type(item2) then
			if type(v) == "table" then
				result[k] = Sync(v, item2)
			end
		elseif type(item2) == "table" then
			result[k] = Copy(item2, true) -- inferred equivalent call
		else
			result[k] = item2
		end
	end

	for k, item2 in pairs(item) do
		if result[k] ~= nil then
			continue
		end

		if type(item2) == "table" then
			result[k] = Copy(item2, true) -- inferred equivalent call
		else
			result[k] = item2
		end
	end

	return result
end

local function Reconcile(list, item)
	assert(type(list) == "table", "First argument must be a table")
	assert(type(item) == "table", "Second argument must be a table")
	local result = Copy(list, false) -- inferred equivalent call

	for k, item2 in pairs(item) do
		local v = list[k]

		if v == nil then
			if type(item2) == "table" then
				result[k] = Copy(item2, true) -- inferred equivalent call
			else
				result[k] = item2
			end
		elseif type(v) == "table" then
			if type(item2) == "table" then
				result[k] = Reconcile(v, item2)
			else
				result[k] = Copy(v, true) -- inferred equivalent call
			end
		end
	end

	return result
end

local function SwapRemove(list, index: number) -- 1 equivalent call inferred from this helper
	local count = #list
	local v = list[index]
	list[index] = list[count]
	list[count] = nil
	return v
end

local function Map(list, callback)
	assert(type(list) == "table", "First argument must be a table")
	assert(type(callback) == "function", "Second argument must be a function")
	local result = table.create(#list)

	for k, v in pairs(list) do
		result[k] = callback(v, k, list)
	end

	return result
end

local TableUtil = {}
TableUtil.Copy = Copy
TableUtil.Sync = Sync
TableUtil.Reconcile = Reconcile
TableUtil.SwapRemove = SwapRemove

function TableUtil.SwapRemoveFirstValue(list, p)
	local index = table.find(list, p)

	if index then
		SwapRemove(list, index) -- inferred equivalent call
	end

	return index
end

TableUtil.Map = Map

function TableUtil.Filter(list, callback)
	assert(type(list) == "table", "First argument must be a table")
	assert(type(callback) == "function", "Second argument must be a function")
	local result = table.create(#list)

	if #list > 0 then
		local count = 0

		for i, v in ipairs(list) do
			if not callback(v, i, list) then
				continue
			end

			count += 1
			result[count] = v
		end

		return result
	else
		for k, v in pairs(list) do
			if callback(v, k, list) then
				result[k] = v
			end
		end

		return result
	end
end

function TableUtil.Reduce(list, callback, p)
	assert(type(list) == "table", "First argument must be a table")
	assert(type(callback) == "function", "Second argument must be a function")

	if #list > 0 then
		local v

		if p == nil then
			p = list[1]
			v = 2
		else
			v = 1
		end

		for i = v, #list do
			p = callback(p, list[i], i, list)
		end

		return p
	else
		local v

		if p == nil then
			v = next(list)
			p = v
		end

		for k, v2 in next, list, v do
			p = callback(p, v2, k, list)
		end

		return p
	end
end

function TableUtil.Assign(list, ...)
	local result = Copy(list, false) -- inferred equivalent call

	for _, v in ipairs({ ... }) do
		for k, v2 in pairs(v) do
			result[k] = v2
		end
	end

	return result
end

function TableUtil.Extend(list, list2)
	local result = Copy(list, false) -- inferred equivalent call

	for _, v in ipairs(list2) do
		table.insert(result, v)
	end

	return result
end

function TableUtil.Reverse(list)
	local count = #list
	local result = table.create(count)

	for i = 1, count do
		result[i] = list[count - i + 1]
	end

	return result
end

function TableUtil.Shuffle(list, object)
	assert(type(list) == "table", "First argument must be a table")
	local result = Copy(list, false) -- inferred equivalent call

	if typeof(object) ~= "Random" then
		object = random
	end

	for i = #list, 2, -1 do
		local integer = object:NextInteger(1, i)
		local v = result[integer]
		local v2 = result[i]
		result[i] = v
		result[integer] = v2
	end

	return result
end

function TableUtil.Sample(list, value: number, object)
	assert(type(list) == "table", "First argument must be a table")
	assert(type(value) == "number", "Second argument must be a number")
	local copy = Copy(list, false) -- inferred equivalent call
	local v = table.create(value)

	if typeof(object) ~= "Random" then
		object = random
	end

	local count = #list
	local v2 = math.clamp(value, 1, count)

	for i = 1, v2 do
		local integer = object:NextInteger(i, count)
		local v3 = copy[integer]
		local v4 = copy[i]
		copy[i] = v3
		copy[integer] = v4
	end

	table.move(copy, 1, v2, 1, v)
	return v
end

function TableUtil.Flat(list, value: number?)
	local v = type(value) ~= "number" and 1 or value
	local result = table.create(#list)
	local function Scan(list2, p: number)
		for _, v2 in ipairs(list2) do
			if type(v2) == "table" and p < v then
				Scan(v2, p + 1)
			else
				table.insert(result, v2)
			end
		end
	end

	Scan(list, 0)
	return result
end

function TableUtil.FlatMap(p, callback)
	local map = Map(p, callback)
	local result = table.create(#map)
	local v = 1
	local function Scan(list, p2: number)
		for _, v2 in ipairs(list) do
			if type(v2) == "table" and p2 < v then
				Scan(v2, p2 + 1)
			else
				table.insert(result, v2)
			end
		end
	end

	Scan(map, 0)
	return result
end

function TableUtil.Keys(list)
	local result = table.create(#list)

	for k in pairs(list) do
		table.insert(result, k)
	end

	return result
end

function TableUtil.Find(items, callback)
	for k, item in pairs(items) do
		if callback(item, k, items) then
			return item, k
		end
	end

	return nil, nil
end

function TableUtil.Every(items, callback)
	for k, item in pairs(items) do
		if not callback(item, k, items) then
			return false
		end
	end

	return true
end

function TableUtil.Some(items, callback)
	for k, item in pairs(items) do
		if callback(item, k, items) then
			return true
		end
	end

	return false
end

function TableUtil.Truncate(p, p2: number)
	return table.move(p, 1, p2, 1, table.create(p2))
end

function TableUtil.Zip(...)
	assert(select("#", ...) > 0, "Must supply at least 1 table")

	local function ZipIteratorArray(list, p: number)
		local v = p + 1
		local result = {}

		for i, v2 in ipairs(list) do
			local v3 = v2[v]

			if v3 == nil then
				return nil, nil
			else
				result[i] = v3
			end
		end

		return v, result
	end

	local function ZipIteratorMap(list, p)
		local result = {}

		for i, v in ipairs(list) do
			local v2 = next(v, p)

			if v2 == nil then
				return nil, nil
			else
				result[i] = v2
			end
		end

		return p, result
	end

	local v = { ... }

	if #v[1] > 0 then
		return ZipIteratorArray, v, 0
	end

	return ZipIteratorMap, v, nil
end

function TableUtil.Lock(p)
	local function Freeze(list)
		for k, v in pairs(list) do
			if type(v) == "table" then
				list[k] = Freeze(v)
			end
		end

		return table.freeze(list)
	end

	return Freeze(p)
end

function TableUtil.IsEmpty(items)
	return next(items) == nil
end

function TableUtil.New3DArray(p: number, p2: number, p3: number, p4)
	local result = table.create(p)

	for i = 1, p do
		local v = table.create(p2)

		for j = 1, p2 do
			v[j] = table.create(p3, p4)
		end

		result[i] = v
	end

	return result
end

function TableUtil.EncodeJSON(p)
	return HttpService:JSONEncode(p)
end

function TableUtil.DecodeJSON(json: string)
	return HttpService:JSONDecode(json)
end

function TableUtil:ArrayRemove(callback)
	local v = 1

	for i = 1, #self do
		if callback(self, i, v) then
			if i ~= v then
				self[v] = self[i]
				self[i] = nil
			end

			v += 1
		else
			self[i] = nil
		end
	end

	return self
end

return TableUtil