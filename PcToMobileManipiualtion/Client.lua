if not game:IsLoaded() then game.Loaded:Wait() end
local websocket
repeat wait() until pcall(function() websocket = WebSocket.connect("ws://localhost:1000") end) == true


websocket.OnMessage:Connect(function(msg)
    print(msg)
end)


