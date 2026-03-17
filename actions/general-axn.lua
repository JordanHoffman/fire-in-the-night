function axn_row_mv(spr, dir)
	mk_axn(spr,{
		function()
			c_move(p1,"y",get_rowy(spr,spr.row+dir),4)
		end,
		function()
			c_wait(2)
			spr.row +=dir
		end
	},"row_mv")
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