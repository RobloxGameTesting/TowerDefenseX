local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = false,
		SpawnAttachmentEntityType = Enums.AttachmentEntities.CombatMedicRevivePackEntity,
		CanTargetDeadTowers = true,
		SpawnAttachmentEntityDestroyOnRun = true
	},
	Name = "CombatMedicReviveLevel1",
	DisplayName = "Revive Pack I",
	Passive = true,
	StartingCooldown = 2.5,
	Cooldown = 20,
	Animated = true,
	AnimationName = "ThrowRevivePack",
	Delay = 0,
	ExecutionTime = 89 / 60,
	IsManualAimAtTower = true,
	ReviveTower = true,
	CustomQueryData = {
		CanTargetDeadTowers = true,
		ConsiderTargetsWithNoAttack = true,
		CustomFilter = function(object)
			return object:CanBeRevived()
		end
	},
	Icon = "",
	Description = "Revives your towers",
	ProjectileName = Enums.Projectiles.CombatMedicRevivePack
}