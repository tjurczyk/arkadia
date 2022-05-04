function trigger_func_skrypty_misc_food_siadanie()
	local t={}
	table.insert(t,matches[3])
	local tsize=1
	if matches[2]~="" then
		local m=matches[2]:gsub(" czy", ",")
  	for s in string.gmatch(m, "(.-)(, )") do
  		table.insert(t, s)
			tsize=tsize+1
  	end
	end
	scripts.utils.bind_functional("usiadz " .. string.lower(t[math.random(tsize)]))
end


function trigger_func_skrypty_misc_food_usiadz()
    scripts.utils.bind_functional("usiadz")
end
