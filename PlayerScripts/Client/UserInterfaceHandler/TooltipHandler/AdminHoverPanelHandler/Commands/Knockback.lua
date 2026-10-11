require(script.Parent.Parent:WaitForChild("CommandTypes"))
return {
	Name = "Knockback",
	ValidEntityClasses = { "Enemy" },
	AdjustableNumberRange = NumberRange.new(0, 20),
	AdjustableDefaultValue = 13,
	AdjustableNumberRangeCustomIncrement = 1
}