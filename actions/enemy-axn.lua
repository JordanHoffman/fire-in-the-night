function axn_bad_go(spr)
	mk_axn(spr,function()
		c_move(spr,"x",melee_x,nil,spr.spd)
	end,"go")
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

function axn_bad_melee(spr)
	mk_axn(spr, {
		function()
			while true do
				c_wait(20)
				c_move(spr,"x", p1.x,3)
				c_move(spr,"x", melee_x,10)
			end
		end,
		function()
			while true do
				c_wait(20)
				c_move(spr,"y",get_rowy(spr,p1.row),3)
				c_move(spr,"y",get_rowy(spr,spr.row),10)
			end
		end
	},"melee")
end