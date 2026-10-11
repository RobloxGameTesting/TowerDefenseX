local HashGeneratorClass = {}
HashGeneratorClass.__index = HashGeneratorClass

function HashGeneratorClass.New()
	return (setmetatable({ CurrentHash = 0, InactiveHashes = {} }, HashGeneratorClass))
end

function HashGeneratorClass:Get()
	local inactiveHashes = self.InactiveHashes
	local count = #inactiveHashes

	if count > 0 then
		return table.remove(inactiveHashes, count) or error("InactiveHashes was empty")
	end

	self.CurrentHash += 1
	return self.CurrentHash
end

function HashGeneratorClass:GetSmallest()
	local inactiveHashes = self.InactiveHashes

	if not (#inactiveHashes > 0) then
		self.CurrentHash += 1
		return self.CurrentHash
	end

	local v = 1e999
	local v2 = 1

	for i, inactiveHash in ipairs(inactiveHashes) do
		if not (inactiveHash < v) then
			continue
		end

		v2 = i
		v = inactiveHash
	end

	return table.remove(inactiveHashes, v2) or error("InactiveHashes was empty")
end

function HashGeneratorClass.Return(p, p2: number)
	table.insert(p.InactiveHashes, p2)
end

return HashGeneratorClass