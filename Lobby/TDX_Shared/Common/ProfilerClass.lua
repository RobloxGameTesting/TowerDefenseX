local ProfilerClass = {}
ProfilerClass.__index = ProfilerClass

function ProfilerClass.New(name: string, callsBeforePrint: number)
	return (setmetatable({
		Name = name,
		CallsBeforePrint = callsBeforePrint,
		Sum = 0,
		Count = 0,
		IntervalMax = 0
	}, ProfilerClass))
end

function ProfilerClass:Log(intervalMax: number)
	self.Count += 1
	self.Sum += intervalMax

	if self.IntervalMax < intervalMax then
		self.IntervalMax = intervalMax
	end

	if self.Count >= self.CallsBeforePrint then
		local v = math.round(self.Sum / self.Count * 10000000) / 10000
		local v2 = math.round(self.IntervalMax * 10000000) / 10000
		print(self.Name, "   Avg:", tostring(v), "ms   ", "Max:", tostring(v2), "ms")
		self.Sum = 0
		self.Count = 0
		self.IntervalMax = 0
	end
end

return ProfilerClass