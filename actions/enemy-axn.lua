function axn_bad_go(spr)
	mk_axn(spr,function()
		c_move(spr,"x",melee_x,nil,spr.spd)
	end,"go")
end

function axn_bad_melee(spr)
	mk_axn(spr, {
		function()
			while true do
				c_wait(20)
				c_move(spr,"x", p1.x,3)
				axn_dmg_p(spr)
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

function efx_bad_explode(spr)

	local parts=dclr[[
	local={
	{
	big_offset=1,
	c=1,
	life=15,
	r=4,
	dr=-0.1
	},

	{
	c=10,
	life=10,
	r=4,
	dr=-0.2
	},

	{
	c=1,
	life=15,
	r=3,
	dr=-0.1
	},

	{
	c=7,
	life=10,
	r=3,
	dr=-0.2
	},

	{
	big_offset=1,
	c=1,
	life=15,
	r=1,
	},

	{
	big_offset=1,
	c=7,
	life=10,
	r=1,
	},

	{
	big_offset=1,
	c=10,
	life=10,
	r=1,
	}

	}
	]]
	foreach(parts,function(p)
		p.y=p.big_offset and get_rowy(spr,spr.row)+1+flr(rnd(6)) or get_rowy(spr,spr.row)+2+flr(rnd(3))
		p.x=p.big_offset and spr.x+1+flr(rnd(6)) or spr.x+2+flr(rnd(3))
		p.dx=-0.25+rnd(0.5)
		p.dy=-0.25+rnd(0.5)
		add(prtcls,prep_prtcl(p))
	end)
end