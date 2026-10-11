local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local SoundDefinitions = require(common:WaitForChild("SoundDefinitions"))
return SoundDefinitions.Merge({
	Tutorial1 = SoundDefinitions.AmbientMusic("rbxassetid://104054793471438", 0.15, "Tutorial Bop Music"),
	Tutorial2 = SoundDefinitions.AmbientMusic("rbxassetid://114625611598439", 0.15, "Tutorial Phoenix"),
	EliteWave27Music = SoundDefinitions.AmbientMusic("rbxassetid://135453776052269", 0.4, "Elite - Crownbeares"),
	ExpertWave30Music = SoundDefinitions.AmbientMusic("rbxassetid://135935625730832", 0.4, "Expert - Greek Guys"),
	NightmareWave37 = SoundDefinitions.AmbientMusic("rbxassetid://134621612551111", 0.45),
	EmperorDeathAmbient = SoundDefinitions.AmbientMusic("rbxassetid://97418744615778", 0.45),
	NightmareSpecialWaveAmbient = SoundDefinitions.AmbientMusic("rbxassetid://128901391531557", 0.45),
	BunnyZillaWaveMusic = SoundDefinitions.AmbientMusic("rbxassetid://107284629766248")
}, SoundDefinitions.AmbientSet("PVP", 0.45, {
	{ "rbxassetid://96866258176463", "Commander Knows Best" },
	{ "rbxassetid://77670057685951", "Mimicry" },
	{ "rbxassetid://126691106876738", "The Call to Emulation" },
	{ "rbxassetid://76508619960897", "The Simulated Silence" },
	{ "rbxassetid://84605052571168", "Kitnet" },
	{ "rbxassetid://137363898381643", "G6" },
	{ "rbxassetid://77055185707861", "In Honor of General Celgar" },
	{ "rbxassetid://73881430445592", "Plucky" },
	{ "rbxassetid://117983401414743", "AgoraVai" },
	{ "rbxassetid://104587936149853", "Commander's Rave" },
	{ "rbxassetid://94948312160396", "Kerfrugle" },
	{ "rbxassetid://78430992214931", "Simulating Sands" },
	{ "rbxassetid://95468390396659", "Perc 1" },
	{ "rbxassetid://87168474045734", "Perc 2" },
	{ "rbxassetid://121271951199400", "The Joy of Relentless War" },
	{ "rbxassetid://118631164690395", "Aproximation" }
}), SoundDefinitions.AmbientSet("Easy", 0.45, {
	{ "rbxassetid://98735317045054", "You Can Do it!" },
	{ "rbxassetid://125113282284768", "Brought Back" },
	{ "rbxassetid://135087592701280", "The Slime to Come (Moderated?)" },
	{ "rbxassetid://82221600665218", "I Didn't Sign up for This!" },
	{ "rbxassetid://72534960795536", "The Slaughter to Come" },
	{ "rbxassetid://90716962506730", "Shotgunners Dilemma" }
}), SoundDefinitions.AmbientSet("Elite", 0.25, {
	{ "rbxassetid://83331988648578", "Elite - Monastery Rave" },
	{ "rbxassetid://82862439369807", "Elite - Vania's Castle" },
	{ "rbxassetid://116514079901580", "Elite - The Empty Castle" },
	{ "rbxassetid://128519692318255", "Elite - Let Us Dance!" },
	{ "rbxassetid://106817712511912", "Elite - Lava Golem" },
	{ "rbxassetid://127101275456585", "Elite - Ghouls and Ghosts" },
	{ "rbxassetid://106953149988598", "Elite - From the Meadows" },
	{ "rbxassetid://111500764787387", "Elite - B.O.Y.D" },
	{ "rbxassetid://101298989143089", "Elite - 1347" },
	{ "rbxassetid://113059425640503", "Elite - 5" }
}), SoundDefinitions.AmbientSet("Expert", 0.25, {
	{ "rbxassetid://124674447503972", "Expert - Silence before Storm" },
	{ "rbxassetid://92038978069000", "Expert - Replay" },
	{ "rbxassetid://92375852110684", "Expert - Total Wasteland" },
	{ "rbxassetid://104136326323203", "Expert - Eradicators Cry" },
	{ "rbxassetid://98616267676887", "Expert - Reevaluate Your Next Moves" },
	{ "rbxassetid://81826806062785", "Expert - Snare Tension" },
	{ "rbxassetid://120953101476940", "Expert - Regress" },
	{ "rbxassetid://139497131878430", "Expert - Reindustrialize" },
	{ "rbxassetid://103083135445266", "Expert - Ranger Rave" },
	{ "rbxassetid://87869942128950", "Expert - Failed Propaganda" },
	{ "rbxassetid://75314781805460", "Expert - Hostile Sands" },
	{ "rbxassetid://119416886909738", "Expert - Glacier" },
	{ "rbxassetid://130758190307944", "Expert - Found Troops" },
	{ "rbxassetid://127979549559164", "Expert - Slow March" }
}), SoundDefinitions.AmbientSet("Nightmare", 0.45, {
	{ "rbxassetid://84205045145118", "A Beast Like Me" },
	{ "rbxassetid://121645713215571", "Foward" },
	{ "rbxassetid://71120769570404", "The Last March of the GDA" },
	{ "rbxassetid://84741846662088", "Heroes For a Reason" },
	{ "rbxassetid://139065978519311", "We've Lost It All [No Vox]" },
	{ "rbxassetid://121156732169436", "Seize The BattleField" },
	{ "rbxassetid://112281209725594", "Rust in Pieces" },
	{ "rbxassetid://87334072017853", "Her Looming Presence" },
	{ "rbxassetid://75727677917656", "Factorium" },
	{ "rbxassetid://86975210842877", "Draz Gorth" },
	{ "rbxassetid://114266710456777", "F3" },
	{ "rbxassetid://98163614703400", "Ath Vek'dor Kai" },
	{ "rbxassetid://95106865210682", "Last Stand" },
	{ "rbxassetid://133855920731746", "Driven Mad by Fear" }
}), SoundDefinitions.AmbientSet("HalloweenNight1_", 0.25, {
	{ "rbxassetid://138812712784844", "The Hypnosis" },
	{ "rbxassetid://108949495548865", "The Little Chainsaw That Could" },
	{ "rbxassetid://79353738439911", "The Empty Grave" }
}), SoundDefinitions.AmbientSet("HalloweenNight2_", 0.25, {
	{ "rbxassetid://95730092182540", "The Joy of Relentless Danger" },
	{ "rbxassetid://81192682384570", "The Spook" },
	{ "rbxassetid://123824547356716", "The Trap" },
	{ "rbxassetid://108069757707625", "The Rave of the Dead" }
}), SoundDefinitions.AmbientSet("HalloweenNight3_", 0.25, {
	{ "rbxassetid://117570992060787", "Decrypt & Destroy" },
	{ "rbxassetid://99543134726980", "The Ticking" },
	{ "rbxassetid://138152314405387", "Shifting Sands" },
	{ "rbxassetid://93583188310486", "The Call to War" }
}), SoundDefinitions.AmbientSet("HalloweenNight4_", 0.25, {
	{ "rbxassetid://71438669679625", "The Hell Energy" },
	{ "rbxassetid://104126509057630", "The Premonition" },
	{ "rbxassetid://109524583227507", "The Haunted Whispers" },
	{ "rbxassetid://104513504848936", "The Quiet" },
	{ "rbxassetid://102547438875032", "The Shriek" },
	{ "rbxassetid://132609222118064", "The Hollow City" }
}), SoundDefinitions.AmbientSet("ChristmasPart1_", 0.25, {
	{ "rbxassetid://86051071428550", "Slashing Through the Snow" },
	{ "rbxassetid://100925519422216", "Jingle Hell Rave" },
	{ "rbxassetid://121305915306954", "Little Skull Cracker" },
	{ "rbxassetid://137685193909691", "Phoenix" },
	{ "rbxassetid://93969869905820", "Otti" }
}), SoundDefinitions.AmbientSet("ChristmasPart2_", 0.25, {
	{ "rbxassetid://124696364095596", "Colors Industry" },
	{ "rbxassetid://91025236596448", "Bitter Sweet Dee and Bee" },
	{ "rbxassetid://140101796144283", "Mandate and Take Over" },
	{ "rbxassetid://134438173519283", "Fatal Konfrontation on Bridge 3" },
	{ "rbxassetid://79338976665149", "Doom Sleigher" },
	{ "rbxassetid://78098897233858", "Trapped in Ice" },
	{ "rbxassetid://119477725763560", "Jingle Hell" }
}), SoundDefinitions.AmbientSet("MLG", 0.25, {
	{ "rbxassetid://136006094836587", "MOB JUSTICE" },
	{ "rbxassetid://114613596751191", "OMG WOW" },
	{ "rbxassetid://101182585879168", "ILLUMINATI" },
	{ "rbxassetid://91367411853894", "THE DEW OF THE MOUNTAIN" },
	{ "rbxassetid://90953019182839", "SANIC" }
}), SoundDefinitions.AmbientSet("SlimeEvent", 0.45, {
	{ "rbxassetid://95079995173043" },
	{ "rbxassetid://96280011783014" },
	{ "rbxassetid://99367301668650" },
	{ "rbxassetid://120473886279424" },
	{ "rbxassetid://83519666798903" },
	{ "rbxassetid://113739191346586" },
	{ "rbxassetid://83548767691635" }
}), SoundDefinitions.AmbientSet("Halloween2025_", 0.45, {
	{ "rbxassetid://115033736425363" },
	{ "rbxassetid://94809232820861" },
	{ "rbxassetid://83411368591045" },
	{ "rbxassetid://132003939905890" },
	{ "rbxassetid://107435052075833" },
	{ "rbxassetid://118042127475762" },
	{ "rbxassetid://138675986753404" },
	{ "rbxassetid://140694176814772" },
	{ "rbxassetid://105919831993344" }
}), SoundDefinitions.AmbientSet("Christmas25_", 0.45, {
	{ "rbxassetid://77848514221532" },
	{ "rbxassetid://132011676593195" },
	{ "rbxassetid://81366416698896" },
	{ "rbxassetid://139037169097411" },
	{ "rbxassetid://113534187872303" },
	{ "rbxassetid://102901690301729" },
	{ "rbxassetid://103510235303842" },
	{ "rbxassetid://91676140285800" },
	{ "rbxassetid://86138038572536" },
	{ "rbxassetid://131181612161795" },
	{ "rbxassetid://131216994271179" },
	{ "rbxassetid://129330870052261" },
	{ "rbxassetid://108803655597724" },
	{ "rbxassetid://102159896719544" }
}), SoundDefinitions.AmbientSet("Easter26_", 0.45, {
	{ "rbxassetid://93473565900867" },
	{ "rbxassetid://81043965940140" },
	{ "rbxassetid://117547674223406" },
	{ "rbxassetid://116380264969312" },
	{ "rbxassetid://87380653205020" },
	{ "rbxassetid://80688892070996" },
	{ "rbxassetid://129277637396805" },
	{ "rbxassetid://77932943313622" }
}), SoundDefinitions.AmbientSet("TB2_", 0.45, {
	{ "rbxassetid://133728651075216", "A Break From Violence" },
	{ "rbxassetid://132508206237520", "Into the Abyss" },
	{ "rbxassetid://114059652351216", "Mesmerized" },
	{ "rbxassetid://107326571486065", "Old Ones" },
	{ "rbxassetid://129740384640387", "And Yet They Fight!" },
	{ "rbxassetid://93325325545493", "VoroV" },
	{ "rbxassetid://87315987621240", "Adrift Zera" },
	{ "rbxassetid://113870671810402", "My Domain" },
	{ "rbxassetid://71614928386610", "Seize the Voildfield" },
	{ "rbxassetid://78310365569566", "His Looming Presence" },
	{ "rbxassetid://80533396811376", "Thing Below" },
	{ "rbxassetid://106033393434439", "Conquered Worlds" },
	{ "rbxassetid://136445735597919", "Gods of Nothing" },
	{ "rbxassetid://86700877848768", "Hypnotized" },
	{ "rbxassetid://100653089603932", "Lands Beyond [Revised]" },
	{ "rbxassetid://123962723934231", "We Challenge You" },
	{ "rbxassetid://114226055490848", "After the End" },
	{ "rbxassetid://102198022009889", "Portal Technology [Revised]" },
	{ "rbxassetid://124741601548875", "Military Might [Revised]" },
	{ "rbxassetid://91215063806541", "Void Shards" }
}))