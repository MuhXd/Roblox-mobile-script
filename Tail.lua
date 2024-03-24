-- https://tracker.vendetta.rocks/tracker/download/222112/base
local function newplayer(char)
	local item 
	local TweenService = game:GetService("TweenService")
	for i,v in pairs(char:GetChildren()) do
		if string.find(v.Name:lower(),"tail") then
			item = v	
		end
	end
	if not item then
		return
	end
	local M6D = Instance.new("Motor6D")
	M6D.Parent = item.Handle
	M6D.Part0 = item.Handle.AccessoryWeld.Part0
	M6D.Part1 = item.Handle.AccessoryWeld.Part1
	local o = item.Handle.AccessoryWeld.C0.Position
	M6D.C0 = CFrame.new(o) * CFrame.Angles(0,50,0)
	item.Handle.AccessoryWeld:Destroy()
	while task.wait() do
		local TweenService = game:GetService("TweenService")
		local tweenIn = TweenService:Create(M6D, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0), {C0 = CFrame.new(o) * CFrame.Angles(0,50,0) })
		local tweenOut = TweenService:Create(M6D, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0), {C0 = CFrame.new(o) * CFrame.Angles(0,-50,0) })
		tweenIn:Play()
		wait(2)
		tweenOut:Play()
		wait(2)
	end
end
game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
	newplayer(char)
end)
if game.Players.LocalPlayer.Character then
	newplayer(game.Players.LocalPlayer.Character) 
end
