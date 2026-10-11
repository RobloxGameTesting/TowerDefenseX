require(script.Parent.Parent:WaitForChild("CommandTypes"))
return {
	Name = "Convert",
	ValidEntityClasses = { "Tower", "PathEntity" },
	AdjustableNumberRange = NumberRange.new(0, 60),
	AdjustableNumberAppendString = "s",
	AdjustableDefaultValue = 5
}