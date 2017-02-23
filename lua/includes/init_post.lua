local bad={}
local _include=include
local include=function(v) table.insert(bad,v) end
--------------- from init.lua ----------------

include ( "extensions/file.lua" )
include ( "extensions/angle.lua" )
include ( "extensions/debug.lua" )
include ( "extensions/entity.lua" )
include ( "extensions/ents.lua" )
include ( "extensions/math.lua" )
include ( "extensions/player.lua" )
include ( "extensions/player_auth.lua" )
include ( "extensions/string.lua" )
include ( "extensions/table.lua" )
include ( "extensions/util.lua" )
include ( "extensions/vector.lua" )
include ( "extensions/game.lua" )
include ( "extensions/motionsensor.lua" )
include ( "extensions/weapon.lua" )
include ( "extensions/coroutine.lua" )
include( "extensions/net.lua" )

if ( CLIENT ) then

	include ( "extensions/client/entity.lua" )
	include ( "extensions/client/globals.lua" )
	include ( "extensions/client/panel.lua" )
	include ( "extensions/client/player.lua" )
	include ( "extensions/client/render.lua" )

	require ( "search" )

end

------------------------------------------
-- fu
AddCSLuaFile"includes/extensions/file.lua"
------------------------------------------
include=_include

local files = file.Find("includes/extensions/*.lua", "LUA")
for k,v in pairs(files) do
	local str = "extensions/"..v
	if not table.HasValue(bad,str) then
		include("includes/"..str)
	end
end

local withjit=jit and jit.status and jit.status() and " (JIT On)" or " (JIT Off)"
Msg"[Lua] " print("GMod "..tostring(VERSIONSTR).." with "..tostring(jit and jit.version or "no LuaJit").." on "..(jit and jit.os or "??")..withjit)

local t={} for k,v in pairs(engine.GetGames()) do if v.installed and v.owned and v.mounted then table.insert(t,v.folder) end end
Msg"[Mounted] " print(table.concat(t," "))