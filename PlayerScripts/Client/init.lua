local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("Types"))
require(Common:WaitForChild("GlobalConstants"))
local NameTagHandlerClient = require(TDX_Shared:WaitForChild("Client"):WaitForChild("NameTagHandlerClient"))
local EmoteSoundHandler = require(TDX_Shared:WaitForChild("Client"):WaitForChild("EmoteSoundHandler"))
require(script:WaitForChild("InitializeUIState"))
require(script:WaitForChild("CreateBindables"))
require(script:WaitForChild("InitiateDirector"))
require(script:WaitForChild("ConfigDashboardClient"))
require(Common:WaitForChild("ChatHandlerClientside"))
NameTagHandlerClient:Init()
EmoteSoundHandler:Init()
local GameAnalytics = require(TDX_Shared:WaitForChild("GameAnalytics"))
local NetworkingHandler = require(Common:WaitForChild("NetworkingHandler"))
local UserInterfaceHandler = require(script:WaitForChild("UserInterfaceHandler"))
local GameClass = require(script:WaitForChild("GameClass"))
local UserInputHandler = require(script:WaitForChild("UserInputHandler"))
local RankRoles = require(TDX_Shared:WaitForChild("Common"):WaitForChild("RankRoles"))
local event = NetworkingHandler.GetEvent("SendGameInitData")
local event2 = NetworkingHandler.GetEvent("ResetTest")
local event3 = NetworkingHandler.GetEvent("PlayerLoaded")
event:AttachCallback(function(p)
	GameClass.New(p)
	UserInterfaceHandler.Initialize()
end)
event2:AttachCallback(function()
	GameClass.Reset()
end)
RunService.Heartbeat:Connect(function(dt)
	local currentGame = GameClass.GetCurrentGame()

	if currentGame then
		currentGame:Tick(dt)
		UserInterfaceHandler.Update(dt, currentGame:GetState(), currentGame:GetSpeedMultiplier())
	end
end)
RunService.RenderStepped:Connect(function(dt)
	local currentGame = GameClass.GetCurrentGame()

	if currentGame then
		debug.profilebegin("UserInput")
		UserInputHandler.Update(dt, currentGame:GetSpeedMultiplier(), currentGame:GetFinalSpeedMultiplier())
		debug.profileend()
	end
end)
event3:FireServer()

local function InitializeCmdr()
	local rankInGroup = Players.LocalPlayer:GetAttribute("RankInGroup")

	if RunService:IsStudio() or rankInGroup and RankRoles.SuperBreadTester.GroupRank <= rankInGroup then
		local CmdrClient = require(ReplicatedStorage:WaitForChild("CmdrClient", 10))

		if CmdrClient == nil then
			warn("Failed to initialize Cmdr")
		else
			CmdrClient:SetActivationKeys({ Enum.KeyCode.F2 })
			CmdrClient.Registry:RegisterHook("BeforeRun", function(_)
				if RunService:IsStudio() then
					return nil
				end

				if rankInGroup < RankRoles.SuperBreadTester.GroupRank then
					return "Permission denied"
				end

				return nil
			end)
		end
	end
end

InitializeCmdr()
Players.LocalPlayer:GetAttributeChangedSignal("RankInGroup"):Connect(InitializeCmdr)
print("Version", _G.BUILD_VERSION)
GameAnalytics:initClient()