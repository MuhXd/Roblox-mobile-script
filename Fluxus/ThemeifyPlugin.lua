--[[
-- ! STILL WIP SUBJECT TO CHANGE !

_G.Viper_Themeify = {
	ThemeDevs = {
		{[1] = "userid"} -- put userid
	};
	Image = 9524079125,
	FloatingIconColor=Color3.fromRGB(59, 59, 59),
	MainUiBackground = Color3.fromRGB(20, 20, 20),
	SelectorButtons= Color3.fromRGB(57, 57, 57),
}
]]--

if not FluxusUINodeIdsApi then
	loadstring(game:HttpGet("https://github.com/MuhXd/Roblox-mobile-script/blob/main/Fluxus/Intermedia%20Loader.lua?raw=true"))();
end
if not _G.Viper_ThemeifyStorage then
	_G.Viper_ThemeifyStorage = {}
end
local viper = _G.Viper_Themeify.ThemeDevs or {}
viper[530829101] = "userid"
local ModInitsApi
if not _G.Viper_Themeify["ModApi"] then
	ModInitsApi = FluxusUINodeIdsApi:InitMod("Viper.Themeify","Themes", viper)
	_G.Viper_ThemeifyStorage["ModApi"] = ModInitsApi
else
	ModInitsApi = _G.Viper_ThemeifyStorage["ModApi"] 
	ModInitsApi:EditInfo({
		["Devs"] = viper
	})
end
ModInitsApi.Colorify(ModInitsApi.GetUi("Ui-Button"),{
	["Color3"] = _G.Viper_Themeify.FloatingIconColor or nil;
},3) 

ModInitsApi.GetUi("Ui-Button"):FindFirstChild("Logo").Image = "rbxassetid://".._G.Viper_Themeify["Image"]
ModInitsApi.GetUi("Logo").Image = "rbxassetid://".._G.Viper_Themeify["Image"]
local flux = ModInitsApi.GetUi("Fluxus")
local UISelectors = ModInitsApi.GetUi("UISelectors")
print(flux)
task.spawn(function()
	for i,c in pairs(UISelectors.Parent:GetChildren()) do
		task.spawn(function()
			for ii,v in pairs(UISelectors.Parent:GetChildren()) do
				task.spawn(function()
					ModInitsApi.Colorify(v,{
						["Color3"] = _G.Viper_Themeify.SelectorButtons or nil;
					},3)
				end)
			end
		end)
	end
end)
for i,v in pairs(flux:GetChildren()) do
	task.spawn(function()
		if v:FindFirstChild("Container") then
			ModInitsApi.Colorify(v,{
				["Color3"] = _G.Viper_Themeify.MainUiBackground or nil;
			},3) 
		end
	end)
end
