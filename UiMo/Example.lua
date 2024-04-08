
local Ui = loadstring(game:HttpGet("https://github.com/MuhXd/Roblox-mobile-script/blob/main/UiMo/Loader.lua?raw=true"))();

Local MoUi = Ui.SpawnUi({
	["UiName"] = "Hub",
	["Deley"] = 3
})


MoUi.Button({
	["Name"] = "Test Button",
	["Info"] = "Test Info",
	["InfoButton"] = "._.",
	["Function"] = function ()
			MoUi.Notify({
				["Name"] = "Test notify",
				["Info"] = "Test info",
				["LifeTime"] = 20
			})
		
	end
})

MoUi.NewLine()

MoUi.CheckBox({
	["Name"] = "CheckBox alert",
	["Info"] = "Template",
	["Function"] = function (bool)
		MoUi.Notify({
			["Name"] = "Test CheckBox",
			["Info"] = "Enabled: "..tostring(bool),
			["LifeTime"] = 20
		})
	end
})
