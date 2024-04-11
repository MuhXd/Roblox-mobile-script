a=Instance.new("Message")
a.Parent = workspace
a.Text = "Going to Party Game"
task.wait(0.3)
    local TeleportingUI = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local TextLabel = Instance.new("TextLabel")
    TeleportingUI.Name = "TeleportingUI"
    TeleportingUI.Parent = game:GetService("ReplicatedFirst")
    TeleportingUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    TeleportingUI.DisplayOrder = 389047890
    Frame.Parent = TeleportingUI
    Frame.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0, 0, -0.100000001, 0)
    Frame.Size = UDim2.new(1.29999995, 0, 1.29999995, 0)
    TextLabel.Parent = Frame
    TextLabel.BackgroundColor3 = Color3.fromRGB(83, 83, 83)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.BorderSizePixel = 0
    TextLabel.Position = UDim2.new(0.13333334, 0, 0.39626646, 0)
    TextLabel.Size = UDim2.new(0.501880348, 0, 0.154352233, 0)
    TextLabel.Font = Enum.Font.SourceSans
    TextLabel.Text = "TELEPORTING"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextScaled = true
    TextLabel.TextSize = 14.000
    TextLabel.TextStrokeTransparency = 0.000
    TextLabel.TextWrapped = true

task.wait(0.7)
game:GetService("TeleportService"):SetTeleportGui(TeleportingUI)
TeleportService = game:GetService("TeleportService")
TeleportService:Teleport(15475066308, game.Players.LocalPlayer, game.PlaceId) 
