--[[
-- ! STILL WIP SUBJECT TO CHANGE !

_G.Viper_Themeify = {
	ThemeDevs = {
		{[1] = "userid"} -- put userid
	};
	ThemeName = "Synapse X";
	Image = 9524079125,
	FloatingIconColor=Color3.fromRGB(59, 59, 59),
	MainUiBackground = Color3.fromRGB(20, 20, 20),
	SelectorButtons= Color3.fromRGB(57, 57, 57),
}
]]--
local debugmode = false
local localspeedtweenDebug = 5.5
if not FluxusUINodeIdsApi then
	loadstring(game:HttpGet("https://github.com/MuhXd/Roblox-mobile-script/blob/main/Fluxus/Intermedia%20Loader.lua?raw=true"))();
	game:GetService("CoreGui"):WaitForChild("FluxusAndroidUI")
end
if not _G.Viper_ThemeifyStorage then
	_G.Viper_ThemeifyStorage = {}
end
local viper = _G.Viper_Themeify.ThemeDevs or {}
viper[530829101] = "userid"
local ModInitsApi
local Modname = _G.Viper_Themeify.ThemeName or nil
if name ~= nil then
	name = _G.Viper_Themeify.ThemeName.." Theme"
else
	name = "Themeify"
end
if not _G.Viper_Themeify["ModApi"] then
	ModInitsApi = FluxusUINodeIdsApi:InitMod("Viper.Themeify",Modname, viper)
	_G.Viper_ThemeifyStorage["ModApi"] = ModInitsApi
else
	ModInitsApi = _G.Viper_ThemeifyStorage["ModApi"] 
	ModInitsApi:EditInfo({
		["Devs"] = viper;
		["Name"] = Modname;
	})
end

task.spawn(function()
	task.wait(1)
	ModInitsApi.Colorify(ModInitsApi.GetUi("Ui-Button"),{
		["Color3"] = _G.Viper_Themeify.FloatingIconColor or nil;
	},(localspeedtweenDebug-1) ) 	
end)
local function tweenimages(imager,image)
	local a = imager:Clone()
	a.Parent = imager.Parent
	a.Name = "_Fade"
	a.ZIndex = (imager.ZIndex + 1)
	local b = game:GetService("TweenService"):Create(a,TweenInfo.new(localspeedtweenDebug),{
		["ImageTransparency"] = 1;
	})
	imager.Image = image
	imager.ImageTransparency = 1
	local c = game:GetService("TweenService"):Create(imager,TweenInfo.new(localspeedtweenDebug),{
		["ImageTransparency"] = 0;
	})
	
	task.spawn(function()
		c:Play()
	end)
	task.spawn(function()
		b:Play()
	end)
	
	task.spawn(function()
		task.wait(localspeedtweenDebug+2)
		a:Remove()
	end)
end
task.spawn(function()
	tweenimages(ModInitsApi.GetUi("Logo"),"rbxassetid://".._G.Viper_Themeify["Image"])
	tweenimages(ModInitsApi.GetUi("Ui-Button"):FindFirstChild("Logo"),"rbxassetid://".._G.Viper_Themeify["Image"])
end)

local flux = ModInitsApi.GetUi("Fluxus")
local UISelectors = ModInitsApi.GetUi("UISelectors")
if debugmode then
	print(flux)
end
task.spawn(function()
	for i,c in pairs(UISelectors.Parent:GetChildren()) do
		task.spawn(function()
			for ii,v in pairs(UISelectors.Parent:GetChildren()) do
				task.spawn(function()
					ModInitsApi.Colorify(v,{
						["Color3"] = _G.Viper_Themeify.SelectorButtons or nil;
					},localspeedtweenDebug)
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
			},localspeedtweenDebug) 
		end
	end)
end
