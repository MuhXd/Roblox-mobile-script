local Params = {
	RepoURL = "https://raw.githubusercontent.com/luau/SynSaveInstance/main/",
	SSI = "saveinstance",
}
local synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()
local Options = {} -- All Options can be found here https://github.com/luau/UniversalSynSaveInstance/blob/main/saveinstance.lua#L772
synsaveinstance(Options)
