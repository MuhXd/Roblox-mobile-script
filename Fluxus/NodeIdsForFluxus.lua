-- Like geode node ids just for Fluxus
local debugmode = false

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
local UISelectors
local TemplateTab
local Selector
local UI
function SetupIds(index, object)
	if debugmode then
		print(index,object.Name)
	end
	if ids[index] then
		object.Name = ids[index]
	end
end

if identifyexecutor() == "Fluxus" then
	if FluxusUINodeIds then
		-- do not annoy the user with 5+ prints for already running
		return
	end
	local fluxusUI = game:GetService("CoreGui"):WaitForChild("FluxusAndroidUI")
	for i,v in pairs(fluxusUI:GetDescendants()) do 
		SetupIds(i,v)
		if v.Name == "TemplateTab" then
			TemplateTab = v
		end
		if v.Name == "Template Selector" then
			Selector = v
		end
		if v.Name == "UI Selectors" then
			UISelectors = v
			UI = v:FindFirstChild("Settings"):Clone()
			UI.Parent = nil
		end
	end
	local function Close()
		if firesignal then
			firesignal(fluxusUI.LeftBarFrame.Logo.MouseButton1Down)
		else
			local leftBarFrame = fluxusUI:FindFirstChild("LeftBarFrame")
			if leftBarFrame then
				leftBarFrame.Visible = false
				leftBarFrame.Position = UDim2.new(0, -225, 0, 0)
			end
		end
	end
	
	getgenv().FluxusUINodeIds = true
	
	getgenv().FluxusUINodeIdsApi = {
		["CreateTemplate"] = function(Name,TemplateArea)
			if TemplateArea then
				
			end
			local R = UI:Clone()
			R.Name = Name
			R.Parent = UISelectors
			R.TextButton.Text = Name
			return {["Frame"] = R; ["TextButton"] = R.TextButton}
		end,
		["CloseUi"] = Close
	}
	
	local Exit = FluxusUINodeIdsApi.CreateTemplate("Close", false)
	
	Exit["TextButton"].MouseButton1Down:Connect(function()
		FluxusUINodeIdsApi.CloseUi()
	end)
	
	print("Provided Node Ids for Fluxus")
else
	warn("You are not on fluxus")
end
