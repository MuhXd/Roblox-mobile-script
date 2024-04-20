
local l = {}
if game:GetService("RunService"):IsStudio() then
local Code = game:GetService("HttpService"):GetAsync('https://github.com/MuhXd/Roblox-mobile-script/blob/main/ColorModule/ColoredAreaModuleStudio.lua?raw=true')
l=loadstring(Code)
else
l = loadstring(game:HttpGet("https://github.com/MuhXd/Roblox-mobile-script/blob/main/ColorModule/ColoredAreaModuleExcutor.lua?raw=true"))();
end

return l
