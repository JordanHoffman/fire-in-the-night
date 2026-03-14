function axn_bad_go(spr)
	mk_axn(spr,function()
		spr.axn = "go"
		c_move(spr,"x",melee_x,false,spr.spd)
	end)
end

function efx_dmg(spr)
	mk_efx(spr,function()
		for i=1,2 do
			spr.dmgflash=true
			c_wait(2)
			spr.dmgflash=false
			c_wait(3)
		end
	end,"dmg_flash")
end