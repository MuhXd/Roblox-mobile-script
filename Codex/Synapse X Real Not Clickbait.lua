local image = _G.CodexSpooferImage or 9524079125
local text = _G.CodexSpooferText or "Synapse X"
local powered = _G.CodexSpooferPoweredBy or "Powered by Nameless Admin"
CodexUi = game:GetService("RunService"):IsStudio() and game.StarterGui.Codex or game:GetService("CoreGui"):WaitForChild("Codex")
local gui = _G.Codex_gui_Object or CodexUi:FindFirstChild("gui")
if not gui then
warn("unable to find codex")
end
_G.Codex_gui_Object = gui
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
