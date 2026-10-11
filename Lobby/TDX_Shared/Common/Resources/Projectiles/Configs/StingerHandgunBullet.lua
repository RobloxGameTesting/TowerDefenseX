local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
return { Name = "StingerHandgunBullet", NoPhysicalProjectile = true, Hitscan = true }