
_G.CodexSpooferImage = 17108310457
_G.CodexSpooferText =  "Android Mod Menu"
_G.CodexSpooferPoweredBy ="Powered by HAPPY MOD"
loadstring(game:HttpGet("https://github.com/MuhXd/Roblox-mobile-script/blob/main/Codex/Synapse%20X%20Real%20Not%20Clickbait.lua?raw=true" ))();
local gui = _G.Codex_gui_Object or nil


if not gui then
	return warn("unable to find codex")
end

function ChangeIcon(object)
	object:WaitForChild("icon"):GetPropertyChangedSignal("ImageColor3"):Connect(function()
		if Color3.fromRGB(151, 158, 189) == object:WaitForChild("icon").ImageColor3 then
			object:WaitForChild("icon").ImageColor3 = Color3.fromRGB(0, 0, 0)
		else
			if 	object:WaitForChild("icon").ImageColor3 == Color3.fromRGB(0, 0, 0) then
				return;
			else
				object:WaitForChild("icon").ImageColor3 = Color3.fromRGB(33, 99, 0)
			end
		end
	end)
	object:WaitForChild("icon").ImageColor3 = Color3.fromRGB(0, 0, 0)
end
_G.Codex_gui_Object = gui
gui.navbar.floatingIcon.BackgroundColor3 = Color3.fromRGB(36, 102, 2)
gui.navbar.floatingIcon.codexIcon2.Image = "rbxassetid://17108310457"
gui.navbar.main.BackgroundColor3 = Color3.fromRGB(36, 102, 2)
gui.background.BackgroundColor3 = Color3.fromRGB(36, 102, 2)
for i,v in pairs(gui.navbar.main.container:GetChildren()) do
	if v:IsA("TextButton") then
		task.spawn(function()
			ChangeIcon(v)
		end)
	end
end
ChangeIcon(gui.navbar.main.settings)
-- codexIcon2
