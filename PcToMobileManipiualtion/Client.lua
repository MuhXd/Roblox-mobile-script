if not game:IsLoaded() then 
    game.Loaded:Wait() 
end

local websocket

local serverIP = _G.PCHOOKIP or "192.168.1.131" -- Replace this with the actual IP address of your WebSocket server
local serverPort = _G.PCHOOKPORT or 1000


if not game:IsLoaded() then game.Loaded:Wait() end
local web
repeat wait() until pcall(function() web =  WebSocket.connect("ws://"..serverIP..":"..serverPort) end) == true

if not _G.autoran then
    web:Send("autoexec")
   _G.autoran = true 
end

web.OnMessage:Connect(function(msg)
    s,e = pcall(function()
       assert(loadstring(msg))()
    end)
    if not s then
    error(e)
    end
end)
