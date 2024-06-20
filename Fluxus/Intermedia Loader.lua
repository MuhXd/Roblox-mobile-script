--[[
       ______  __    __  ________  ________  _______   __       __  ________  _______   ______   ______         __        ______    ______   _______   ________  _______  
      |      \|  \  |  \|        \|        \|       \ |  \     /  \|        \|       \ |      \ /      \       |  \      /      \  /      \ |       \ |        \|       \ 
       \$$$$$$| $$\ | $$ \$$$$$$$$| $$$$$$$$| $$$$$$$\| $$\   /  $$| $$$$$$$$| $$$$$$$\ \$$$$$$|  $$$$$$\      | $$     |  $$$$$$\|  $$$$$$\| $$$$$$$\| $$$$$$$$| $$$$$$$\
        | $$  | $$$\| $$   | $$   | $$__    | $$__| $$| $$$\ /  $$$| $$__    | $$  | $$  | $$  | $$__| $$      | $$     | $$  | $$| $$__| $$| $$  | $$| $$__    | $$__| $$
        | $$  | $$$$\ $$   | $$   | $$  \   | $$    $$| $$$$\  $$$$| $$  \   | $$  | $$  | $$  | $$    $$      | $$     | $$  | $$| $$    $$| $$  | $$| $$  \   | $$    $$
        | $$  | $$\$$ $$   | $$   | $$$$$   | $$$$$$$\| $$\$$ $$ $$| $$$$$   | $$  | $$  | $$  | $$$$$$$$      | $$     | $$  | $$| $$$$$$$$| $$  | $$| $$$$$   | $$$$$$$\
       _| $$_ | $$ \$$$$   | $$   | $$_____ | $$  | $$| $$ \$$$| $$| $$_____ | $$__/ $$ _| $$_ | $$  | $$      | $$_____| $$__/ $$| $$  | $$| $$__/ $$| $$_____ | $$  | $$
      |   $$ \| $$  \$$$   | $$   | $$     \| $$  | $$| $$  \$ | $$| $$     \| $$    $$|   $$ \| $$  | $$      | $$     \\$$    $$| $$  | $$| $$    $$| $$     \| $$  | $$
       \$$$$$$ \$$   \$$    \$$    \$$$$$$$$ \$$   \$$ \$$      \$$ \$$$$$$$$ \$$$$$$$  \$$$$$$ \$$   \$$       \$$$$$$$$ \$$$$$$  \$$   \$$ \$$$$$$$  \$$$$$$$$ \$$   \$$
                                                                                                                                                                          
                                                                                                                                                                          
                                                                                                                                                                          
A loader used to make modifying Fluxus Ui easier

]]

local debugmode = false

local Editors = {}
local hhhhhh={}
local ids = {
	[156] = "IconDraggable";
	[105] = "Settings Selectors";
	[19] = "Script Editor Selectors";
	[46] = "Online Scripts Selectors";
	[5] = "UI Selectors";
	[69] = "Console Selector";
	[3] = "Template Selector";
}
local Back
local editor = {
	"Script Editor";
	"Online Scripts";
	"Script Editor";
	"Console";
	"Settings Selectors";
}

local UISelectors
local TemplateTab
local setttingmenu
local Selector
local UI
local old 
local header
local logo
local toggle
local togglecolors = {
	["On"] = 	Color3.fromRGB(103, 61, 234);
	["Off"] = 	Color3.fromRGB(70, 70, 72);
}
local SaveSettings = {
}
local recoloredui = {}
local currentSelectedUi
function SetupIds(index, object)
	if debugmode then
		print(index,object.Name)
	end
	if ids[index] then
		object.Name = ids[index]
	end
end
local Files = isfile and isfolder and writefile and readfile and makefolder
local lls = listfiles and ( (loadstring and readfile) or dofile)
local method = dofile or function(path) 
	loadstring(readfile(path))
end
if not isfolder('Intermedia') then
	makefolder('Intermedia')
end
if not isfolder('Intermedia/Mods') then
	makefolder('Intermedia/Mods')
end

local ModsLoaded = {

}

function loadmods()
	if not lls then
		return false
	end
	for i,v in pairs(listfiles("Intermedia/Mods")) do
		method(v)
	end
end
function feach()
	if not Files then
		return false
	end
	if not isfile("Intermedia/Mods_save.Fluxus") then
		return true
	end
	local index
	local val
	local s = false
	for i,v in pairs(readfile("Intermedia/Mods_save.Fluxus"):split("|")) do
		if index and val then
			SaveSettings[index] = val
			index = nil
			val = nil
			s = true
		end
		if not index and s == false then
			index = v
		elseif not val and s == false then
			val = v
		end
		s = false
	end
	return true
