local NorthforgeCustomCodeClass = {}
NorthforgeCustomCodeClass.__index = NorthforgeCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(TDX_Shared:WaitForChild("Client"):WaitForChild("Services"):WaitForChild("Data"))
require(TDX_Shared:WaitForChild("Modules"):WaitForChild("DataTemplate"))
require(Common:WaitForChild("CustomCodeTypes"))
require(Common:WaitForChild("MapTypes"))
require(Common:WaitForChild("WrapperFactory"))
local NetworkingHandler = require(Common:WaitForChild("NetworkingHandler"))
local color = Color3.fromRGB(0, 0, 255)
local color2 = Color3.fromRGB(255, 0, 0)
local Hidden = Lighting:WaitForChild("Hidden")
local v = nil
local flagCaptureTime = 1
local v2 = {}
local raycastIgnore = nil
local enemyBaseShield = nil
local v3 = nil
local v4 = nil

function NorthforgeCustomCodeClass.New()
	return (setmetatable({}, NorthforgeCustomCodeClass))
end

function NorthforgeCustomCodeClass.OnLoaded(_, instance, p, _: number)
	flagCaptureTime = p and p.FlagCaptureTime or 3
	task.spawn(function()
		raycastIgnore = instance:WaitForChild("RaycastIgnore", 5)

		if not raycastIgnore then
			return
		end

		local function SetUpFlags()
			local flags = raycastIgnore:WaitForChild("Flags", 5)

			if not flags then
				return
			end

			for _, child in pairs(flags:GetChildren()) do
				local name = tonumber(child.Name)

				if name then
					local flag = child:FindFirstChild("Flag")
					local flag_BottomPosition = child:FindFirstChild("Flag_BottomPosition")

					if flag and flag_BottomPosition then
						v2[name] = {
							Captured = false,
							Capturing = false,
							CapturePercentage = 0,
							Model = child,
							FlagPart = flag,
							FlagStartPosition = flag.Position,
							FlagEndPosition = flag_BottomPosition.Position
						}
					else
						warn("Flag " .. child.Name .. " in Northforge Flags model is missing Flag or Flag_BottomPosition part")
					end
				else
					warn("Flag " .. child.Name .. " in Northforge Flags model is not a valid capture index number")
				end
			end
		end

		local function SetUpEnemyBaseShield() -- 1 equivalent call inferred from this helper
			enemyBaseShield = raycastIgnore:WaitForChild("EnemyBaseShield", 5)
		end

		SetUpFlags()
		SetUpEnemyBaseShield() -- inferred equivalent call
	end)

	if not v then
		v = NetworkingHandler.GetEvent("NorthforgeFlagStateChanged")
		v:AttachCallback(function(p2: number, captured: boolean, capturing: boolean, capturePercentage: number)
			local v5 = v2[p2]

			if not v5 then
				return
			end

			v5.Captured = captured
			v5.Capturing = capturing
			v5.CapturePercentage = capturePercentage
		end)
	end
end

function NorthforgeCustomCodeClass.ClientTick(_, p: number)
	local v5 = p / flagCaptureTime

	for _, v6 in pairs(v2) do
		if v6.Captured then
			v6.CapturePercentage = 1
		elseif v6.Capturing then
			v6.CapturePercentage = math.clamp(v6.CapturePercentage + v5, 0, 1)
		else
			v6.CapturePercentage = math.clamp(v6.CapturePercentage - v5, 0, 1)
		end

		local position

		if v6.CapturePercentage >= 0.5 then
			position = v6.FlagEndPosition:Lerp(v6.FlagStartPosition, (v6.CapturePercentage - 0.5) * 2)
			v6.FlagPart.Color = color2
		else
			position = v6.FlagStartPosition:Lerp(v6.FlagEndPosition, v6.CapturePercentage * 2)
			v6.FlagPart.Color = color
		end

		v6.FlagPart.Position = position
	end

	if enemyBaseShield then
		local northforgeEnemyBaseLives = workspace:GetAttribute("NorthforgeEnemyBaseLives")
		local northforgeEnemyBaseTotalLives = workspace:GetAttribute("NorthforgeEnemyBaseTotalLives")
		local v6

		if northforgeEnemyBaseLives == v3 then
			v6 = false
		else
			v3 = northforgeEnemyBaseLives
			v6 = true
		end

		if northforgeEnemyBaseTotalLives ~= v4 then
			v4 = northforgeEnemyBaseTotalLives
			v6 = true
		end

		if v6 and v3 and v4 then
			if v3 <= 1 then
				enemyBaseShield.Parent = Hidden
			else
				enemyBaseShield.Parent = raycastIgnore
			end
		end
	end
end

function NorthforgeCustomCodeClass.SpeedMultiplierChanged(_, _: number) end

return NorthforgeCustomCodeClass