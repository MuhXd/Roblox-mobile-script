-- Like geode node ids just for Fluxus
local debugmode = false

local Editors = {}
local hhhhhh={}
local ids = {
	[156] = "IconDraggable";
	[159] = "Script Editor";
	[189] = "Online Scripts";
	[195] = "Console";
	[105] = "Settings Selectors";
	[19] = "Script Editor Selectors";
	[46] = "Online Scripts Selectors";
	[5] = "UI Selectors";
	[69] = "Console Selector";
	[202] = "TemplateTab";
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
if not isfolder('FluxusNodeIds') then
	makefolder('FluxusNodeIds')
end
local LoadSettings = {}
function feach()
	if not Files then
		return false
	end
	if not isfile("FluxusNodeIds/Mods.Fluxus") then
		return true
	end
	local index
	local val
	local s = false
	for i,v in pairs(readfile("FluxusNodeIds/Mods.Fluxus"):split("|")) do
		if index and val then
			LoadSettings[index] = val
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
			if LoadSettings[ID] ~= nil then
				SaveSettings[ID] = LoadSettings[ID] 
			elseif def ~= nil then
				SaveSettings[ID] = def
			else
				SaveSettings[ID] = false
			end
			CallBack(SaveSettings[ID])
			sprite(SaveSettings[ID])
			F:FindFirstChild("Selector").MouseButton1Down:Connect(function()
				SaveSettings[ID] = not SaveSettings[ID]
				sprite(SaveSettings[ID])
				if CallBack then
					CallBack(SaveSettings[ID])
				end
			end)
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
	
	fluxusUI.LeftBarFrame:GetPropertyChangedSignal("Visible"):Connect(function()
		fluxusUI:SetAttribute("Hide",not fluxusUI.LeftBarFrame.Visible)
		if fluxusUI:GetAttribute("Hide") then
			if debugmode then
				print("move some thing due to a bug not tweening")
			end
		end
	end)
	
	local Exit = FluxusUINodeIdsApi.CreateTemplate("Close", false)
	Exit["Frame"].LayoutOrder = 99999
	local eee = FluxusUINodeIdsApi.CreateTemplate("eee", true) -- unfinished api
	local E = FluxusUINodeIdsApi.NewSetting("E","Viper.Example",false, function(e)
		print(e)
	end) -- unfinished api
	
	Exit["TextButton"].MouseButton1Down:Connect(function()
		FluxusUINodeIdsApi.CloseUi()
	end)
	
	print("Provided Node Ids for Fluxus")
else
	warn("You are not on fluxus")
end
function saveSettingsFile()
	if Files then
		local stringSave = ""
		for i,v in pairs(SaveSettings) do
			stringSave = i.."|"..tostring(v).."|"
		end
		writefile("FluxusNodeIds/Mods.Fluxus",stringSave)
	end
end
game.Players.PlayerRemoving:Connect(function(plr)
	if plr == game.Players.LocalPlayer then
		saveSettingsFile()
	end
end)
