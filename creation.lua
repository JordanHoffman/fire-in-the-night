--puts the sprite in the world
function create(spr) 
	spr.inert = false
	if spr.cat=="good" then
		add(good,spr)
	else
		add(bad,spr)
	end
end

--creates & returns the actual sprite
function spawn(spr_name)
	local spr=cpy_t(g_sprts[spr_name])
	spr.inert = true
	spr.id=uid()
	spr.height = spr.height or 1
	spr.life=spr.life or 1
	spr.efx={}
	spr.anim=nil
	spr.axn_ids={}
	add(to_add,spr)
	return spr
end

function despawn(spr)
	add(to_del,spr)
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