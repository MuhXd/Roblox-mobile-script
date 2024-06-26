if not game:IsLoaded() then 
	game.Loaded:Wait() 
end

local websocket

local serverIP = _G.PCHOOKIP or "192.168.1.131" -- this is connect to pc on the same network


web = WebSocket.connect("ws://"..serverIP..":1000") 
web.OnMessage:Connect(function(Msg)
	assert(loadstring(tostring(Msg)))()
end)

print(" -- quick reminder that you can show the ip as it is a inhouse network ip so it won't be able to be connected to unless you are on the same network -- ")
print("Successfully Opened WebSocket at: "..serverIP)

local oldwarn; oldwarn = hookfunction(warn, function(t)
	web:Send("Warn: "..tostring(t))
	return oldwarn(t);
end);
local oldprint; oldprint = hookfunction(print, function(r)
	web:Send("Print: "..tostring(r))
	return oldprint(r);
end);
local olderror; olderror = hookfunction(error, function(r)
	web:Send("Error: "..tostring(r))
	return olderror(r);
end);
