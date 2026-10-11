return {
	new = function(value)
		return {
			StartTime = tick(),
			Duration = value or 0,
			Done = function(self)
				return self:GetTimeLeft() <= 0
			end,
			Restart = function(p, duration)
				p.StartTime = tick()
				p.Duration = duration
			end,
			GetTimeLeft = function(self)
				return self.Duration - (tick() - self.StartTime)
			end
		}
	end
}