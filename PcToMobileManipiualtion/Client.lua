if not game:IsLoaded() then 
    game.Loaded:Wait() 
end

local websocket

local serverIP = _G.Ip or "192.168.1.131" -- Replace this with the actual IP address of your WebSocket server
local serverPort = 1000


web = WebSocket.connect("ws://" .. serverIP .. ":" .. serverPort) 
web.OnMessage:Connect(function(Msg)
    print(Msg) -- Print messages sent to SX.
end)
