require(script.Parent.Parent:WaitForChild("CommandTypes"))
return {
	Name = "Set Walk Animation Speed",
	ValidEntityClasses = { "Enemy" },
	AdjustableNumberRange = NumberRange.new(0, 50),
	AdjustableNumberRangeCustomIncrement = 0.1,
	AdjustableDefaultValue = 3,
	ClientCallback = function(player, _: string, p)
		local character = player.Character

		if not character then
			return
		end

		local primaryAnimationHandler = character.PrimaryAnimationHandler

		if not primaryAnimationHandler then
			return
		end

		local animation = primaryAnimationHandler:GetAnimation("Move")

		if not (animation and animation.IsMovement) then
			return
		end

		local config = character.Config

		if config and config.Speed and p and p > 0 then
			animation.MovementAnimationCalibrationMultiplier = config.Speed / p
			animation.Track:AdjustSpeed(animation:_GetFinalTrackSpeed())
		end
	end
}