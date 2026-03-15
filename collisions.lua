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
	despawn(g)

	b.life-=g.atk
	if (g.push) axn_push(g,b)
	if b.life<=0 then
		despawn(b)
		sfx(4)
	else
		if (g.atk > 0) efx_dmg(b)
		sfx(2)
	end
end