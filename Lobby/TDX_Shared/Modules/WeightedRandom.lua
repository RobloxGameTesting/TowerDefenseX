local RunService = game:GetService("RunService")
local WeightedRandom = {}
WeightedRandom.__index = WeightedRandom

function WeightedRandom.from(items)
	local self = setmetatable(
		{
			_entries = {},
			_values = table.clone(items),
			_totalWeight = 0,
			_random = Random.new(tick())
		},
		WeightedRandom
	)

	for k, item in items do
		if item == 0 then
			continue
		end

		local v = math.floor(item) == item and item > 0
		assert(v, "Weights must be non-negative integers")
		self._totalWeight += item
		table.insert(self._entries, {
			Value = k,
			Weight = item,
			CumulativeWeight = self._totalWeight
		})
	end

	if RunService:IsStudio() then
		self:Simulate(5000)
	end

	table.freeze(self._entries)
	return self
end

function WeightedRandom:GetRandomValue(p)
	local integer = (p or self._random):NextInteger(1, self._totalWeight)

	for _, entry in self._entries do
		if entry.CumulativeWeight - entry.Weight < integer and integer <= entry.CumulativeWeight then
			return entry.Value
		end
	end

	error("Could not find value for random weight " .. integer, 2)
end

function WeightedRandom:Simulate(p: number)
	assert(p > 0, "Number of iterations must be greater than 0")
	local v = {}

	for _ = 1, p do
		local randomValue = self:GetRandomValue()

		if v[randomValue] == nil then
			v[randomValue] = 0
		end

		v[randomValue] += 1
	end

	for _, _ in pairs(v) do

	end
end

return WeightedRandom