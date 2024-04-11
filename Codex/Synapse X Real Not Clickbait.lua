local image = _G.CodexSpooferImage or 9524079125
local text = _G.CodexSpooferText or "Synapse X"
local powered = _G.CodexSpooferPoweredBy or "Powered by Nameless Admin"
local Uis = {

}
CodexUi = game:GetService("RunService"):IsStudio() and game.StarterGui.Codex or game:GetService("CoreGui"):WaitForChild("Codex")
if CodexUi:FindFirstChild("gui") then
-- codex
for i, v in pairs(CodexUi:GetChildren()) do
	v.Parent = game.CoreGui
	v:SetAttribute("Codex",true)
	table.insert(Uis,v)
end
else
	for i, v in pairs(game:GetService("CoreGui"):GetChildren()) do
		if v:GetAttribute("Codex") then
			table.insert(Uis,v)
		end
	end
end

function HideForever(object) 
	object.Visible = false
	object:GetPropertyChangedSignal("Visible"):Connect(function()
		object.Visible = false
	end)
end
HideForever(Uis.gui.fade)
Uis.gui.tabs.editor.contentContainer.inputBox.MultiLine = true
Uis.gui.navbar.floatingIcon.codexIcon2.Image = "http://www.roblox.com/asset/?id="..image
Uis.gui.navbar.main.codexIcon.Image = "http://www.roblox.com/asset/?id="..image
Uis.gui.navbar.main.title.Text = text
Uis.gui.navbar.main.title:GetPropertyChangedSignal("Text"):Connect(function()
	Uis.gui.navbar.main.title.Text = text
end)
Uis.gui.navbar.main.poweredBy:GetPropertyChangedSignal("Text"):Connect(function()
	Uis.gui.navbar.main.poweredBy.Text = powered
end)
Uis.gui.navbar.main.poweredBy.Text = powered
