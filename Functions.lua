 local CustomFunctionSupport = isfile and isfolder and writefile and readfile and listfiles
 local FileSupport = isfile and isfolder and writefile and readfile
local Functions = {
    IsClosure = is_synapse_function or iskrnlclosure or isexecutorclosure,
    SetIdentity = (syn and syn.set_thread_identity) or set_thread_identity or setthreadidentity or setthreadcontext,
    GetIdentity = (syn and syn.get_thread_identity) or get_thread_identity or getthreadidentity or getthreadcontext,
    Request = (syn and syn.request) or http_request or request,
    QueueOnTeleport = (syn and syn.queue_on_teleport) or queue_on_teleport,
    GetAsset = getsynasset or getcustomasset,
}
local funcs = {}
if FileSupport then
 if not isfolder('Custom_Objects') then
 makefolder('Custom_Objects')
 end
end

function hash(input)
  -- Placeholder for a hashing function
  -- In practice, replace this with a proper hashing algorithm
  local sum = 0
  for i = 1, #input do
    local c = string.byte(input, i)
    sum = (sum + c) % 10000000000 -- Keeping the sum within 10 digits
  end
  return tostring(sum)
end

function shortenURL(url)
  local shortName = hash(url)
  return string.sub(shortName, 1, 10) -- Ensure the result is 10 characters long
end

funcs.GetAssetFiles = function(url) 
  if (not FileSupport) then
        return error("Unable to create file - doesn't support File creating")
      end
   local name = shortenURL(url)
   local req = game:HttpGet(url)
    writefile("Custom_Objects/"..name..".rsfsrb",req)
    return Functions.GetAsset("Custom_Objects/"..name..".rsfsrb")
end

funcs.FileGetObjects = function(url)
  if (not FileSupport) then
        return error("Unable to create file - doesn't support File creating")
  end
return game:GetObjects(funcs.GetAssetFiles(url))[1]
end

funcs.FileSetAudio = function(Sound,url)
   if Sound then
  s,r = pcall(function()
      Sound.SoundID = 0
      return true
   end)
   if s then
   return Sound.SoundID = funcs.GetAssetFiles(url)
  else
   error("Sound Doesn't Have SoundID")
  end
 else
   error("Sound Object is Invalid")
 end
  error("Unable to pass Sound Checks")
end

funcs.getuserinfo = function()
-- Gets User info
local UserInputService = game:GetService("UserInputService") 
local Platform = UserInputService:GetPlatform()
if Platform then
	Info = tostring(string.gsub(tostring(Platform), "Enum.Platform", ""))
end
if Info == "None" then
	s,r = 	pcall(function()
		local response = request({
			Url = "https://httpbin.org/user-agent",
			Method = "GET",
		})
		assert(type(response) == "table", "Response must be a table")
		assert(response.StatusCode == 200, "Did not return a 200 status code")
		local data = game:GetService("HttpService"):JSONDecode(response.Body)
		assert(type(data) == "table" and type(data["user-agent"]) == "string", "Did not return a table with a user-agent key")
		Info = data["user-agent"]
	end)
	if not s then
		Info = "Unable to find"
	end
end
if Info=="OSX" then
	Info = "MacOS"
end
if Info=="UWP" then
	Info = "Universal Windows Platform"
end
if Info=="IOS" then
	Info = "IPhone"
end
if Info=="NX" then
	Info = "Cisco Nexus"
end
return Info,game.Players.LocalPlayer.DisplayName,game.Players.LocalPlayer.Name,workspace:GetRealPhysicsFPS()
end

return funcs
