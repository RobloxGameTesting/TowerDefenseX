local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
require(common:WaitForChild("Enums"))
local v = { ModelName = "Gun1", NoRotate = true, ForceAutoWeld = true }
local v2 = { ModelName = "Gun2", NoRotate = true, ForceAutoWeld = true }
local v3 = { ModelName = "Gun3", NoRotate = true, ForceAutoWeld = true }
local v4 = { ModelName = "Gun4", NoRotate = true, ForceAutoWeld = true }
local v5 = { ModelName = "Gun5", NoRotate = true, ForceAutoWeld = true }
local v6 = {
	ModelName = "Turret1",
	AutoWeldToInstanceName = "Base",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	UseBurstIndexForGun = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v, v2 }
}
local v7 = {
	ModelName = "Turret1",
	AutoWeldToInstanceName = "Base",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	UseBurstIndexForGun = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v, v2, v3 }
}
local v8 = {
	ModelName = "Turret2",
	AutoWeldToInstanceName = "Base",
	RotationOffset = CFrame.Angles(0, 1.5707963267948966, 0),
	UseBurstIndexForGun = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v }
}
local v9 = {
	ModelName = "Turret2",
	AutoWeldToInstanceName = "Base",
	RotationOffset = CFrame.Angles(0, 1.5707963267948966, 0),
	UseBurstIndexForGun = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v, v2, v3 }
}
local v10 = {
	ModelName = "Gun1",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotationConstraintConfig = { CanRotateZ = true }
}
local v11 = {
	ModelName = "AATurretLeft1",
	AutoWeldToInstanceName = "Base",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v10 }
}
local v12 = {
	ModelName = "AATurretRight1",
	AutoWeldToInstanceName = "Base",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v10 }
}
local v13 = {
	ModelName = "MissileTurret",
	AutoWeldToInstanceName = "Base",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotationConstraintConfig = { CanRotateY = true, MaxRotationY = 100, MinRotationY = -100 },
	TurretGunConfigs = {
		{ ModelName = "Gun1", NoRotate = true, ForceAutoWeld = true }
	}
}
local v14 = {
	ModelName = "Gun1",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	NoRotate = true,
	ForceAutoWeld = true
}
local v15 = {
	ModelName = "MinigunTurretLeft1",
	AutoWeldToInstanceName = "Base",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v14 }
}
local v16 = {
	ModelName = "MinigunTurretRight1",
	AutoWeldToInstanceName = "Base",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v14 }
}
local v17 = {
	ModelName = "Turret1",
	AutoWeldToInstanceName = "Base",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	UseBurstIndexForGun = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v, v2, v3, v4, v5 }
}
local v18 = {
	ModelName = "Turret2",
	AutoWeldToInstanceName = "Base",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	UseBurstIndexForGun = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v, v2, v3, v4, v5 }
}
local v19 = {
	ModelName = "Turret3",
	AutoWeldToInstanceName = "Base",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	UseBurstIndexForGun = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v, v2, v3, v4, v5 }
}
local v20 = {
	ModelName = "Turret5",
	AutoWeldToInstanceName = "Base",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	UseBurstIndexForGun = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v, v2, v3, v4, v5 }
}
local v21 = {
	ModelName = "Turret4",
	AutoWeldToInstanceName = "Base",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	UseBurstIndexForGun = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v, v2, v3, v4, v5 }
}
local v22 = {
	ModelName = "Gun1",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	NoRotate = true,
	ForceAutoWeld = true
}
local v23 = {
	ModelName = "Mortar1",
	AutoWeldToInstanceName = "Base",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v22 }
}
local clone = table.clone(v23)
local clone2 = table.clone(v23)
local clone3 = table.clone(v23)
local clone4 = table.clone(v23)
clone.ModelName = "Mortar2"
clone2.ModelName = "Mortar3"
clone3.ModelName = "Mortar4"
clone4.ModelName = "Mortar5"
local v24 = {
	ModelName = "Mortar6",
	AutoWeldToInstanceName = "Base",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v22 }
}
local clone5 = table.clone(v24)
local clone6 = table.clone(v24)
local clone7 = table.clone(v24)
local clone8 = table.clone(v24)
clone5.ModelName = "Mortar7"
clone6.ModelName = "Mortar8"
clone7.ModelName = "Mortar9"
clone8.ModelName = "Mortar10"
local v25 = {
	ModelName = "Gun1",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotationConstraintConfig = { CanRotateZ = true, MinRotationZ = -15 }
}
local v26 = {
	ModelName = "MinigunTurretLeft1",
	AutoWeldToInstanceName = "Base",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v25 }
}
local clone9 = table.clone(v26)
local clone10 = table.clone(v26)
local clone11 = table.clone(v26)
local clone12 = table.clone(v26)
local clone13 = table.clone(v26)
clone9.ModelName = "MinigunTurretLeft2"
clone10.ModelName = "MinigunTurretLeft3"
clone11.ModelName = "MinigunTurretLeft4"
clone12.ModelName = "MinigunTurretLeft5"
clone13.ModelName = "MinigunTurretLeft6"
local v27 = {
	ModelName = "MinigunTurretRight1",
	AutoWeldToInstanceName = "Base",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v25 }
}
local clone14 = table.clone(v27)
local clone15 = table.clone(v27)
local clone16 = table.clone(v27)
local clone17 = table.clone(v27)
local clone18 = table.clone(v27)
clone14.ModelName = "MinigunTurretRight2"
clone15.ModelName = "MinigunTurretRight3"
clone16.ModelName = "MinigunTurretRight4"
clone17.ModelName = "MinigunTurretRight5"
clone18.ModelName = "MinigunTurretRight6"
local v28 = {
	ModelName = "Turret1",
	AutoWeldToInstanceName = "Base",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	UseBurstIndexForGun = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v }
}
return {
	L0 = { v6, v8 },
	L1 = { v7, v9 },
	L2 = { v7, v9, v11, v12 },
	P1L3 = { v7, v9, v11, v12, v13 },
	P1L4 = { v7, v9, v11, v12, v13, v15, v16 },
	P1L5 = {
		v17,
		v18,
		v19,
		v20,
		v21,
		v23,
		clone,
		clone2,
		clone3,
		clone4,
		v24,
		clone5,
		clone6,
		clone7,
		clone8,
		v26,
		clone9,
		clone10,
		clone11,
		clone12,
		clone13,
		v27,
		clone14,
		clone15,
		clone16,
		clone17,
		clone18
	},
	P2L3 = { v28 },
	P2L4 = { v28 },
	P2L5 = { v28 }
}