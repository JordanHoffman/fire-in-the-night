function good_hit(a,b)
	local waiter,atker = a,b
	if (b.axn == "wait") waiter=b atker=a

	--delete launch sword & create slash
	despawn(atker)
	axn_slash(mk_atk("p_slash",waiter))

	--refresh waiting sword
	clr_axn(waiter)
	axn_atk_wait(waiter)
end

function bad_hit(g,b)
	efx_good_hit(g)
	despawn(g)

	b.life-=1
	if b.life<=0 then
		despawn(b)
		sfx(4)
	else
		efx_dmg(b)
		sfx(2)
	end
end