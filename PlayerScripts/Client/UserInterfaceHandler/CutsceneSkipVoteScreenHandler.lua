local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local event = NetworkingHandler.GetEvent("CutsceneVoteCast")
local event2 = NetworkingHandler.GetEvent("CutsceneVoteStateUpdate")
local skipScreen = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("CutsceneScreen"):WaitForChild("TopAreaQueueFrame"):WaitForChild("SkipScreen")
local innerFrame = skipScreen:WaitForChild("InnerFrame")
local votesText = innerFrame:WaitForChild("VotesText")
local declineButton = innerFrame:WaitForChild("DeclineButton")
local acceptButton = innerFrame:WaitForChild("AcceptButton")
local v = nil
local v2 = nil

local function StateUpdate(data)
	if data.VotingEnabled then
		votesText.Text = `{data.YesVotes}/{math.ceil(data.VoterCount / 2)}`

		if v2 ~= v then
			skipScreen.Visible = true
		end
	else
		skipScreen.Visible = false

		if v2 then
			v2:Deselect()
			v2 = nil
		end
	end
end

local function NewButton(instance, accept: boolean)
	local v3 = {
		Accept = accept,
		IsHovered = false,
		IsSelected = false,
		TextLabel = instance:FindFirstChild("Text"),
		DefaultStateImage = instance:FindFirstChild("Default"),
		HighlightStateImage = instance:FindFirstChild("Hovered"),
		Hovered = function(self)
			self.IsHovered = true
			self:_UpdateState()
		end,
		Unhovered = function(self)
			self.IsHovered = false
			self:_UpdateState()
		end,
		Select = function(self)
			if v2 then
				v2:Deselect()
			end

			self.IsSelected = true
			v2 = self
			self:_UpdateState()
		end,
		Deselect = function(self)
			self.IsSelected = false
			v2 = nil
			self:_UpdateState()
		end,
		Clicked = function(self)
			self:Select()
			SoundHandler.Play("ClickTower")
			event:FireServer(self.Accept)
			skipScreen.Visible = false
		end,
		_UpdateState = function(self)
			local highlightStateImage = self.HighlightStateImage

			if self.IsHovered or self.IsSelected then
				highlightStateImage.ImageTransparency = 0
			else
				highlightStateImage.ImageTransparency = 1
			end
		end
	}
	instance.MouseEnter:Connect(function()
		v3:Hovered()
	end)
	instance.MouseLeave:Connect(function()
		v3:Unhovered()
	end)
	instance.Activated:Connect(function()
		v3:Clicked()
	end)
	v3:_UpdateState()
	return v3
end

v = NewButton(declineButton, false)
NewButton(acceptButton, true)
event2:AttachCallback(StateUpdate)
return {}