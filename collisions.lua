function collided(g,b)
	if g.inert or b.inert or g.row != b.row or g.id == b.id or not cld_types[g.type][b.type] then
		return false
	end
	local tmr_cnt=g.hit_list[b.id] or 0
	if (tmr_cnt > 0) return false
	
	local g_left,g_right=min(g.prev_x,g.x),max(g.prev_x,g.x)
	local b_left,b_right=min(b.prev_x,b.x),max(b.prev_x,b.x)

	local hit = b_left+2 <= g_right+5 and b_right+5 >= g_left+2
	if (hit) g.hit_list[b.id]=hit_timer
	return hit
end

function good_hit(a,b)
	local waiter,atker = a,b
	if (b.axn == "wait") waiter=b atker=a

	--delete launch sword & create slash
	despawn(atker)
	if atker.name == "p_sword" then 
		axn_slash(mk_atk("p_slash",waiter))
	elseif atker.name=="p_shield" then
		axn_bash(mk_atk("p_bash",waiter))
	end
	
	--refresh waiting sword
	axn_atk_wait(waiter)
end

function bad_hit(g,b)
	efx_good_hit(g)
	b.life-=g.atk
	g.life-=b.atk
	if (g.push) axn_push(g,b)

	if b.life<=0 then
		despawn(b)
		sfx(4)
		efx_bad_explode(b)
	else
		if (g.atk > 0) efx_dmg(b)
		sfx(2)
	end
	if g.life<=0 then
		despawn(g)
	else
		if (b.atk > 0) efx_dmg(g)
	end
end