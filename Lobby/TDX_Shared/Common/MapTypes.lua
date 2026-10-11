local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(ReplicatedStorage.TDX_Shared.Modules.Lang)
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("TurretTypes"))
require(common:WaitForChild("EntityCreationTypes"))
return nil