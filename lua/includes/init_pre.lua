_G.start_garbage = collectgarbage"count"

if SERVER then
	AddCSLuaFile("init.lua")
	AddCSLuaFile("init_pre.lua")
	AddCSLuaFile("init_post.lua")
end

-- is this still required?
if CLIENT then
	local col={r=255,g=255,b=255,a=255}
	_G.isthisbroken=print
	local MsgC=MsgC
	function print(...)
		local a={}
		for i=1,select('#',...) do
			local v=select(i,...)
			v=tostring(v) or "no value"
			a[i]=v
		
		end
		MsgC(col,table.concat(a,"\t")..'\n')
	end
end

local function registry_hack()
	-- debug.getregistry has been removed
	local _R_META = {}

	function _R_META:__index(key)
		if isstring(key) then return FindMetaTable(key) end
	end

	local _R = {} -- fake _R
	setmetatable(_R, _R_META)
	debug._getregistry = debug._getregistry or debug.getregistry

	local errored = false
	function debug.getregistry()
		if not errored and (SERVER or file.Exists("cfg/debug_registry.flag.cfg", "MOD")) then
			ErrorNoHaltWithStack("Something still uses debug.getregistry()")
		end

		return _R
	end
end

if not debug.getregistry or #debug.getregistry()==0 then
	registry_hack()
end

for k,v in pairs(file.Find("includes/enum/*.lua", "LUA")) do
	include("enum/"..v)
end


