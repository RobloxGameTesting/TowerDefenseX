local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Network = require(ReplicatedFirst.Client.Network)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local SoundHandler = require(game.ReplicatedStorage.TDX_Shared.Common:WaitForChild("SoundHandler"))
local now = tick()
local NotificationHandler = { ClassName = script.Name, ClassModule = script }
NotificationHandler.__index = NotificationHandler

function NotificationHandler.new(root)
	return (setmetatable({
		Root = root,
		Cleaner = Cleaner.new(),
		NoJoinTimer = 0,
		NotUnlockedTimer = 0,
		KickedFromPartyTimer = 0,
		ElevatorInPartyTimer = 0,
		FoundTranslatorTimer = 0,
		OpenedEvilDoorTimer = 0
	}, NotificationHandler))
end

function NotificationHandler:Init()
	self.Cleaner:Add(Network.HookEvent("DoPlayerNotification", function(p)
		if p == 0 then
			self.NoJoinTimer = tick() + 6
		elseif p == 1 then
			self.NotUnlockedTimer = tick() + 6
		elseif p == 2 then
			self.KickedFromPartyTimer = tick() + 6
		elseif p == 3 then
			self.ElevatorInPartyTimer = tick() + 6
		elseif p == 4 then
			self.FoundTranslatorTimer = tick() + 6
			SoundHandler.Play("TranslatorPickup1")
			SoundHandler.Play("TranslatorPickup2")
		elseif p == 5 then
			self.OpenedEvilDoorTimer = tick() + 4
		end
	end))
	self.Cleaner:Add(RunService.Heartbeat:Connect(function()
		local now2 = tick()

		if now2 - now > 1 / 30 then
			now = now2
			self.Root.CannotJoin.Visible = now2 < self.NoJoinTimer
			self.Root.ChoosingNight.Visible = now2 < self.NotUnlockedTimer
			self.Root.KickedFromParty.Visible = now2 < self.KickedFromPartyTimer
			self.Root.ElevatorInParty.Visible = now2 < self.ElevatorInPartyTimer
			self.Root.FoundTranslator.Visible = now2 < self.FoundTranslatorTimer
			self.Root.OpenedEvilDoor.Visible = now2 < self.OpenedEvilDoorTimer
		end
	end))
end

function NotificationHandler.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { NotificationHandler }, Players)
return NotificationHandler