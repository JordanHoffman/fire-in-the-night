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
	c_wait(atk.dur)
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
		add(prtcls,prep_prtcl({
			x=spr.x+4,
			y=spr.y+4,
			c=10,
			life=5,
			dx=rnd(2),
			dy=rnd(4) - 2
		}))
	end
end

--shield bash
function axn_push(g,b)
	mk_axn(b,function()
		sfx(1)
		c_move(b,"x",b.x+g.push,nil,10)
		if(g.stun) c_dizzy(b,g.stun)
	end,"knockback")
end

function c_dizzy(spr,time)
	spr.axn = "dizzy"
	for i=1,5 do
		local type = flr(rnd(2)) == 1 and "circ" or "circfill"
		add(prtcls,prep_prtcl({
			type=type,
			x=spr.x+2+flr(rnd(5)),
			y=spr.y-flr(rnd(3)),
			c=10,
			life=8,
			r=1,
			dy=-0.25-rnd(0.25)
		}))
		c_wait(time/5)
	end
end

function axn_dmg_p(bad)
	p1.life-=bad.atk
	if p1.life > 0 then
		efx_dmg(p1)
		mk_efx(p1,function()
			for i=1,10 do
				add(prtcls,prep_prtcl({
					type="circ",
					r=1,
					dr=4.5,
					ddr=-0.3-i/200,
					life=18,
					c=i&1==0 and 7 or 10,
					x=p1.x+4,
					y=row_y[p1.row]+4
				}))
				c_wait(1)
			end
		end,"nova")
		for i=1,3 do
			local nova = mk_atk("p_shield",p1)
			nova.spr=100
			nova.dur=5
			nova.life=1000
			nova.row=i
			nova.x=p1.x
			nova.y=row_y[i]
			axn_atk_launch(nova)
		end

		mk_efx(p1,function()
			c_wait(30)
		end,"invul")
	else
		efx_bad_explode(p1)
		despawn(p1)
	end
end