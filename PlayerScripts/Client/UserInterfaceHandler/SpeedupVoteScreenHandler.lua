local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
require(common:WaitForChild("Utilities"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local color = Color3.fromRGB(255, 122, 0)
local color2 = Color3.fromRGB(34, 215, 255)
local color3 = Color3.fromRGB(180, 255, 0)
local event = NetworkingHandler.GetEvent("SpeedControlVoteStateUpdate")
local event2 = NetworkingHandler.GetEvent("SpeedupVoteCast")
local speedupVoteScreen = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("TopAreaQueueFrame"):WaitForChild("SpeedupVoteScreen")
local innerFrame = speedupVoteScreen:WaitForChild("InnerFrame")
local speedText = innerFrame:WaitForChild("SpeedText")
local line1 = innerFrame:WaitForChild("Line1")
local line2 = innerFrame:WaitForChild("Line2")
local background = innerFrame:WaitForChild("Background")
local declineButton = innerFrame:WaitForChild("DeclineButton")
local acceptButton = innerFrame:WaitForChild("AcceptButton")
local votesText = acceptButton:WaitForChild("VotesText")
local returnImage = innerFrame:WaitForChild("ReturnImage")
local slowImage = innerFrame:WaitForChild("SlowImage")
local v = nil

local function StateUpdate(data)
	local forSpeedup = data.ForSpeedup

	if data.EnableSpeedup then
		if forSpeedup then
			line1.Text = "INCREASE TO"
			line2.Text = "1.5X SPEED"
			speedText.TextColor3 = color
			background.ImageColor3 = color
			returnImage.Visible = false
			slowImage.Visible = false
		else
			line1.Text = "SLOW TO"
			line2.Text = "0.5X SPEED"
			speedText.TextColor3 = color2
			background.ImageColor3 = color2
			returnImage.Visible = false
			slowImage.Visible = true
		end
	else
		line1.Text = "RETURN TO"
		line2.Text = "1X SPEED"
		speedText.TextColor3 = color3
		background.ImageColor3 = color3
		returnImage.Visible = true
		slowImage.Visible = false
	end

	votesText.Text = `{data.YesVotes}/{math.ceil(data.VoterCount / 2)}`

	if data.VotingEnabled then
		speedupVoteScreen.Visible = true
		return
	end

	speedupVoteScreen.Visible = false

	if v then
		v:Deselect()
	end
end

local function NewButton(instance, accept: boolean)
	local v2 = {
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
			if v then
				v:Deselect()
			end

			self.IsSelected = true
			v = self
			self:_UpdateState()
		end,
		Deselect = function(self)
			self.IsSelected = false
			v = nil
			self:_UpdateState()
		end,
		Clicked = function(self)
			self:Select()
			SoundHandler.Play("ClickTower")
			event2:FireServer(self.Accept)
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
		v2:Hovered()
	end)
	instance.MouseLeave:Connect(function()
		v2:Unhovered()
	end)
	instance.Activated:Connect(function()
		v2:Clicked()
	end)
	v2:_UpdateState()
	return v2
end

NewButton(declineButton, false)
NewButton(acceptButton, true)
event:AttachCallback(StateUpdate)
return {}