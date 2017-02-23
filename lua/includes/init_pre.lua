_G.start_garbage = collectgarbage"count" -- let's see how much garry fucks us

if SERVER then
	AddCSLuaFile("init.lua")
	AddCSLuaFile("init_pre.lua")
	AddCSLuaFile("init_post.lua")
end

-- is this still required?
if CLIENT then
	local col={r=255,g=255,b=255,a=255}
	_G.isthisbroken=print
	_G.print=function(...)
		local a={}
		for i=1,select('#',...) do
			local v=select(i,...)
			v=tostring(v) or "no value"
			a[i]=v
		
		end
		MsgC(col,table.concat(a,"\t")..'\n')
	end
end

for k,v in pairs(file.Find("includes/enum/*.lua", "LUA")) do
	include("enum/"..v)
end


