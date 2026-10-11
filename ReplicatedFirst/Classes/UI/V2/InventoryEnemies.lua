local Common = game.ReplicatedStorage.TDX_Shared:WaitForChild("Common")
local SoundHandler = require(Common.SoundHandler)
local ClientUtil = require(game.ReplicatedFirst.Util.ClientUtil)
local ShopDataV2 = require(game.ReplicatedStorage.Modules.ShopDataV2)
local EnemyViewport = require(Common.EnemyViewport)
local Data = require(game.ReplicatedStorage.TDX_Shared.Client.Services.Data)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local ResourceManager = require(game.ReplicatedStorage.TDX_Shared.Common.ResourceManager)
local InventoryEnemies = { ClassName = script.Name, ClassModule = script }
InventoryEnemies.__index = InventoryEnemies

function InventoryEnemies.new(root)
	return (setmetatable({ Root = root }, InventoryEnemies))
end

function InventoryEnemies:Init()
	self:Update()
	Data.Updated:Connect(function(p)
		if p == "EnemiesLoadout" then
			self:Update()
		end
	end)

	for i = 1, _G.PVP_ENEMY_LOADOUT_MAX_SIZE do
		local v = i
		self.Root.Grid:FindFirstChild((tostring(i))).Trash.Activated:Connect(function()
			if ClientUtil.UnequipItem("Enemies", Data.Get("EnemiesLoadout")[v]) then
				SoundHandler.Play("Unequip")
			end
		end)
	end
end

function InventoryEnemies:Update()
	local enemiesLoadout = Data.Get("EnemiesLoadout")

	for i, v in ipairs(enemiesLoadout) do
		local child = self.Root.Grid:FindFirstChild((tostring(i)))

		if v ~= child:GetAttribute("LastEnemy") then
			local viewportFrame = child.MainFrame:FindFirstChildOfClass("ViewportFrame")

			if viewportFrame then
				viewportFrame:Destroy()
			end

			local waveUnlock = child.MainFrame:FindFirstChild("WaveUnlock")
			local textLabel = waveUnlock and waveUnlock:FindFirstChild("TextLabel")

			if v == "" then
				waveUnlock.Visible = false
			else
				local enemy = ShopDataV2.Items.Enemies[v]
				EnemyViewport.Build(child.MainFrame, v, {
					RotationOffset = enemy.ViewportRotationOffset,
					Zoom = enemy.ViewportZoom
				})
				local enemyConfig = ResourceManager.GetEnemyConfig(v)

				if enemyConfig and enemyConfig.UnlockWave then
					textLabel.Text = tostring(enemyConfig.UnlockWave)
					waveUnlock.Visible = true
				else
					waveUnlock.Visible = false
				end
			end
		end

		child:SetAttribute("LastEnemy", v)
		child.Trash.Visible = v ~= ""
	end
end

function InventoryEnemies:Destroy() end

if _G.PVP_SHOP_ENABLED then
	Director.Register(script.Name, { InventoryEnemies }, game.Players)
end

return InventoryEnemies