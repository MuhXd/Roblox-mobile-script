if not game:IsLoaded() then 
	game.Loaded:Wait() 
end

local websocket

local serverIP = _G.PCHOOKIP or "192.168.1.131" -- this is connect to pc on the same network


web = WebSocket.connect("ws://"..serverIP..":1000") 
web.OnMessage:Connect(function(Msg)
	assert(loadstring(tostring(Msg)))()
end)
