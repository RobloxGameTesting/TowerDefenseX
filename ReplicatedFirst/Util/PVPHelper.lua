local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Data = require(ReplicatedStorage.TDX_Shared.Client.Services.Data)
local Director = require(ReplicatedStorage.TDX_Shared.Modules.Director)
local Lang = require(ReplicatedStorage.TDX_Shared.Modules.Lang)
local PVPAbandonment = require(ReplicatedStorage.TDX_Shared.Common.PVPAbandonment)
local ResourceManager = require(ReplicatedStorage.TDX_Shared.Common.ResourceManager)
local Utilities = require(ReplicatedStorage.TDX_Shared.Common.Utilities)
local PVPHelper = {
	GetRemainingAbandonCooldown = function()
		local pvpAbandonTimes = Data.Get("PVPAbandonTimes")
		return PVPAbandonment.GetRemainingQueueCooldown(pvpAbandonTimes)
	end,
	ShowAbandonCooldownWarning = function(p: number, callback)
		Director.GetFirstItemFromClass(Director.Classes.PopupWindows):DoPopup(
			"TextConfirmation",
			callback or function() end,
			{
				TextConfirmationOptions = {
					Title = "Queue Cooldown",
					Subtitle = "PVP Matchmaking Restricted",
					Description = `You are banned from PVP matchmaking due to leaving previous matches. Cooldown remaining: {Utilities.ConvertToTimeStringFull(p, "%02dh%02dm%02ds")}`,
					PrimaryButtonText = "OK",
					SecondaryButtonText = "",
					Color = Color3.fromRGB(255, 60, 60)
				}
			}
		)
	end,
	GetEquippedBannedPVPTowers = function()
		local result = {}
		local loadout = Data.Get("Loadout")

		if not loadout then
			return result
		end

		for _, v in loadout do
			if not (v ~= "" and v ~= nil and ResourceManager.HasTowerConfig(v)) then
				continue
			end

			local towerConfig = ResourceManager.GetTowerConfig(v)

			if not towerConfig or not towerConfig.BannedInPVP or table.find(result, v) then
				continue
			end

			table.insert(result, v)
		end

		return result
	end,
	ShowBannedPVPTowerWarning = function(p: string, callback)
		Director.GetFirstItemFromClass(Director.Classes.PopupWindows):DoPopup("TextConfirmation", callback, {
			TextConfirmationOptions = {
				Title = "Banned Tower",
				Subtitle = Lang.Get(Lang.Strings.AssetInfo.Towers[p].Name),
				Description = "This tower cannot be brought into PVP. It will be removed from your loadout for the match if you choose to start anyways",
				PrimaryButtonText = "Start Anyways",
				SecondaryButtonText = "Cancel",
				Color = Color3.fromRGB(255, 210, 0)
			}
		})
	end
}
table.freeze(PVPHelper)
return PVPHelper