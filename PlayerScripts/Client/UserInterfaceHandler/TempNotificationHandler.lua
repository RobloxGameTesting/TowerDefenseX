local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
require(common:WaitForChild("NetworkingHandler"))
local slimeEventNotification = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("TopAreaQueueFrame"):WaitForChild("SlimeEventNotification")
slimeEventNotification:WaitForChild("InnerFrame"):WaitForChild("Line1")
slimeEventNotification.Visible = false
return {}