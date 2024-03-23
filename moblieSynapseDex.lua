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
local FileShortcuts = loadstring(game:HttpGet("https://github.com/MuhXd/Roblox-mobile-script/blob/main/Functions.lua?raw=true"))();
local rng = Random.new()
local charset = {}
for i = 48,  57 do table.insert(charset, string.char(i)) end
for i = 65,  90 do table.insert(charset, string.char(i)) end
for i = 97, 122 do table.insert(charset, string.char(i)) end
local function RandomCharacters(length)
  if length > 0 then
    return RandomCharacters(length - 1) .. charset[rng:NextInteger(1, #charset)]
  else
    return ""
  end
end

--local Dex = game:GetObjects("rbxassetid://9553291002")[1]
local Dex = FileShortcuts.FileGetObjects("https://github.com/MuhXd/Roblox-mobile-script/blob/main/MobileScaledVer.rbxm?raw=true")
Dex.Name = RandomCharacters(rng:NextInteger(5, 20))
Dex.Parent = game:GetService("CoreGui")


local function Load(Obj, Url)
local function GiveOwnGlobals(Func, Script)
    local Fenv = {}
    local RealFenv = {script = Script}
    local FenvMt = {}
    FenvMt.__index = function(a,b)
        if RealFenv[b] == nil then
            return getfenv()[b]
        else
            return RealFenv[b]
        end
    end
    FenvMt.__newindex = function(a, b, c)
        if RealFenv[b] == nil then
            getfenv()[b] = c
        else
            RealFenv[b] = c
        end
    end
    setmetatable(Fenv, FenvMt)
    setfenv(Func, Fenv)
    return Func
end

local function LoadScripts(Script)
    if Script.ClassName == "Script" or Script.ClassName == "LocalScript" then
        spawn(function()
            GiveOwnGlobals(loadstring(Script.Source, "=" .. Script:GetFullName()), Script)()
        end)
    end
    for i,v in pairs(Script:GetChildren()) do
        LoadScripts(v)
    end
end

LoadScripts(Obj)
end

Load(Dex)

