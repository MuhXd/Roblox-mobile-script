if not game:IsLoaded() then game.Loaded:Wait() end
local ws = syn and syn.websocket.connect or Krnl and Krnl.WebSocket.connect or WebSocket and WebSocket.connect or websocket and websocket.connect
local web
repeat wait() until pcall(function() web = ws("ws://localhost:1000") end) == true


web.OnMessage:Connect(function(msg)
    print(msg)
end)
