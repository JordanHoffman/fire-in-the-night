--sprites - values are tables
dclr[[
g_sprts={

p1={
	type=p1,
	spr=0,
	row=1,
	y=72,
	x=8,
	anims={
		idle=p_idle
	},
	axn=idle,
	cat=good,
	height=2
},

p_sword={
	type=p_atk,
	atk=1,
	spr=3,
	cat=good
},

p_slash={
	type=p_atk,
	atk=1,
	spr=4,
	cat=good
},

bat={
	type=spr,
	spr=5,
	life=2,
	spd=0.75,
	anims={
		go=bat_go
	},
	cat=bad
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