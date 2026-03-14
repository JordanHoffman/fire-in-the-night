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

--Effect logic
parts={}
function efx_good_hit(spr)
	for i=1,10 do
		add(parts,{
			x=spr.x+4,
			y=spr.y+4,
			c=10,
			life=5,
			dx=rnd(2),
			dy=rnd(4) - 2
		})
	end
end

function updt_parts()
	foreach(parts,function(p)
		p.life-=1
		p.x+=p.dx
		p.y+=p.dy
		if (p.life<=0) del(parts,p)
	end)
end

function mk_atk(name,parent,x_offset)
	x_offset=x_offset or parent.cat == "good" and 4 or -4 
	local atk = spawn(name)
	mrg_t(atk,{row=parent.row,x=parent.x+x_offset,y=row_y[parent.row]})
	return atk
end


function mk_bat(row)
	local bat=spawn"bat"
	local jitter= -1 + flr(rnd(2))
	bat.y=row_y[row] + jitter
	bat.row=row
	bat.x=bad_strt
	set_anim(bat,bat.anims.go)
	axn_bad_go(bat)
end