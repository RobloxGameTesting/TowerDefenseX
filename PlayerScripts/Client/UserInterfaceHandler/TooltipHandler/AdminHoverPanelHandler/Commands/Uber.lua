require(script.Parent.Parent:WaitForChild("CommandTypes"))
return {
	Name = "Uber",
	ValidEntityClasses = { "Tower" },
	AdjustableNumberRange = NumberRange.new(0, 60),
	AdjustableNumberAppendString = "s",
	AdjustableDefaultValue = 5
}