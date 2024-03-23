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
     

return funcs
