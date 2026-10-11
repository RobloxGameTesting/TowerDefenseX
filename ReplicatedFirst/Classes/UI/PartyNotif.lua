local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Network = require(ReplicatedFirst.Client.Network)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Director = require(ReplicatedStorage.TDX_Shared.Modules.Director)
local LobbyTypeUtilities = require(ReplicatedStorage.TDX_Shared.Common.LobbyTypeUtilities)
local PartyNotif = { ClassName = script.Name, ClassModule = script }
PartyNotif.__index = PartyNotif

function PartyNotif.new(root)
	return (setmetatable({
		Root = root,
		Cleaner = Cleaner.new(),
		CurrInviter = nil,
		CurrPartyId = nil,
		Queue = {},
		Processing = false,
		ProcessId = math.random(1, 2147483647),
		CurrGradientTween = nil
	}, PartyNotif))
end

function PartyNotif:Process()
	self.ProcessId = math.random(1, 2147483647)

	if self.CurrGradientTween then
		self.CurrGradientTween:Cancel()
		self.CurrGradientTween:Destroy()
	end

	local processId = self.ProcessId
	local currInviter, currPartyId, text, text2 = unpack((table.remove(self.Queue, 1)))
	local lobbyTypeData = LobbyTypeUtilities.GetLobbyTypeData(text)
	self.CurrPartyId = currPartyId
	self.CurrInviter = currInviter
	self.Root.Visible = true
	self.Root.stack.invitedframe.partytype.Text = `{currInviter.Name} invited you to a party!`

	if lobbyTypeData then
		self.Root.stack.mapdiff.info.Text = `{lobbyTypeData.DisplayName}`
	else
		self.Root.stack.mapdiff.info.Text = text
	end

	self.Root.stack.memberframe.info.Text = text2
	self.Root.UIStroke.UIGradient.Offset = Vector2.new(-0.5, 0)
	local tween = TweenService:Create(self.Root.UIStroke.UIGradient, TweenInfo.new(10, Enum.EasingStyle.Linear), {
		Offset = Vector2.new(0.5, 0)
	})
	tween:Play()
	self.CurrGradientTween = tween
	task.wait(10)

	if not self.Root.Visible or self.ProcessId ~= processId then
		return
	end

	self.Root.Visible = false
	task.wait(0.5)

	if next(self.Queue) then
		self:Process()
	else
		self.Processing = false
	end
end

function PartyNotif:Init()
	self.Cleaner:Add(Network.HookEvent("PartyInvitePrompt", function(p, p2: string, p3: string, p4: string)
		local flag = false

		for _, v in Director.GetItemsFromClass(Director.Classes.PartyMinimised) do
			if not v.Root.Visible then
				continue
			end

			flag = true
			break
		end

		if not flag then
			for _, v in Director.GetItemsFromClass(Director.Classes.PartyWindow) do
				if not v.Root.Visible then
					continue
				end

				flag = true
				break
			end
		end

		if flag then
			return
		end

		table.insert(self.Queue, { p, p2, p3, p4 })

		if self.Processing == false then
			self.Processing = true
			self:Process()
		end
	end))
	self.Cleaner:Add(self.Root.Close.MouseButton1Click:Connect(function()
		Network.Fire("ClientDeclineInviteRequest", self.CurrInviter, self.CurrPartyId)
		self.Root.Visible = false
		self.Processing = false
		task.wait(0.5)

		if next(self.Queue) then
			self:Process()
		end
	end))
	self.Cleaner:Add(self.Root.join.MouseButton1Click:Connect(function()
		Network.Fire("ClientAcceptInviteRequest", self.CurrInviter, self.CurrPartyId)
		self.Root.Visible = false
		self.Processing = false

		for _, v in Director.GetItemsFromClass(Director.Classes.PartyWindow) do
			v:Maximise()
		end
	end))
end

function PartyNotif:Destroy()
	self.Cleaner:Clean()
end

Director.Register(script.Name, { PartyNotif }, Players)
return PartyNotif