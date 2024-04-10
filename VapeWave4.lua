
-- credits to 7GrandDadPGN for vape v4.
loadstring(game:HttpGet("https://raw.githubusercontent.com/MuhXd/Roblox-mobile-script/main/FileFixes.lua"))();
loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()

task.spawn(function()
    local teleportConnection = game.Players.LocalPlayer.OnTeleport:Connect(function(State)
        if (not teleportedServers) then
    local queueonteleport = syn and syn.queue_on_teleport or queue_on_teleport or function() end
        queueonteleport([[
            if not game:IsLoaded() then
                game.Loaded:Wait()
            end
            loadstring(game:HttpGet("https://raw.githubusercontent.com/MuhXd/Roblox-mobile-script/main/FileFixes.lua"))();
            loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
            

        ]])
    end
    end)
end)
