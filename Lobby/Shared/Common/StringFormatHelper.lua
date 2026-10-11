local StringFormatHelper = {
	ToHMS = function(p)
		return string.format("%02i:%02i:%02i", p / 3600, p / 60 % 60, p % 60)
	end,
	FormatTimeRemaining = function(p: number)
		local v = math.max(0, (math.floor(p)))
		local v2 = math.floor(v / 3600)
		local v3 = math.floor(v % 3600 / 60)
		local v4 = v % 60

		if v2 > 0 then
			return `{v2}h {v3}m {v4}s`
		end

		if v3 > 0 then
			return `{v3}m {v4}s`
		end

		return `{v4}s`
	end,
	FormatTimeSince = function(p: number)
		local v = math.floor(math.max(0, (math.floor(p))) / 60)
		local v2 = math.floor(v / 60)
		local v3 = math.floor(v2 / 24)
		local v4 = math.floor(v3 / 30)

		if v4 >= 2 then
			return `{v4} months`
		end

		if v4 == 1 then
			return "1 month"
		end

		if v3 >= 2 then
			return `{v3} days`
		end

		if v3 == 1 then
			return "1 day"
		end

		if v2 >= 2 then
			return `{v2}h`
		end

		if v2 == 1 then
			return "1h"
		end

		if v >= 1 then
			return `{v}m`
		end

		return "moments"
	end,
	FormatCurrency = function(p: number)
		local v = tostring((math.floor(p)))
		local count = #v

		if count <= 3 then
			return v
		end

		local v2 = ""

		for i = 1, count do
			v2 ..= string.sub(v, i, i)
			local v3 = count - i

			if v3 > 0 and v3 % 3 == 0 then
				v2 ..= ","
			end
		end

		return v2
	end
}

function StringFormatHelper.FormatCurrencyShort(p: number)
	local v = math.floor(p)

	if v >= 1000000000 then
		return StringFormatHelper.FormatCurrency((math.floor(v / 1000000000))) .. "B+"
	end

	if v >= 1000000 then
		return StringFormatHelper.FormatCurrency((math.floor(v / 1000000))) .. "M+"
	end

	if v >= 100000 then
		return StringFormatHelper.FormatCurrency((math.floor(v / 1000))) .. "K+"
	end

	return StringFormatHelper.FormatCurrency(v)
end

return StringFormatHelper