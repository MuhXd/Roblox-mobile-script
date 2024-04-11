local image = _G.CodexSpooferImage or 9524079125
local text = _G.CodexSpooferText or "Synapse X"
local powered = _G.CodexSpooferPoweredBy or "Powered by Nameless Admin"
local gui = nil
CodexUi = game:GetService("RunService"):IsStudio() and game.StarterGui.Codex or game:GetService("CoreGui"):WaitForChild("Codex")
if CodexUi:FindFirstChild("gui") then
-- codex
for i, v in pairs(CodexUi:GetChildren()) do
	v.Parent = game.CoreGui
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

function HideForever(object) 
	object.Visible = false
	object:GetPropertyChangedSignal("Visible"):Connect(function()
		object.Visible = false
	end)
end

HideForever(gui.fade)
gui.tabs.editor.contentContainer.inputBox.MultiLine = true
gui.navbar.floatingIcon.codexIcon2.Image = "http://www.roblox.com/asset/?id="..image
gui.navbar.main.codexIcon.Image = "http://www.roblox.com/asset/?id="..image
gui.navbar.main.title.Text = text
gui.navbar.main.title:GetPropertyChangedSignal("Text"):Connect(function()
	gui.navbar.main.title.Text = text
end)
gui.navbar.main.poweredBy:GetPropertyChangedSignal("Text"):Connect(function()
	gui.navbar.main.poweredBy.Text = powered
end)
gui.navbar.main.poweredBy.Text = powered
