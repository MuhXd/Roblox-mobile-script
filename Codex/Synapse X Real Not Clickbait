CodexUi = game:GetService("RunService"):IsStudio() and game.StarterGui.Codex or game:GetService("CoreGui").Codex
-- codex
CodexUi:WaitForChild("gui")
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
oldm = mouse.Icon
function HideForever(object) 
	object.Visible = false
	object:GetPropertyChangedSignal("Visible"):Connect(function()
		object.Visible = false
	end)
end
HideForever(CodexUi.gui.fade)
CodexUi:WaitForChild("gui"):WaitForChild("navbar")
CodexUi.gui.tabs.editor.contentContainer.inputBox.MultiLine = true
CodexUi.gui.navbar.floatingIcon.codexIcon2.Image = "http://www.roblox.com/asset/?id=9524079125"
CodexUi.gui.navbar.main.codexIcon.Image = "http://www.roblox.com/asset/?id=9524079125"
CodexUi.gui.navbar.main.title.Text = "Synapse X"
CodexUi.gui.navbar.main.title:GetPropertyChangedSignal("Text"):Connect(function()
	CodexUi.gui.navbar.main.title.Text = "Synapse X"
end)
CodexUi.gui.navbar.main.poweredBy:GetPropertyChangedSignal("Text"):Connect(function()
		CodexUi.gui.navbar.main.poweredBy.Text = "Powered by Nameless Admin"
end)
CodexUi.gui.navbar.main.poweredBy.Text = "Powered by Nameless Admin"
