--sprites - values are tables
dclr[[
cld_types={
	p1={},
	p_atk={p_atk=1,bad_spr=1},
	bad_spr={p_atk=1}
},

g_sprts={

p1={
	type=p1,
	cat=good,
	spr=0,
	row=1,
	y=72,
	x=8,
	anims={
		idle=p_idle
	},
	axn=idle,
	height=2
},

p_sword={
	type=p_atk,
	cat=good,
	atk=1,
	spr=3
},

p_slash={
	type=p_atk,
	cat=good,
	atk=1,
	spr=4,
},

bat={
	type=bad_spr,
	cat=bad,
	spr=5,
	life=2,
	spd=0.75,
	spd=1,
	anims={
		go=bat_go
	},
	ai=ai_base_bad
}

}

]]


--animations - values are arrays
dclr[[
g_anims={

p_idle={
{0,6},
{32,6},
{1,6},
{33,6}
},

bat_go={
{5,4},
{21,3},
{37,3},
{21,4}
}

}
]] 