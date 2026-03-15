function axn_atk_launch(atk)
	mk_axn(atk,function()
		c_move(atk,"x",melee_x,4)
		c_atk_wait(atk)
		despawn(atk)
	end,"atk")
end

function axn_p1_atk_rcvr()
	mk_axn(p1,function()
		c_wait(5)
	end,"atk")
end

function axn_atk_wait(atk)
	mk_axn(atk,function()
		c_atk_wait(atk)
		despawn(atk)
	end,"wait")
end

--axn included here b/c this can be called midaction and needs to transition name
function c_atk_wait(atk)
	atk.axn="wait"
	c_wait(45)
end

function axn_slash(atk)
	mk_axn(atk,function()
		sfx(1)
		c_atk_go(atk)
	end,"atk")
end

--todo, make different sound
function axn_bash(atk)
	mk_axn(atk,function()
		sfx(1)
		c_atk_go(atk)
	end,"atk")
end

function c_atk_go(atk)
	c_move(atk,"x",atk.x+64,14)
	despawn(atk)
end

function efx_good_hit(spr)
	for i=1,10 do
		add(prtcls,{
			x=spr.x+4,
			y=spr.y+4,
			c=10,
			life=5,
			r=0,
			dx=rnd(2),
			dy=rnd(4) - 2
		})
	end
end

--shield bash
function axn_push(g,b)
	mk_axn(b,function()
		sfx(1)
		c_move(b,"x",b.x+g.push,nil,10)
		c_dizzy(b)
	end,"knockback")
end

function c_dizzy(spr)
	spr.axn = "dizzy"
	for i=1,5 do
		local type = flr(rnd(2)) == 1 and "circ" or "circfill"
		add(prtcls,{
			type=type,
			x=spr.x+2+flr(rnd(5)),
			y=spr.y-flr(rnd(3)),
			c=10,
			life=8,
			dx=0,
			r=1,
			dy=-0.25-rnd(0.25),
		})
		c_wait(10)
	end
end