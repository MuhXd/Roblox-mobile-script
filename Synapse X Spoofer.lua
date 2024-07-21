local function RandomCharacters(length)
	if length > 0 then
		return RandomCharacters(length - 1) .. charset[rng:NextInteger(1, #charset)]
	else
		return ""
	end
end

if not SpoofingFrom then
	getgenv().SpoofingFrom = identifyexecutor
	getgenv()["_Is"..tostring(identifyexecutor()) ] = true
end
getgenv().identifyexecutor = function() return "Synapse X" end
function errorthrow(name)
	task.spawn(function()
		error("Unable to put "..name.."! doesn't have the function that does the same thing...")
	end)
	return nil
end


bit = {}

function bit.bdiv(dividend, divisor)
	return math.floor(dividend / divisor)
end
function bit.add(a, b)
	return a + b
end


function bit.sub(a, b)
	return a - b
end


function bit.band(val, by)
	return bit32.band(val, by)
end


function bit.bor(val, by)
	return bit32.bor(val, by)
end


function bit.bxor(val, by)
	return bit32.bxor(val, by)
end

function bit.bnot(val)
	return bit32.bnot(val)
end

function bit.mul(val, by)
	return val * by
end


function bit.swap(val)
	local result = 0
	for i = 1, 32 do
		result += bit32.lshift(bit32.band(val, 1), 31 - i)
		val = bit32.rshift(val, 1)
	end
	return result
end


function bit.ror(val, by)
	return bit32.rrotate(val, by)
end

function bit.rol(val, by)
	return bit32.lrotate(val, by)
end

function bit.tohex(val)
		return tonumber(string.format("%08x", val % 4294967296))
end

function bit.tobit(val)
	return tonumber(val)
end

function bit.lshift(val, by)
	return bit32.lshift(val, by)
end

function bit.rshift(val, by)
	return bit32.rshift(val, by)
end

function bit.arshift(val, by)
	return bit32.arshift(val, by)
end
local function c()
	local f=Instance.new("Folder");
	f.Name = RandomCharacters(Random.new():NextInteger(2, 40))
	f.Parent = game.Players.LocalPlayer.PlayerGui
	return f
end
local protection = game:GetService("CoreGui") or c()
local setthreadiden = set_thread_identity or setthreadidentity or setthreadcontext 
local functiontoreplace = {
	["is_beta"] = function()
		return true
	end,
	["is_synapse_function"] = (iskrnlclosure or isexecutorclosure or errorthrow("is_synapse_function")),
	["set_thread_identity"] = (setthreadiden or errorthrow("set_thread_identity")),
	["get_thread_identity"] =  (get_thread_identity or getthreadidentity or getthreadcontext or errorthrow("getthreadcontext")),
	["request"] = (http_request or request or  errorthrow("request")),
	["queue_on_teleport"] = (queue_on_teleport or errorthrow("queue_on_teleport") ),
	["websocket"] = WebSocket or websocket or Krnl.WebSocket or errorthrow("websocket"),
	["write_clipboard"] = setclipboard or toclipboard or errorthrow("write_clipboard"),
	["cache_replace"] = cache.replace or errorthrow("cache_replace"),
	["cache_invalidate"] =  cache.invalidate or errorthrow("cache_invalidate"),
	["is_cached"] = cache.iscached or errorthrow("is_cached"),
	["protect_gui"] = ProtectInstance or protection or errorthrow("protect_gui"),
	["unprotect_gui"] = UnProtectInstance or errorthrow("unprotect_gui"),
	["secure_call"] = secure_call or function(func, env, ...)
		assert(typeof(func) == "function", "bad argument to #1 to 'secure_call' (function expected, got "..typeof(func)..")")
		assert(typeof(env) == "Instance", "bad argument to #2 to 'secure_call' (Instance expected, got"..typeof(env)..")")
		assert(env.ClassName == "LocalScript" or env.ClassName == "ModuleScript", "bad argument to #2 to 'secure_call' (LocalScript or ModuleScript expected, got "..env.ClassName..")")
		return coroutine.wrap(function(...)
			if setthreadiden then
			setthreadiden(2)
			end
			setfenv(0, getsenv(env))
			setfenv(1, getsenv(env))
			return func(...)
		end)(...)
	end or errorthrow("secure_call")
}
function define(i,g)
	if not getgenv()[i] then
		getgenv()[i] = g
	end
end


do
	
	task.spawn(function()
		define("get_calling_script", getcallingscript or errorthrow("get_calling_script"))
		define("get_instances", getinstances or errorthrow("get_instances"))
		define("get_nil_instances", getnilinstances or errorthrow("get_nil_instances"))
		define("get_scripts", getscripts or errorthrow("get_scripts"))
		define("get_loaded_modules", getloadedmodules or errorthrow("get_loaded_modules"))
	end)
	
end
do
	local oldmt = getrawmetatable(game)
	task.spawn(function()
		define("htgetf", function(url)
			return game:HttpGetAsync(url)
		end or errorthrow("htgetf"))
		define("sethiddenprop", sethiddenproperty or errorthrow("sethiddenprop") )
	end)
	define("gbmt", function()
		return {
			__index = oldmt.__index,
			__namecall = oldmt.__namecall,
			__tostring = oldmt.__tostring
		}
	end or errorthrow("gbmt"))
	
end
task.spawn(function()
do -- syn_
	define("syn_getgenv", getgenv or errorthrow("syn_getgenv"))
	define("syn_getrenv", getrenv or errorthrow("syn_getrenv"))
	define("syn_getsenv", getsenv or errorthrow("getsenv"))
	define("syn_getmenv", getmenv or errorthrow("syn_getmenv"))
	define("syn_getreg", getreg or errorthrow("syn_getreg"))
	define("syn_getgc", getgc or errorthrow("syn_getgc"))
	define("syn_getinstances", getinstances  or errorthrow("syn_getinstances"))
	define("syn_context_get", getthreadcontext  or errorthrow("syn_context_get"))
	define("syn_context_set", setthreadcontext  or errorthrow("syn_context_set"))
	define("syn_setfflag", setfflag or errorthrow("syn_setfflag"))
	define("syn_dumpstring", getscriptbytecode or errorthrow("syn_dumpstring"))
	define("syn_islclosure", islclosure or errorthrow("syn_islclosure"))
	define("syn_checkcaller", checkcalleror or errorthrow("syn_checkcaller"))
	define("syn_clipboard_set", setclipboard or errorthrow("syn_clipboard_set"))
	define("syn_newcclosure", newcclosure or errorthrow("syn_newcclosure"))
	define("syn_decompile", decompile or errorthrow("syn_decompile"))
	define("syn_getloadedmodules", getloadedmodules  or errorthrow("syn_getloadedmodules"))
	define("syn_getcallingscript", getcallingscript or errorthrow("syn_getcallingscript"))
	define("syn_isactive", isrbxactive or errorthrow("syn_isactive"))
		define("syn_websocket_connect", function(a)
			local web = WebSocket or websocket or Krnl.WebSocket
			return web.connect(a)
	end or errorthrow("syn_websocket_connect"))
	define("syn_websocket_close", function(a)
		local mt = getmetatable(a)
		if mt and rawget(mt, "ClassName") == "WebSocket" then
			a:Close()
		end
	end or errorthrow("syn_websocket_close"))
	end
end)
task.spawn(function()
	do
		if SpoofingFrom() == "Solara" or not fireproximityprompt then -- proximity prompt fix | Credits: Benomat (https://scriptblox.com/u/benomat)
			getgenv().fireproximityprompt=function(pp)
				local oldenabled=pp.Enabled
				local oldhold=pp.HoldDuration
				local oldrlos=pp.RequiresLineOfSight
				pp.Enabled=true
				pp.HoldDuration=0
				pp.RequiresLineOfSight=false
				wait(.23)
				pp:InputHoldBegin()
				task.wait()
				pp:InputHoldEnd()
				wait(.1)
				pp.Enabled=pp.Enabled
				pp.HoldDuration=pp.HoldDuration
				pp.RequiresLineOfSight=pp.RequiresLineOfSight
			end
		end
		
	end
end)
task.spawn(function()
	do -- syn_ filesystem
	if not FileFixesLoaded then
		loadstring(game:HttpGet("https://github.com/MuhXd/Roblox-mobile-script/blob/main/FileFixes.lua?raw=true"))();
	end
	define("syn_io_read", readfile or errorthrow("syn_io_read"))
	define("syn_io_write", writefile or errorthrow("syn_io_write"))
	define("syn_io_append", appendfile or errorthrow("syn_io_append"))
	define("syn_io_makefolder", makefolder or errorthrow("syn_io_makefolder"))
	define("syn_io_listdir", listfiles  or errorthrow("syn_io_listdir"))
	define("syn_io_isfile", isfile  or errorthrow("syn_io_isfile"))
	define("syn_io_isfolder", isfolder  or errorthrow("syn_io_isfolder"))
	define("syn_io_delfile", delfile or errorthrow("syn_io_delfile"))
	define("syn_io_delfolder", delfolder or errorthrow("syn_io_delfolder"))
end
end)
syn = {}


	do

		local funcs, names, duplicates = {}, {}, {}
		function DescendantCount(tbl)
			local count = 0
			if type(tbl) ~= 'table' then return 1 end
			for i, v in pairs(tbl) do
				if type(v) == 'table' then
					count = count + DescendantCount(v) + 1
				else
					count = count + 1
				end
			end
			return count
		end
		function Descendants(tbl)
			local descendants = {}

			local function process_table(subtbl, prefix)
				for k, v in pairs(subtbl) do
					local index = prefix and (prefix .. "." .. tostring(k)) or tostring(k)
					if type(v) == 'table' then
						process_table(v, index)
					else
						descendants[index] = v
					end
				end
			end

			if type(tbl) ~= 'table' then
				descendants[tostring(1)] = tbl
			else
				process_table(tbl)
			end

			return descendants
		end


		funcs.base64 = {}
		funcs.crypt = {hex={},url={}}
		funcs.syn_backup = {}
		funcs.http = {}

		-- [[ Functions ]]
		funcs.clonefunction = function(a)
			return function(...)
				return a(...)
			end
		end
		funcs.cloneref = function(a)
			local s, _ = pcall(function() return a:Clone() end) return s and _ or a
		end
		funcs.deepclone = function(a)
			local Result = {}
			for i, v in pairs(a) do
				if type(v) == 'table' then
					Result[i] = funcs.deepclone(v)
				end
				Result[i] = v
			end
			return Result
		end

		--[[ The base64 functions were made by https://scriptblox.com/u/yofriendfromschool1 , Credits to him.]]
		funcs.base64.encode = function(data)
			local letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
			return ((data:gsub('.', function(x) 
				local r,b='',x:byte()
				for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
				return r;
			end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
				if (#x < 6) then return '' end
				local c=0
				for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
				return letters:sub(c+1,c+1)
			end)..({ '', '==', '=' })[#data%3+1])
		end
		funcs.base64.decode = function(data)
			local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
			data = string.gsub(data, '[^'..b..'=]', '')
			return (data:gsub('.', function(x)
				if x == '=' then return '' end
				local r, f = '', (b:find(x) - 1)
				for i = 6, 1, -1 do
					r = r .. (f % 2^i - f % 2^(i - 1) > 0 and '1' or '0')
				end
				return r;
			end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
				if #x ~= 8 then return '' end
				local c = 0
				for i = 1, 8 do
					c = c + (x:sub(i, i) == '1' and 2^(8 - i) or 0)
				end
				return string.char(c)
			end))
		end

		funcs.crypt.base64 = funcs.base64
		funcs.crypt.base64encode = funcs.base64.encode
		funcs.crypt.base64decode = funcs.base64.decode
		funcs.crypt.base64_encode = funcs.base64.encode
		funcs.crypt.base64_decode = funcs.base64.decode

		funcs.crypt.hex.encode = function(txt)
			txt = tostring(txt)
			local hex = ''
			for i = 1, #txt do
				hex = hex .. string.format("%02x", string.byte(txt, i))
			end
			return hex
		end
		funcs.crypt.hex.decode = function(hex)
			hex = tostring(hex)
			local text = ""
			for i = 1, #hex, 2 do
				local byte_str = string.sub(hex, i, i+1)
				local byte = tonumber(byte_str, 16)
				text = text .. string.char(byte)
			end
			return text
		end
		funcs.crypt.url.encode = function(a)
			return game:GetService("HttpService"):UrlEncode(a)
		end
		funcs.crypt.url.decode = function(a)
			a = tostring(a)
			a = string.gsub(a, "+", " ")
			a = string.gsub(a, "%%(%x%x)", function(hex)
				return string.char(tonumber(hex, 16))
			end)
			a = string.gsub(a, "\r\n", "\n")
			return a
		end
		funcs.crypt.generatekey = function(optionalSize)
			local key = ''
			local a = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
			for i = 1, optionalSize or 44 do local n = math.random(1, #a) key = key .. a:sub(n, n) end
			return funcs.base64.encode(key)
		end
		funcs.crypt.generatebytes = function(size)
			if type(size) ~= 'number' then return error('missing arguement #1 to \'generatebytes\' (number expected)') end
			return funcs.crypt.generatekey(size)
		end

		local active = true
		game:GetService("UserInputService").WindowFocused:Connect(function()
			active = true
		end)

		game:GetService("UserInputService").WindowFocusReleased:Connect(function()
			active = false
		end)

		funcs.isrbxactive = function()
			return active
		end

		funcs.isreadonly = function(tbl)
			if type(tbl) ~= 'table' then return false end
			return table.isfrozen(tbl)
		end
		funcs.setreadonly = function(tbl, cond)
			if cond then
				table.freeze(tbl)
			else
				return funcs.deepclone(tbl)
			end
		end
	

		syn.crypt = funcs.crypt
		syn.crypto = funcs.crypt

		for i, v in pairs(Descendants(funcs)) do
			if getgenv()[i] == nil then
				getgenv()[i] = v
			end
		end
		
	end

task.spawn(function()
do -- syn_ input
		define("mouse1press", mouse1down or nil) -- just in case
		define("mouse1release", mouse1up or nil)
		define("mouse2press", mouse2down or nil)
		define("mouse2release", mouse2up or nil )

		define("syn_mouse1click", mouse1click or errorthrow("syn_mouse1click") )
		define("syn_mouse1press", mouse1press or errorthrow("syn_mouse1press"))
		define("syn_mouse1release", mouse1release or errorthrow("syn_mouse1release"))

		define("syn_mouse2click", mouse2click or errorthrow("syn_mouse2click"))
		define("syn_mouse2press", mouse2press or errorthrow("syn_mouse2press"))
		define("syn_mouse2release", mouse2release or errorthrow("syn_mouse2release"))

		define("syn_mousescroll", mousescroll or errorthrow("syn_mousescroll"))
		define("syn_mousemoverel", mousemoverel or errorthrow("syn_mousemoverel"))
		define("syn_mousemoveabs", mousemoveabs or errorthrow("syn_mousemoveabs"))

		define("syn_keypress", keypress or errorthrow("syn_keypress"))
		define("syn_keyrelease", keyrelease or errorthrow("syn_keyrelease"))
	end
end)
do
	define("dumpstring", getscriptbytecode or errorthrow("dumpstring"))
end



function AddFunctionSyn(i)
	if syn[i] == nil then
		syn[i] = functiontoreplace[i]
	end
end

for i,v in pairs(functiontoreplace) do
	AddFunctionSyn(i)
end

local newcclose = newcclosure or function(func) return func() --[[sorry you cannot make a c in lua]] end

define("getsynasset",getcustomasset or errorthrow("getsynasset"))
define("isluau",true)
define("syn",syn)
define("bit",bit)
define("getinstancelist",newcclose(function() return game:GetDescendants() end))
local GetInstanceList = getinstancelist or game:GetDescendants()
define("getnilinstances",newcclose(function()
	local inst = GetInstanceList()
	local r = {}

	for i, v in pairs(inst) do
		if typeof(v) == "Instance" and v.Parent == nil then 
			r[#r + 1] = v 
		end
	end

	return r
end))
define("get_nil_instances",getnilinstances)
define("getinstances", newcclose(function()
	local inst = GetInstanceList()
	local r = {}

	for i, v in pairs(inst) do
		if typeof(v) == "Instance" then 
			r[#r + 1] = v 
		end
	end

	return r
end))
define("get_instances",getinstances)
define("newcclosure",newcclose)
define("get_instances", getinstances)
define("getscripts", newcclose(function()
	local inst = GetInstanceList()
	local r = {}

	for i, v in pairs(inst) do
		if typeof(v) == "Instance" and (v:IsA("LocalScript") or v:IsA("ModuleScript")) and not v.RobloxLocked then 
			r[#r + 1] = v 
		end
	end

	return r
end))


define("get_scripts", getscripts)


define("oldsaveinstance",saveinstance or nil)


function getcallingscriptff()
	local s = debug.info(1, 's')
	for i, v in next, game:GetDescendants() do
		if v:GetFullName() == s then return v end
	end
	return nil
end
function getinfo(thread)
	local CurrentLine = tonumber(debug.info(thread, 'l'))
	local Source = debug.info(thread, 's')
	local name = debug.info(thread, 'n')
	local numparams, isvrg = debug.info(thread, 'a')
	if #name == 0 then name = nil end
	local a, b = debug.info(thread, 'a')
	return {
		['currentline'] = CurrentLine,
		['Source'] = Source,
		['name'] = tostring(name),
		['numparams'] = tonumber(numparams),
		['is_vararg'] = isvrg and 1 or 0,
		['short_src'] = tostring(Source:sub(1, 60))
	}
end
define("debug",{})
if not debug.getinfo then
getgenv().debug.getinfo = getinfo
end
define("getcallingscript",newcclose(getcallingscriptff))
pcall(function()
	if _G.ReplaceInstance then
		getgenv().saveinstance = nil
	end
	loadstring(game:HttpGet("https://github.com/MuhXd/Roblox-mobile-script/blob/main/Arecus-X-Neo/Saveinstance.lua?raw=true"))();
	define("oldsaveinstance",saveinstance or nil)
end)
if not saveinstance then
	pcall(function()
		loadstring(game:HttpGet("https://github.com/MuhXd/Roblox-mobile-script/blob/main/Arecus-X-Neo/Saveinstance.lua?raw=true"))();
	end)
	if not saveinstance then
		getgenv().saveinstance = errorthrow("saveinstance")
		define("oldsaveinstance",saveinstance or nil)
	end
end

task.spawn(function()
	local teleportConnection = game.Players.LocalPlayer.OnTeleport:Connect(function(State)
		if (not teleportedServers) then
			local queueonteleport = syn and syn.queue_on_teleport
			queueonteleport([[
            if not game:IsLoaded() then
                game.Loaded:Wait()
            end
            loadstring(game:HttpGet("https://github.com/MuhXd/Roblox-mobile-script/blob/main/Synapse%20X%20Spoofer.lua?raw=true"))();
        ]])
		end
	end)
end)


