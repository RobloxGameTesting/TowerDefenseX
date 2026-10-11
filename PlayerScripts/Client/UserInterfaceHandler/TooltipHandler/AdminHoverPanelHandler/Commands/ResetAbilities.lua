require(script.Parent.Parent:WaitForChild("CommandTypes"))
return {
	Name = "Reset Abilities",
	ValidEntityClasses = { "Tower", "PathEntity", "Enemy" },
	AbilityHandlerRequired = true,
	TriggerTowerResetAbilities = true
}