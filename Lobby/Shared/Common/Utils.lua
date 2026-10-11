local TextService = game:GetService("TextService")
local Utils = {
	GetRandomWeightedItem = function(items, p, object)
		local number = object:NextNumber(0, 100)

		for k, _ in pairs(items) do
			if number <= p[k] then
				return k
			end
		end

		return nil
	end
}

function Utils.DeepCopy(items)
	local result = {}

	for k, item in items do
		if typeof(item) == "table" then
			result[k] = Utils.DeepCopy(item)
		else
			result[k] = item
		end
	end

	return result
end

function Utils:ResizeToFitText(p: number?)
	local getTextBoundsParams = Instance.new("GetTextBoundsParams")
	getTextBoundsParams.Text = self.Text
	getTextBoundsParams.Size = self.TextSize
	getTextBoundsParams.Font = self.FontFace
	getTextBoundsParams.Width = 1e999
	local textBoundsAsync = TextService:GetTextBoundsAsync(getTextBoundsParams)
	getTextBoundsParams:Destroy()
	local v = p or self.TextSize
	local v2 = (textBoundsAsync.X + v) / self.Parent.AbsoluteSize.X
	self.Size = UDim2.new(v2, 0, self.Size.Y.Scale, self.Size.Y.Offset)
end

return Utils