require(script.Parent.Parent:WaitForChild("CommandTypes"))
return {
	Name = "Set Movement Speed",
	ValidEntityClasses = { "Enemy" },
	AdjustableNumberRange = NumberRange.new(0, 50),
	AdjustableNumberRangeCustomIncrement = 0.25,
	AdjustableDefaultValue = 3
}