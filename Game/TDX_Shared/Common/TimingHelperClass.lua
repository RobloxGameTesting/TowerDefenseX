local TimingHelperClass = {}
TimingHelperClass.__index = TimingHelperClass

function TimingHelperClass.New(p)
	return (setmetatable(
		{
			TimeUntilCallback = p.TimeUntilCallback,
			Callback = p.Callback,
			Started = false,
			CallbackTriggered = false
		},
		TimingHelperClass
	))
end

function TimingHelperClass:Run(p: number)
	if not self.Started then
		return
	end

	if not self.CallbackTriggered then
		self.TimeUntilCallback -= p

		if self.TimeUntilCallback <= 0 then
			self.Callback()
			self.CallbackTriggered = true
		end
	end
end

function TimingHelperClass:Start()
	self.Started = true
end

function TimingHelperClass:Destroy()
	for k in pairs(self) do
		self[k] = nil
	end
end

return TimingHelperClass