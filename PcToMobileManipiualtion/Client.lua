if not game:IsLoaded() then 
	game.Loaded:Wait() 
end

local websocket

local serverIP = _G.PCHOOKIP or "192.168.1.131" -- this is connect to pc on the same network


web = WebSocket.connect("ws://"..serverIP..":1000") 
web.OnMessage:Connect(function(Msg)
	assert(loadstring(tostring(Msg)))()
end)

print(" -- quick reminder that you can show the ip as it is a inhouse network ip so it won't be able to be connected to unless you are in the same network -- ")
print("Successfully Opened WebSocket at: "..serverIP)

local oldwarn; oldwarn = hookfunction(warn, function(...)
	args = {...}
	web.send("Warn: "..arg[1])
	return oldprint(...);
end);
local oldprint; oldprint = hookfunction(print, function(...)
	args = {...}
	web.send("Print: "..arg[1])
	return oldprint(...);
end);
