--sprites - values are tables
--type is meant for specific collision checking while cat is more general. Super specific is name. Everyone should have cat and type.
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
	life=2,
	anims={
		idle=p_idle
	},
	axn=idle,
	height=2
},

p_sword={
	type=p_atk,
	name=p_sword,
	cat=good,
	atk=2,
	spr=3,
	dur=45
},

p_shield={
	type=p_atk,
	name=p_shield,
	cat=good,
	life=3,
	atk=0,
	push=60,
	stun=60,
	spr=19,
	dur=90
},

p_slash={
	type=p_atk,
	name=p_slash,
	cat=good,
	spr=4,
},

p_bash={
	type=p_atk,
	name=p_bash,
	cat=good,
	atk=0,
	life=1,
	push=30,
	stun=30,
	spr=20
},

bat={
	type=bad_spr,
	cat=bad,
	spr=5,
	life=2,
	spd=0.75,
	spd=5,
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