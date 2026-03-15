function mk_atk(name,parent,x_offset)
	x_offset=x_offset or parent.cat == "good" and 4 or -4 
	local atk = spawn(name)
	mrg_t(atk,{row=parent.row,x=parent.x+x_offset,y=row_y[parent.row]})
	return atk
end

function mk_bat(row)
	local bat=spawn"bat"
	local jitter= -1 + flr(rnd(2))
	bat.y=row_y[row] + jitter
	bat.row=row
	bat.x=bad_strt
	set_anim(bat,bat.anims.go)
	axn_bad_go(bat)
end