if not game:IsLoaded() then game.Loaded:Wait() end
local websocket
local server = _G.PcConnectionIP or 192.168.1.131
websocket = WebSocket.connect(server..":1000")


websocket.OnMessage:Connect(function(msg)
    print(msg)
end)

print("a")
