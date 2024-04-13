
	_G.CodexSpooferImage = 17120020964
	_G.CodexSpooferText =  "Scriptware"
	_G.CodexSpooferPoweredBy ="Powered by FluxTeam"
	loadstring(game:HttpGet("https://github.com/MuhXd/Roblox-mobile-script/blob/main/Codex/Synapse%20X%20Real%20Not%20Clickbait.lua?raw=true" ))();

local gui = _G.Codex_gui_Object or nil


if not gui then
	return warn("unable to find codex")
end


function ChangeIcon(object)
	object:WaitForChild("icon"):GetPropertyChangedSignal("ImageColor3"):Connect(function()
		if Color3.fromRGB(151, 158, 189) == object:WaitForChild("icon").ImageColor3 then
			object:WaitForChild("icon").ImageColor3 = Color3.fromRGB(255, 255, 255)
		else
			if 	object:WaitForChild("icon").ImageColor3 == Color3.fromRGB(255, 255, 255) then
				return;
			else
				object:WaitForChild("icon").ImageColor3 = Color3.fromRGB(0, 128, 255)
			end
		end
	end)
	object:WaitForChild("icon").ImageColor3 = Color3.fromRGB(255, 255, 255)
end

_G.Codex_gui_Object = gui
gui.navbar.floatingIcon.BackgroundColor3 = Color3.fromRGB(0, 51, 102)
gui.navbar.floatingIcon.codexIcon2.Image = "rbxassetid://17120020964"

gui.navbar.main.BackgroundColor3 = Color3.fromRGB(0, 51, 102)
gui.navbar.main.BorderColor3 = Color3.fromRGB(0, 0, 127)
gui.navbar.main.BorderSizePixel = 3

gui.background.BackgroundColor3 = Color3.fromRGB(0, 51, 102)
gui.background.BorderColor3 = Color3.fromRGB(0, 0, 127)
gui.background.BorderSizePixel = 3
for i,v in pairs(gui.navbar.main.container:GetChildren()) do
	if v:IsA("TextButton") then
		task.spawn(function()
			ChangeIcon(v)
		end)
	end
end
for ic,cc in pairs(gui.tabs:GetChildren()) do
	if cc:FindFirstChild("buttons") then
	for i,v in pairs(cc.buttons:GetChildren()) do
	if v:IsA("TextButton") then
		task.spawn(function()
			ChangeIcon(v)
		end)
	end
	end
	end
end
ChangeIcon(gui.navbar.main.settings)
-- codexIcon2
