--[[
RULES:
- sprites should only ever be stored in good&bad. Nowhere else
- inert property only lasts for the frame before entering and before exiting
- call spawn or despawn, never manually add/remove
- axn_func and set_anim call fundamental mk_axn which calls async. Use these toplevels and never manual.
- mk_efx for effects. Sprite can only ever have 1 action, but unlimited effects.
- function with c_ are meant for coroutines and have yield
- never create other coroutines within a coroutine since they occur while being looped over.
]]

function _init()
	cls(1)

	dclr[[
	row_y={80,88,96},
	good={},
	bad={},
	to_del={},
	to_add={},
	routines={},
	bad_strt=130,
	melee_x=22,
	prtcls={},
	hit_timer=10
	]]

	p1=spawn"p1"
	set_anim(p1,p1.anims.idle)

	level=lvl_1

	map_init()
end

function _update()
	local row = p1.row
	local axn = p1.axn

	--INPUT HANLDING--
	--movement
	if btnp(2) and axn=="idle" and row > 1 then 
		axn_row_mv(p1,-1)
	elseif btnp(3) and axn=="idle" and row < 3 then 
		axn_row_mv(p1,1)
	end
	--attack
	if btnp(4) and axn=="idle" then
		local atk = mk_atk("p_sword",p1)
		axn_atk_launch(atk)
		sfx(3)
		axn_p1_atk_rcvr()
	end
	if btnp(5) and axn=="idle" then
		local atk = mk_atk("p_shield",p1)
		axn_atk_launch(atk)
		sfx(3)
		axn_p1_atk_rcvr()
	end

	function updt_prevx(arr)
		foreach(arr,function(a)
			a.prev_x=a.x
		end)
	end
	updt_prevx(good)
	updt_prevx(bad)


	--Coroutine Handling
	--RULE - all spawns and deletions happen here or before!
	for k,v in pairs(routines) do
		if costatus(v) == "dead" then
			routines[k] = nil
		else
			assert(coresume(v))
		end
	end

	--collision (inert checks repeated since a could become inert from a previous collision)
	for i=1,#good do
		local g=good[i]
		if (g.inert) goto cont
		for j=i+1,#good do
			local g2=good[j]
			if collided(g,g2) then
				good_hit(g,g2)
			end
		end
		for k=1,#bad do
			local b=bad[k]
			if collided(g,b) then
				bad_hit(g,b)
			end
		end
		::cont::
	end

	--ai & all other updates
	foreach(good,function(g)
		for k, v in pairs(g.hit_list) do
			if (v<=0) v=hit_timer
			v-=1
		end
	end)
	foreach(bad,function(b) 
		if (b.ai) then
			_ENV[b.ai](b)
		end
	end)

	--udpate particles
	foreach(prtcls,function(p)
		p.life-=1
		p.x+=p.dx
		p.y+=p.dy
		p.r+=p.dr
		if (p.life<=0) del(prtcls,p)
	end)

	-- --add/remove
	foreach(to_add,function(a)
		create(a)
	end)
	foreach(to_del,function(a)
		delete(a)
	end)
	to_add = {}
	to_del = {}

	map_update()
	update_lvl(level)
end

function _draw()
	cls()

	map_draw()

	foreach(good,function(a) 
		if (a.dmgflash) then
			for i=2,15 do
				pal(i,1)
			end
		end
		draw_spr(a)
	end)
	foreach(bad,function(a) 
		if (a.dmgflash) then
			for i=2,15 do
				pal(i,7)
			end
		end
		draw_spr(a) 
		pal()
	end)
	foreach(prtcls,function(p)
		p.type = p.type or "circfill"
		_ENV[p.type](p.x,p.y,p.r,p.c)
	end)

	foreach(logs,function(msg)
		? msg
	end)
end

function draw_spr(a)
	local height = a.height or 1
	spr(a.spr,a.x,a.y,1,height)
end

function get_rowy(sprt, row)
	return row_y[row] - (sprt.height - 1)*8
end