local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local SoundDefinitions = require(common:WaitForChild("SoundDefinitions"))
return SoundDefinitions.Merge({
	CancelTower = SoundDefinitions.SFX("rbxassetid://10740049366"),
	ClickTower = SoundDefinitions.SFX("rbxassetid://10740049764"),
	PlaceTower = SoundDefinitions.SFX("rbxassetid://10740049949"),
	SellTower = SoundDefinitions.SFX("rbxassetid://10740050397"),
	UpgradeTower = SoundDefinitions.SFX("rbxassetid://10740050087"),
	WaveBonus = SoundDefinitions.SFX("rbxassetid://10740049476"),
	Error = SoundDefinitions.SFX("rbxassetid://15351746255", 0.5),
	TimerTick = SoundDefinitions.SFX("rbxassetid://10740050231", 0.35),
	WaveCashBonus = SoundDefinitions.SFX("rbxassetid://10740049476", 0.18),
	LostLife = SoundDefinitions.SFX("rbxassetid://12031605450", 0.45),
	EnemiesIncoming = SoundDefinitions.SFX("rbxassetid://14083001564", 0.25),
	TypingSound = SoundDefinitions.SFX("rbxassetid://13891400106", 0.15, { LayerCount = 10 }),
	CrystalsTypingSound = SoundDefinitions.SFX("rbxassetid://133352446916861", 0.15, {
		LayerCount = 10
	}),
	UpgradeShopAddUpgrade1 = SoundDefinitions.SFX("rbxassetid://89480655754776", 0.25),
	UpgradeShopAddUpgrade2 = SoundDefinitions.SFX("rbxassetid://71453293364310", 0.25),
	UpgradeShopAddUpgrade3 = SoundDefinitions.SFX("rbxassetid://132617506766283", 0.25),
	UpgradeShopAddUpgrade4 = SoundDefinitions.SFX("rbxassetid://101823984443474", 0.25),
	UpgradeShopRemoveUpgrade1 = SoundDefinitions.SFX("rbxassetid://129125804880119", 0.25),
	UpgradeShopRemoveUpgrade2 = SoundDefinitions.SFX("rbxassetid://79838139359004", 0.25),
	UpgradeShopRemoveUpgrade3 = SoundDefinitions.SFX("rbxassetid://82625702380575", 0.25),
	UpgradeShopRemoveUpgrade4 = SoundDefinitions.SFX("rbxassetid://118668332088823", 0.25),
	UpgradeShopReset = SoundDefinitions.SFX("rbxassetid://100270396962193", 0.25),
	PVPEcoIncrease = SoundDefinitions.SFX("rbxassetid://139018004976652"),
	PVPEcoDecrease = SoundDefinitions.SFX("rbxassetid://106812280626368"),
	PVPSendBoss = SoundDefinitions.SFX("rbxassetid://96742448024851"),
	PVPSendEnemy = SoundDefinitions.SFX("rbxassetid://74831611410076"),
	PVPDefensivePowerUpActivated = SoundDefinitions.SFX("rbxassetid://100559872230631"),
	PVPTabSwitch = SoundDefinitions.SFX("rbxassetid://95001426622363"),
	PVPEnemyPageSwitch = SoundDefinitions.SFX("rbxassetid://95001426622363")
})