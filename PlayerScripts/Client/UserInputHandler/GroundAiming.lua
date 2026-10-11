local GroundAiming = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Utilities"))
require(common:WaitForChild("PlacementHandler"))
require(common:WaitForChild("ResourceManager"))
local MapHandler = require(common:WaitForChild("MapHandler"))
require(common:WaitForChild("PathHandler"))
require(common:WaitForChild("PathUtilities"))
require(common:WaitForChild("ValidArcsUtilities"))
require(common:WaitForChild("TowerBuffUtilities"))
local AimingGuideHandler = require(script.Parent:WaitForChild("AimingGuideHandler"))
local v = nil
local v2 = nil

function GroundAiming.Run(p: number, vector: Vector3)
	MapHandler.HidePathHighlight()
	AimingGuideHandler.Show(p, vector, vector, true, v2)
	v = vector
end

function GroundAiming.BeginGroundAiming(p: number)
	v2 = p
end

function GroundAiming.GetCurrentAimPosition()
	return true, v
end

function GroundAiming.Hide()
	AimingGuideHandler.Hide()
end

return GroundAiming