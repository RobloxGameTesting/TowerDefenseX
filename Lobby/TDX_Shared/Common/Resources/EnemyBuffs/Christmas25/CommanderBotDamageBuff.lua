local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EnemyBuffUtilities"))
local Enums = require(common:WaitForChild("Enums"))
return { Type = Enums.EnemyBuffTypes.Damage, Percentage = 0.35, Time = 2.1, IsDebuff = false }