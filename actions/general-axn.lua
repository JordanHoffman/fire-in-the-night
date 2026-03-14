function axn_row_mv(spr, dir)
	mk_axn(spr,{
		function()
			spr.axn="row_mv"
			c_move(p1,"y",get_rowy(spr,spr.row+dir),4)
		end,
		function()
			c_wait(2)
			spr.row +=dir
		end
	})
end