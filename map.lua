function map_init()
	map_x=0
	map2_x=0
end

function map_update()
	map_x-=0.5
	map2_x-=0.2
	if map_x<-255 then map_x=0 end
	if map2_x<-255 then map2_x=0 end
end

function map_draw()
	--atmosphere
	pal(2,1)
	map(64,0,0,0,32,9)

	--background
	map(32,0,map2_x,0,32,16)
	map(32,0,map2_x + 256,0,32,16)
	pal()

	--foreground
	map(0,0,map_x,0,32,16)
	map(0,0,map_x + 256,0,32,16)
end