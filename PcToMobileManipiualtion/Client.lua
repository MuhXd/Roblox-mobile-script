if not game:IsLoaded() then game.Loaded:Wait() end

local websocket
local server = _G.PcConnectionIP or "192.168.1.131"

-- Attempt to connect to the WebSocket server
local success, connection = pcall(function()
    return WebSocket.connect("wss://"..server..":1000")
end)

-- Check if the connection was successful
if success and connection then
    websocket = connection
    websocket.OnMessage:Connect(function(msg)
        print(msg)
    end)
    print("WebSocket connected successfully.")
else
    print("Failed to connect to WebSocket server.")
    -- Output the error message
    if not success then
        print("Error: "..tostring(connection))
    end
end
