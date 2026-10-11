local Queue = {}
Queue.__index = Queue

function Queue.new()
	return (setmetatable({ _first = 0, _last = -1 }, Queue))
end

function Queue:add(p)
	assert(p ~= nil, "Cannot add nil values to queue")
	self._last += 1
	self[self._last] = p
end

function Queue:remove()
	if self:size() == 0 then
		return nil
	end

	local v = self[self._first]
	self[self._first] = nil
	self._first += 1

	if self:size() == 0 then
		self._first = 0
		self._last = -1
	end

	return v
end

function Queue:size()
	if self._last == -1 then
		return 0
	end

	return self._last - self._first + 1
end

return Queue