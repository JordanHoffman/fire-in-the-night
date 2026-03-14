function axn_atk_launch(atk)
	mk_axn(atk,function()
		atk.axn = "atk"
		c_move(atk,"x",melee_x,4)
		atk_wait(atk)
		despawn(atk)
	end)
end

function axn_p1_atk_rcvr()
	mk_axn(p1,function()
		p1.axn="atk"
		c_wait(5)
	end)
end

function axn_atk_wait(atk)
	mk_axn(atk,function()
		atk_wait(atk)
		despawn(atk)
	end)
end

function atk_wait(atk)
	atk.axn="wait"
	c_wait(45)
end

function axn_slash(atk)
	mk_axn(atk,function()
		sfx(1)
		atk.axn="atk"
		c_move(atk,"x",atk.x+64,14)
		despawn(atk)
	end)
end