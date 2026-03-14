function dclr(string, table, istrimmed, i)
	table = table or _ENV
	string = istrimmed and string or cln(string)
	--key is a key for table entries, but is actually the value for array entries
	local i,key,val,isarr,islocal = i or 1,"","",true,false

	local function reset()
		isarr=true
		key=""
		val=""
	end

	local function assign()
		if not isarr then
			table[key] = pars(val)
		elseif key != "" then
			add(table,pars(key))
		end
	end

	while i <= #string do
		local current = sub(string,i,i) 
		if current == "," then
			assign()
			reset()
		elseif current == "=" then
			if (key == "local") islocal=true table={}
			isarr = false
		elseif current == "{" then
			local new = {}
			if not isarr then
				table[key] = new
			else
				add(table,new)
			end
			i=dclr(string,new,true,i+1)
			reset()
		elseif current == "}" then
			assign()
 			return i
		else
			if isarr then 
				key=key..current
			else
				val=val..current
			end
			if (i==#string) assign()
		end
		i+=1
	end
	return islocal and table["local"]
end
function pars(v)
	if (tonum(v) != nil) return tonum(v) 
	return v!="false" and v
end
function cln(s)
  local r = ""
  for i=1,#s do
    local c = sub(s,i,i)
    if c != "\n" and c != "\t" then
      r = r..c
    end
  end
  return r
end

--safe deep copy tbl (but children must be literals or table, no array)
function cpy_t(t)
	if type(t)=="table" then
		local ret_val={}
		for k,v in pairs(t) do
			v=cpy_t(v)
			ret_val[k]=v
		end
		return ret_val
	else
		return t
	end
end

--merge tables into new table, mutates "a" unless new is true
function mrg_t(a,b,new)
	if new then
		local t = {}
		for k,v in pairs(a) do t[k]=cpy_t(v) end
		for k,v in pairs(b) do t[k]=cpy_t(v) end
		return t
	else
		for k,v in pairs(b) do a[k]=cpy_t(v) end
	end
end

--merge arrays into new array, mutates "a" unless new is true
function mrg_a(a,b,new)
	if new then
		local t = {}
		for v in all(a) do add(t,v) end
		for v in all(b) do add(t,v) end
		return t
	else
		for v in all(b) do add(a,v) end
	end
end

id=0
function uid()
  id+=1
  return id
end

logs={}
function log(msg)
	add(logs,msg)
end