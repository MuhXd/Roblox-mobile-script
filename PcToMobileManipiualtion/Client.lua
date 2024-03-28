if not game:IsLoaded() then 
	game.Loaded:Wait() 
end

local websocket

local serverIP = _G.PCHOOKIP or "192.168.1.131" -- this is connect to pc on the same network
local serverPort = _G.PCHOOKPORT or 1000 -- opened port


local web
repeat wait() until pcall(function() web =  WebSocket.connect("ws://"..serverIP..":"..serverPort) end) == true

if not _G.PCHOOKautoran then
	--web:Send("autoexec")
	_G.PCHOOKautoran = true 
end

web.OnMessage:Connect(function(msg)
	assert(loadstring(tostring(msg)))()
end)
