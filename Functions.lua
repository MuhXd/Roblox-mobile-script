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

funcs.FileGetObjects = function(url)
      if (not FileSupport) then
        return error("Unable to create file - doesn't support File creating")
      end
      local req = game:HttpGet(url)
     writefile("Custom_Objects/"..url..".rsfsrb",req)
return game:GetObjects(Functions.GetAsset("Custom_Objects/"..url..".rsfsrb"))[1]
end
     
funcs.GetAssetFiles = function(url) 
   local req = game:HttpGet(url)
    writefile("Custom_Objects/"..url..".rsfsrb",req)
    return Functions.GetAsset("Custom_Objects/"..url..".rsfsrb")
end
