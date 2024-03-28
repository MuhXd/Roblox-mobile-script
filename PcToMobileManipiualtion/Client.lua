if not game:IsLoaded() then game.Loaded:Wait() end
local websocket
websocket = WebSocket.connect("ws://localhost:1000")


websocket.OnMessage:Connect(function(msg)
    print(msg)
end)

print("a")
