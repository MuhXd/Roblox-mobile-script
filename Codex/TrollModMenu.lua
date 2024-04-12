

local gui = _G.Codex_gui_Object or nil

if not gui then
	CodexUi = game:GetService("RunService"):IsStudio() and game.StarterGui.Codex or game:GetService("CoreGui"):WaitForChild("Codex")
	gui = CodexUi:FindFirstChild("gui")
if  gui == nil then
if CodexUi:FindFirstChild("gui") then
-- codex
for i, v in pairs(CodexUi:GetChildren()) do
	v:SetAttribute("Codex",true)
		if v.Name == "gui" then
			gui = v
		end
end
else
	for i, v in pairs(game:GetService("CoreGui"):GetChildren()) do
		if v:GetAttribute("Codex") then
			if v.Name == "gui" then
				gui = v
			end
		end
	end
	
	if not gui then
		for i, v in pairs(game:GetService("CoreGui"):GetChildren()) do
			if v.Name == "gui" then
				if v:FindFirstChild("tabs") then
					if v:FindFirstChild("exploitSettings") then
						gui = v
					end
				end
		end
	end
end
end
end
	
if not gui then
	return warn("unable to find codex")
end
end
_G.Codex_gui_Object = gui
gui.navbar.floatingIcon.BackgroundColor3 = Color3.fromRGB(36, 102, 2)
gui.navbar.floatingIcon.codexIcon2.Image = "rbxassetid://17108310457"
-- codexIcon2
