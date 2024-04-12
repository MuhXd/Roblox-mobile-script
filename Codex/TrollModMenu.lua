

local gui = _G.Codex_gui_Object or nil

if not gui then
	return warn("unable to find codex")
end

gui.navbar.floatingIcon.BackgroundColor3 = Color3.fromRGB(36, 102, 2)
gui.navbar.floatingIcon.codexIcon2.Image = "rbxassetid://17108310457"
-- codexIcon2
