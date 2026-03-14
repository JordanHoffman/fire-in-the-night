--[[
things needed:
- enemy
- row
- frequency

]]

--[[
total: amt of enemies
types: allowed enemy types
amt_odds: 3 entries totaling 100, odds for 1,2 or 3 enemies at once
freq: fastest to slowest spawn rate in frames
frm: timer for frames
]]

-- dclr[[
-- lvl_1={
-- total=20,
-- types={bat},
-- amt_odds={60,30,10},
-- freq={15,60}
-- }
-- ]]

dclr[[
lvl_1={
total=1,
types={bat},
amt_odds={100,0,0},
freq={15,60}
}
]]

function update_lvl(lvl)
	if (lvl.total <=0) return
	local freq,amt_odds = lvl.freq,lvl.amt_odds
	lvl.timer = lvl.timer or freq[1] + flr(rnd(freq[2] - freq[1]))
	local one,two,three,choice=amt_odds[1],amt_odds[2],amt_odds[3],flr(rnd(100))

	lvl.timer-=1
	if (lvl.timer != 0) return
	
	if choice <= one then
		--spawn 1
		local row = flr(rnd(3)) + 1
		mk_bat(row)
		lvl.total-=1
	elseif choice <= one + two then
		--spawn 2
		local row1=flr(rnd(3)) + 1
		local row2=row1
		repeat
			row2=flr(rnd(3)) + 1
		until row2!=row1
		mk_bat(row1)
		mk_bat(row2)
		lvl.total-=2
	else
		--spawn 3
		mk_bat(1)
		mk_bat(2)
		mk_bat(3)
		lvl.total-=3
	end

	lvl.timer = nil
end

