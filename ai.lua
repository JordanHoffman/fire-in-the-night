function ai_base_bad(spr) 
	if (spr.inert) return
	if (spr.axn=="idle") axn_bad_go(spr)
	if spr.x <= melee_x and (spr.axn == "idle" or spr.axn == "go") then
		axn_bad_melee(spr)
	end
end