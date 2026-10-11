local QueueClass = {}

function QueueClass.New(capacity)
	return (setmetatable({
		List = table.create(capacity or 0),
		First = 0,
		Last = -1,
		Size = 0,
		Capacity = capacity
	}, QueueClass))
end

function QueueClass:PushStart(p)
	if self.Size >= self.Capacity then
		warn("Queue capacity exceeded")
		return
	end

	local first = self.First - 1
	self.First = first
	self.List[first] = p
	self.Size += 1
end

function QueueClass:PushEnd(p)
	if self.Size >= self.Capacity then
		warn("Queue capacity exceeded")
		return
	end

	local last = self.Last + 1
	self.Last = last
	self.List[last] = p
	self.Size += 1
end

function QueueClass:PopStart()
	local first = self.First

	if self.Last < first then
		error("List is empty")
	end

	local v = self.List[first]
	self.List[first] = nil
	self.First = first + 1
	self.Size -= 1
	return v
end

function QueueClass:PopEnd()
	local last = self.Last

	if last < self.First then
		error("List is empty")
	end

	local v = self.List[last]
	self.List[last] = nil
	self.Last = last - 1
	self.Size -= 1
	return v
end

function QueueClass:Clear()
	table.clear(self.List)
	self.First = 0
	self.Last = -1
	self.Size = 0
end

function QueueClass.Empty(p)
	return p.Size == 0
end

return QueueClass