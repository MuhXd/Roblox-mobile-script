if not game:IsLoaded() then game.Loaded:Wait() end

local websocket


local success, connection = pcall(function()
    return WebSocket.connect("ws://localhost:1000") 
end)


if success and connection then
    websocket = connection
    websocket.OnMessage:Connect(function(msg)
        print("Received message: "..msg)
    end)
    print("WebSocket connected successfully.")
else
    print("Failed to connect to WebSocket server.")
    if not success then
        print("Error: "..tostring(connection))
    end
end
