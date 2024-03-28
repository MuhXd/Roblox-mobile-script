if not game:IsLoaded() then 
    game.Loaded:Wait() 
end

local websocket

local serverIP = _G.Ip or "192.168.1.131" -- Replace this with the actual IP address of your WebSocket server
local serverPort = 1000


if not game:IsLoaded() then game.Loaded:Wait() end
local web
repeat wait() until pcall(function() web =  WebSocket.connect("ws://"..serverIP..":"..serverPort) end) == true

if not _G.autoran then
    web:Send("autoexec")
   _G.autoran = true 
end

web.OnMessage:Connect(function(msg)
    xpcall(loadstring(msg), warn)
end)
