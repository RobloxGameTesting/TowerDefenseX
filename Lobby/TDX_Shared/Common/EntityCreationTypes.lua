local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("DamageTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("WaveTypes"))
require(common:WaitForChild("TowerBuffUtilities"))
return nil