--puts the sprite in the world
function create(spr) 
	spr.inert = false
	if spr.cat=="good" then
		add(good,spr)
	else
		add(bad,spr)
	end
end

--preps & returns the actual sprite
function spawn(spr_name)
	local spr=cpy_t(g_sprts[spr_name])
	spr.inert = true
	spr.id=uid()
	spr.height = spr.height or 1
	spr.life=spr.life or 1
	spr.atk=spr.atk or 1
	spr.efx={}
	spr.anim=nil
	spr.axn_ids={}
	--key/value: spr id & countdown till it can hit it again (prevent rapid multi-hits each frame). Only needed for good.
	spr.hit_list={}
	add(spr_add,spr)
	return spr
end

function despawn(spr)
	add(spr_del,spr)
	spr.inert=true
end

function delete(spr)
	kill_axn(spr)
	if (spr.anim_id) routines[spr.anim_id] = nil

	if spr.cat=="good" then
		del(good, spr)
	else
		del(bad,spr)
	end
end

function prep_prtcl(prtcl) 
	prtcl.type=prtcl.type or "circfill"
	prtcl.clr_range=prtcl.clr_range or {}
	prtcl.r=prtcl.r or 0
	prtcl.dx=prtcl.dx or 0
	prtcl.dy=prtcl.dy or 0
	prtcl.dr=prtcl.dr or 0
	prtcl.ddr=prtcl.ddr or 0
	return prtcl
end

function crtn_updt(arr,fx)
	foreach(arr,function(a)
		_ENV[fx](a)
	end)
	arr={}
end