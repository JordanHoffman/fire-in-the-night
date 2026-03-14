function async(fx)
	local id = uid()
	routines[id] = cocreate(fx)
	return id
end

-- never use, only called by mk_axn
function add_axn(spr,fx,clear)
	add(spr.axn_ids, async(function()
		if (spr.inert) yield()
		fx()
		if (clear) clr_axn(spr)
	end))
end

--can pass a single fx or an array of fx's if the axn needs multiple, but your longest axn MUST be first since it clears when finished
function mk_axn(spr, fx)
	kill_axn(spr)
	local clear=true
	if type(fx)=="table" then
		foreach(fx, function(func)
			add_axn(spr,func,clear)
			clear=false
		end)
	else
		add_axn(spr,fx,true)
	end
end

function clr_axn(spr)
	spr.axn_ids={}
	spr.axn="idle"
end

--NEVER call within actions.
function kill_axn(spr)
	foreach(spr.axn_ids, function(id)
		routines[id] = nil
	end)
	clr_axn(spr)
end


--Effect Logic

function clr_efx(spr,name)
	foreach(spr.efx, function(efx)
		if (efx.name==name) efx=nil
	end)
end

function mk_efx(spr,fx,name)
	local id = async(function()
		fx()
		clr_efx(spr,name)
	end)
	add(spr.efx, {name=name,id=id})
end

function set_anim(spr,anim)
	if (spr.anim_id) routines[spr.anim_id] = nil
	spr.anim_id=async(function()
		c_anim(spr,g_anims[anim])
	end)
end

function c_move(obj,key,val,frames,speed,timing)
	local init=obj[key]
	frames=frames or 30

	if speed then
		frames=flr(abs(val-init)/speed)
	end
	timing = timing or linear
		
	for i=1,frames do
		obj[key]=lerp(init,val,timing(i/frames))
		yield()
	end
end

--animate sprite frames
function c_anim(obj,anim)
	local i=1
	while true do
		local length=anim[i][2]
		for j=1,length do
			--update actual sprite
			obj.spr=anim[i][1]
			if (j==length) i+=1
			if (i>#anim) i=1
			yield()
		end
	end
end

function c_wait(frames)
	for i=1,frames do
		yield()
	end
end

function linear(t)
	return t
end

function lerp(a,b,t)
	return a+(b-a)*t
end