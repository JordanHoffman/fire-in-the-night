function add_async(fx,id)
	routines[id] = cocreate(fx)
end

function rmv_async(id)
	routines[id]=nil
end

-- never use, only called by mk_axn
function add_axn(spr,fx,clear)
	local axn_id=uid()
	add(spr.axn_ids, axn_id)
	async_add[axn_id]=function()
		if (spr.inert) yield()
		fx()
		if (clear) clr_axn(spr)
	end
end

--can pass a single fx or an array of fx's if the axn needs multiple, but your longest axn MUST be first since it clears when finished
function mk_axn(spr, fx, name)
	kill_axn(spr,name)
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

function clr_axn(spr,name)
	spr.axn_ids={}
	spr.axn=name or "idle"
end

function kill_axn(spr,name)
	foreach(spr.axn_ids, function(id)
		async_del[id]=1
	end)
	clr_axn(spr,name)
end


--Effect Logic

function clr_efx(spr,name)
	foreach(spr.efx, function(efx)
		if (efx.name==name) efx=nil
	end)
end

function mk_efx(spr,fx,name)
	local id = uid()
	async_add[id]=function()
		fx()
		clr_efx(spr,name)
	end
	add(spr.efx, {name=name,id=id})
end

function has_efx(spr,name)
	for efx in all(spr.efx) do
		if (efx.name == name) return true
	end
	return false
end

function set_anim(spr,anim)
	if (spr.anim_id) async_del[spr.anim_id]=1
	spr.anim_id=uid()
	async_add[spr.anim_id]=function()
		c_anim(spr,g_anims[anim])
	end
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