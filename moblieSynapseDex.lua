 local CustomFunctionSupport = isfile and isfolder and writefile and readfile and listfiles
 local FileSupport = isfile and isfolder and writefile and readfile

if FileSupport then
 if not isfolder('Custom_Objects') then
 makefolder('Custom_Objects')
 end
end
function LoadFile(n,url)
        
if not isfile("Custom_Objects/"..n..".rsfsrb") then
     writefile("Custom_Objects/"..n..".rsfsrb",url)
 else
    appendfile("Custom_Objects/"..n..".rsfsrb",url)
 end
        
return game:GetObjects(readfile("Custom_Objects/"..n..".rsfsrb"))[1]

end
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
local Dex = LoadFile("MobileScaledVer-DEX","https://github.com/MuhXd/Roblox-mobile-script/blob/main/MobileScaledVer.rbxm?raw=true")
print(Dex)
if (not Dex) or Dex == "" then
warn("Cannot Load :(")
return;
end
Dex.Name = RandomCharacters(rng:NextInteger(5, 20))
Dex.Parent = game:GetService("CoreGui")
-- makes dex smaller for mobile
local UIScale = Instance.new("UIScale")
UIScale.Parent = Dex
UIScale.Scale = 0.700

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

