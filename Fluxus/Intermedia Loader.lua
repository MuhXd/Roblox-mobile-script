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
	["Intermedia"] = "InternalRoot"
}

function loadmods()
	if not lls then
		return false
	end
	for i,v in pairs(listfiles("Intermedia/Mods")) do
		ModsLoaded[i] = v
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
		end
		if v.Name == "Executor" then
			v.LayoutOrder = 100
		end
		if v.Name == "Console" then
			v.LayoutOrder = 300
		end
		if v.Name == "Settings" then
			v.LayoutOrder = 400
		end
	end
	logo = fluxusUI.LeftBarFrame.Logo
	
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
	getgenv().FluxusUINodeIdsApi = {
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
	}
	
	local function modsinit(path)
		local InstalledMods = Instance.new("ScrollingFrame")
		local Mods = Instance.new("UIListLayout")
		local Mod = Instance.new("Frame")
		local TextLabel = Instance.new("TextLabel")
		local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

		InstalledMods.Name = "Installed Mods"
		InstalledMods.Active = true
		InstalledMods.BackgroundColor3 = Color3.fromRGB(103, 61, 234)
		InstalledMods.BackgroundTransparency = 1.000
		InstalledMods.BorderColor3 = Color3.fromRGB(0, 0, 0)
		InstalledMods.BorderSizePixel = 0
		InstalledMods.Position = UDim2.new(0.00139625813, 0, 0.0494233929, 0)
		InstalledMods.Size = UDim2.new(0.980000019, 0, 0.949241579, 0)
		InstalledMods.CanvasSize = UDim2.new(0, 0, 0, 115)
		InstalledMods.ScrollBarThickness = 2
		InstalledMods.Parent = path

		Mods.Name = "Mods"
		Mods.Parent = InstalledMods
		Mods.SortOrder = Enum.SortOrder.Name
		Mods.Padding = UDim.new(0, 8)

		Mod.Name = "Mod"
		Mod.BackgroundColor3 = Color3.fromRGB(56, 56, 56)
		Mod.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Mod.BorderSizePixel = 0
		Mod.Size = UDim2.new(0.983079672, 0, 0.0798348263, 0)

		TextLabel.Parent = Mod
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0.0115942033, 0, 0, 0)
		TextLabel.Size = UDim2.new(0.988405824, 0, 1, 0)
		TextLabel.Font = Enum.Font.GothamBold
		TextLabel.Text = "Fluxus Themes"
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextScaled = true
		TextLabel.TextSize = 14.000
		TextLabel.TextStrokeTransparency = 0.000
		TextLabel.TextWrapped = true

		UITextSizeConstraint.Parent = TextLabel
		UITextSizeConstraint.MaxTextSize = 25
		return Mod
	end
	
	fluxusUI.LeftBarFrame:GetPropertyChangedSignal("Visible"):Connect(function()
		fluxusUI:SetAttribute("Hide",not fluxusUI.LeftBarFrame.Visible)
		if fluxusUI:GetAttribute("Hide") then
			if debugmode then
				print("move some thing due to a bug not tweening")
			end
		end
	end)
	
	local Exit = FluxusUINodeIdsApi.CreateTemplate("Hide", false)
	Exit["Frame"].LayoutOrder = 99999
	local Mods = FluxusUINodeIdsApi.CreateTemplate("Loaded Mods", true) 
	Mods["Frame"].LayoutOrder = 350
	local IntermediaHeading = FluxusUINodeIdsApi.NewSettingHeader("Intermedia") 
	local HideMenu = FluxusUINodeIdsApi.NewSetting("Hide Menu Button","intermedia.CloseButton",false, function(e)
			Exit["Frame"].Visible = e
	end) 
	local ModsSetting = FluxusUINodeIdsApi.NewSetting("Mods Button","intermedia.ModsButton",true, function(e)
		Mods["Frame"].Visible = e
	end) 
	HideMenu:FindFirstChild("Text").TextSize = 11
	local moditem = modsinit(Mods["UI"]:FindFirstChild("Container"))
	Exit["TextButton"].MouseButton1Down:Connect(function()
		FluxusUINodeIdsApi.CloseUi()
	end)
	loadmods()
	for i,v in pairs(ModsLoaded) do
		Item = moditem:Clone()
		Item.TextLabel.Text = string.gsub(i,"Intermedia/Mods","")
		Item.Name = v == "InternalRoot" and "!!!!!!!!!!!!!!!!!!!!Important-Intermedia!!!!!!!!!!!!!!!!!!!!" or string.gsub(i,"Intermedia/Mods","")
		Item.Parent = Mods["UI"]:FindFirstChild("Container")
	end
	
	moditem:Destroy()
	
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