end
if identifyexecutor() == "Fluxus" then
	if FluxusUINodeIds then
		-- do not annoy the user with 5+ prints for already running
		return
	end
	local function vis(v)
		v:GetPropertyChangedSignal("Visible"):Connect(function()
			if v.Visible then
				currentSelectedUi = v.Name
				if debugmode then
					print(currentSelectedUi)
				end
			elseif v.Visible == false and v.Name == currentSelectedUi then
				old = currentSelectedUi
				currentSelectedUi = nil	
			end

		end)
	end
	local fluxusUI = game:GetService("CoreGui"):WaitForChild("FluxusAndroidUI")
	-- fixes TemplateTab bug
	for i,v in pairs(fluxusUI:GetChildren()) do 
		if i == 3 then
			v.Name = "Script Editor"
		elseif i == 4 then
			v.Name = "Online Scripts"
		elseif i==5 then
			v.Name = "Console"
		elseif i == 6 then
			v.Name = "TemplateTab"
		end
	end
	for i,v in pairs(fluxusUI:GetDescendants()) do 
		SetupIds(i,v)
		if v.Name == "Back" then
			Back = v
		end
		if v.Name == "TemplateTab" then
			TemplateTab = v
		end
		if v.Name == "Template Selector" then
			Selector = v
		end
		if v.Name == "Settings Selectors" then
			setttingmenu = v
			toggle = v:FindFirstChild("Toggle"):Clone()
			toggle.Selector.BackgroundColor3 = togglecolors["Off"]
			toggle.Parent = nil
		end
		if v.Name == "Label" and v:IsA("TextLabel") then
			if v.Text =="Fluxus" then
				header = v
			end
		end
		if v.Name == "UI Selectors" then
			UISelectors = v
			UI = v:FindFirstChild("Settings"):Clone()
			UI.Parent = nil
		end
		if table.find(editor,v.Name) then
			vis(v)
		end
	end
	for i,v in pairs(UISelectors:GetChildren()) do
		if v.Name == "Cloud" then
			v.LayoutOrder = 200
			recoloredui["CloudTab"] = v
		end
		if v.Name == "Executor" then
			v.LayoutOrder = 100
			recoloredui["ExecutorTab"] = v
		end
		if v.Name == "Console" then
			v.LayoutOrder = 300
			recoloredui["ConsoleTab"] = v
		end
		if v.Name == "Settings" then
			v.LayoutOrder = 400
			recoloredui["SettingsTab"] = v
		end
	end
	logo = fluxusUI.LeftBarFrame.Logo
	recoloredui["Logo"] = logo
	recoloredui["Ui-Button"] = fluxusUI.IconDraggable
	logo.MouseButton1Down:Connect(function()
		fluxusUI:SetAttribute("Hide",true)
	end)

	local function Close()
		if firesignal then
			firesignal(logo.MouseButton1Down)
		else
			local leftBarFrame = fluxusUI:FindFirstChild("LeftBarFrame")
			if leftBarFrame then
				fluxusUI:SetAttribute("Hide",true)
				leftBarFrame.Visible = false
				leftBarFrame.Position = UDim2.new(0, -225, 0, 0)
			end
		end
	end

	local function ShowUi(Object)
		Object.Visible = true
		Object.Position = UDim2.new(0.1, 100,0, 0)
		Object.Size = UDim2.new(0.9, -100,1, 0)
	end
	getgenv().FluxusUINodeIds = true
	currentSelectedUi = nil

	local hook 
	feach()
	local function recolor(path,color,speed,d)
		if typeof(path) == "string" then
			if recoloredui[path] then
				path = recoloredui[path]
			end
		end
		if path == recoloredui["Ui-Button"] and not d then
			task.spawn(function()
				recolor("Logo",color,speed,true)
			end)
		elseif path == recoloredui["Logo"] and not d then
			task.spawn(function()
				recolor("Ui-Button",color,speed,true)
			end)
		end
		if tonumber(speed) == nil then
			speed = 1
		end
		local colorset = {}
		pcall(function()
			if path.BorderColor3 then
				colorset["BorderColor3"] = color["Color3"]
			end
		end)
		pcall(function()
			if path.BackgroundColor3 then
				colorset["BackgroundColor3"] = color["Color3"]
			end
		end)
		
		pcall(function()
			if path.Image and color["Image"] then
				colorset["Image"] = color["Image"]
			end
		end)
		
		game:GetService("TweenService"):Create(path,TweenInfo.new(speed),colorset):Play()
		return path
	end
	
	local apis = {
			["Colorify"] = recolor;
			["NewSettingHeader"] = function(Name)
				local heade = header:Clone()
				heade.Parent = setttingmenu
				heade.Text = Name
				heade.Name = Name
			end,
			["NewSetting"] = function(Name,ID,def,CallBack)
				if string.find(ID,"|") then
					return error("Invalid char, '|'")
				end

				local F = toggle:Clone()
				F:FindFirstChild("Text").Text = Name
				F.Parent = setttingmenu
				local sel = F:WaitForChild("Selector")

				local function sprite(s)
					if tostring(s) == "true" then -- stops umm loading breaking
						sel.BackgroundColor3 = togglecolors["On"]
					else
						sel.BackgroundColor3 = togglecolors["Off"]
					end
				end
				if SaveSettings[ID] ~= nil then
					SaveSettings[ID] = SaveSettings[ID] 
				elseif def ~= nil then
					SaveSettings[ID] = def
				else
					SaveSettings[ID] = false
				end

				local function covertstringtobool(d) -- lazy
					if tostring(d) == "true" then
						return true
					elseif tostring(d) == "false" then
						return false
					else
						return false
					end
				end

				CallBack(covertstringtobool(SaveSettings[ID]) )
				sprite(SaveSettings[ID])
				F:FindFirstChild("Selector").MouseButton1Down:Connect(function()
					SaveSettings[ID] = not SaveSettings[ID]
					sprite(SaveSettings[ID])
					if CallBack then
						CallBack(covertstringtobool(SaveSettings[ID]) )
					end
				end)
				return F
			end;
			["CreateTemplate"] = function(Name,TemplateArea)
				local Tem
				local sel
				local back
				local R = UI:Clone()
				R.Name = Name
				R.Parent = UISelectors
				R.LayoutOrder = 500
				R.TextButton.Text = Name
				if TemplateArea then
					sel = Selector:Clone()
					sel.Parent = fluxusUI:FindFirstChild("LeftBarFrame")
					Tem = TemplateTab:Clone()
					Tem.Name = Name.."'s_UI"
					hhhhhh[Name] = {
						sel,Tem
					}
					Tem.Parent = fluxusUI
					back = Back:Clone()
					back.Parent = sel
					back.TextButton.MouseButton1Down:Connect(function()
						if currentSelectedUi ~= nil then
							if hook then
								hook:Disconnect()
							end
							UISelectors.Visible = true
							sel.Visible = false
							Tem.Visible = false
						end
					end)
					vis(Tem)
					R.TextButton.MouseButton1Down:Connect(function()
						if currentSelectedUi == nil then
							hook = fluxusUI:GetAttributeChangedSignal("Hide"):Connect(function()
								if fluxusUI:GetAttribute("Hide") then
									sel.Visible = false
									Tem.Visible = false
									UISelectors.Visible = true
									hook:Disconnect()
								end
							end)

							UISelectors.Visible = false
							sel.Visible = true
							ShowUi(Tem)
						end
					end)
				end

				return {
					["Frame"] = R;
					["TextButton"] = R.TextButton; 
					["Selector"] = sel; 
					["UI"] = Tem;
				}
			end;
			["CloseUi"] = Close;
			["fluxusUI"] = fluxusUI;
			["SettingsMenu"] = setttingmenu;
			}
	
	
	local function modsinit(path)


		local Mod = Instance.new("Frame")
		local Mod_2 = Instance.new("TextLabel")
		local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
		local Devs = Instance.new("TextLabel")
		local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")

		Mod.Name = "Mod"
		Mod.BackgroundColor3 = Color3.fromRGB(56, 56, 56)
		Mod.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Mod.BorderSizePixel = 0
		Mod.Size = UDim2.new(0.983079672, 0, 0.0798348263, 0)

		Mod_2.Name = "Mod"
		Mod_2.Parent = Mod
		Mod_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Mod_2.BackgroundTransparency = 1.000
		Mod_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Mod_2.BorderSizePixel = 0
		Mod_2.Position = UDim2.new(0.0115941744, 0, 0, 0)
		Mod_2.Size = UDim2.new(0.988405764, 0, 0.688643217, 0)
		Mod_2.Font = Enum.Font.GothamBold
		Mod_2.Text = "N/A"
		Mod_2.TextColor3 = Color3.fromRGB(255, 255, 255)
		Mod_2.TextScaled = true
		Mod_2.TextSize = 14.000
		Mod_2.TextStrokeTransparency = 0.000
		Mod_2.TextWrapped = true

		UITextSizeConstraint.Parent = Mod_2
		UITextSizeConstraint.MaxTextSize = 25

		Devs.Name = "Devs"
		Devs.Parent = Mod
		Devs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Devs.BackgroundTransparency = 1.000
		Devs.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Devs.BorderSizePixel = 0
		Devs.Position = UDim2.new(0.0130087743, 0, 0.688643217, 0)
		Devs.Size = UDim2.new(0.988405764, 0, 0.29779166, 0)
		Devs.Font = Enum.Font.GothamBold
		Devs.Text = "By example"
		Devs.TextColor3 = Color3.fromRGB(255, 255, 255)
		Devs.TextScaled = true
		Devs.TextSize = 14.000
		Devs.TextStrokeTransparency = 0.000
		Devs.TextWrapped = true

		UITextSizeConstraint_2.Parent = Devs
		UITextSizeConstraint_2.MaxTextSize = 25
		return Mod
	end
	recoloredui["LeftBarFrame"] = fluxusUI.LeftBarFrame;
	
	fluxusUI.LeftBarFrame:GetPropertyChangedSignal("Visible"):Connect(function()
		fluxusUI:SetAttribute("Hide",not fluxusUI.LeftBarFrame.Visible)
		if fluxusUI:GetAttribute("Hide") then
			if debugmode then
				print("move some thing due to a bug not tweening")
			end
		end
	end)
	local Mods = apis.CreateTemplate("Loaded Mods", true) 
	local moditem = modsinit(Mods["UI"]:FindFirstChild("Container"))
	getgenv().FluxusUINodeIdsApi = {
		["InitMod"] = function(self,modid,name,devs)
			if table.find(ModsLoaded,modid) then
				error("Mod already loaded")
				return nil
			end
			task.spawn(function()
			ModsLoaded[modid] = devs
			local Item = moditem:Clone()
			Item.Mod.Text = name
			Item.LayoutOrder = 1
			
			if name == "Viper.IntermediaMain" then
				Item.LayoutOrder = 99999
			end
			local moddevs=""
			for i,v in pairs(devs) do
				if v == "rblx" or v == "roblox" or v == "userid" or v == "rblxuser" then
						local a = game:GetService("UserService"):GetUserInfosByUserIdsAsync({i})[1]
					if a[1] then
						a = a[1]
					end
					if a then
							if a.DisplayName ~= a.Username then
							if moddevs ~= "" then
								moddevs = moddevs.." & "..a.DisplayName.." (@"..a.Username..")"
							else
								moddevs = a.DisplayName.." (@"..a.Username..")"
							end
						else
							if moddevs ~= "" then
									moddevs = moddevs.." & "..a.DisplayName
							else
									moddevs = a.DisplayName
							end
						end
					else
						
					end
				else
					-- just do name
						if moddevs ~= "" then
							moddevs = moddevs.." & "..tostring(i)
						else
							moddevs = tostring(i)
						end
				end
			end
			Item.Devs.Text = "By "..moddevs
			Item.Parent = Mods["UI"]:FindFirstChild("Container")
			end)
			return apis
		end,
	}
	local ModInitsApi = FluxusUINodeIdsApi:InitMod("Viper.IntermediaMain","Intermedia", {[530829101] = "userid"})
	local Exit = ModInitsApi.CreateTemplate("Hide", false)
	--ModInitsApi.Colorify(fluxusUI.IconDraggable,{["Color3"] = Color3.fromRGB(170, 0, 255)},10) added colorify
	Exit["Frame"].LayoutOrder = 99999
	Mods["Frame"].LayoutOrder = 350
	local IntermediaHeading = ModInitsApi.NewSettingHeader("Intermedia") 
	local HideMenu = ModInitsApi.NewSetting("Hide Menu Button","intermedia.CloseButton",false, function(e)
		Exit["Frame"].Visible = e
	end) 
	local ModsSetting = ModInitsApi.NewSetting("Mods Button","intermedia.ModsButton",true, function(e)
		Mods["Frame"].Visible = e
	end) 
	HideMenu:FindFirstChild("Text").TextSize = 11

	Exit["TextButton"].MouseButton1Down:Connect(function()
		ModInitsApi.CloseUi()
	end)
	loadmods()

	print("SUCCESSFULLY LOADED INTERMEDIA LOADER")
else
	warn("You are not on fluxus")
end
function saveSettingsFile()
	if Files then
		local stringSave = ""
		for i,v in pairs(SaveSettings) do
			stringSave = i.."|"..tostring(v).."|"
		end
		writefile("Intermedia/Mods_save.Fluxus",stringSave)
	end
end
game.Players.PlayerRemoving:Connect(function(plr)
	if plr == game.Players.LocalPlayer then
		saveSettingsFile()
	end
end)
