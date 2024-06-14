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
	end
	getgenv().FluxusUINodeIds = true
	print("Provided Node Ids for Fluxus")
else
	warn("You are not on fluxus")
end
