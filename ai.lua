function ai_base_bad(spr) 
	if (spr.inert) return
	if spr.x <= melee_x and spr.axn != "melee" then
		axn_bad_melee(spr)
	end
end