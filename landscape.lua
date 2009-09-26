--Sprint 1: Landscape
-- author: antte
--mark att gås på hus att gås på
--kom ihåg: setData

--<< Landscapespecific functions

function landscapeCreateHouse(houseTable, x, w, h, gh)
	--[[Description:
	Creates a simple house
	Input: the array to fill the house with ,xpos, width, height, groundheight
	Output: push the new house to the houseArray  
	]]--
	
	house = love.physics.newBody(world_layer0, 0, 0, 0) 
	house_shape = love.physics.newRectangleShape(house, x, love.graphics.getHeight() - (h/2) - (gh/2), w, h)
	house_shape:setData("house");

	table.insert (houseTable, house_shape)
	
end

--<< Callback functions

function landscapeLoad ()
	
	groundHeight = 50
	
	landscapeHouses = {}
	
	--Create newWorld(w,h)
	world_layer0 = love.physics.newWorld(2000,2000)
	world_layer0:setGravity(0, 100)
	
	--Create ground
	ground = love.physics.newBody(world_layer0, 0, 0, 0) --world, x, y, mass
	ground_shape = love.physics.newRectangleShape(ground, 1024/2, 768, 1024, groundHeight) -- x, y, w, h
	ground_shape:setData("ground");

	--Create house
	landscapeCreateHouse(landscapeHouses, 900, 233, 377, groundHeight)
	landscapeCreateHouse(landscapeHouses, 130, 233, 377, groundHeight)
	
	
end

function landscapeUpdate(dt_landscape)
	
	--Can't use dt because it somehow conflicts with the dt of main.lua
	--so i used dt_landscape instead.
	world_layer0:update(dt_landscape)
	
end

function landscapeDraw()
	
	love.graphics.setBackgroundColor(174,202,226)
	
	--Draws the ground
	love.graphics.setColor( 96, 119, 39)
	love.graphics.polygon(love.draw_fill, ground_shape:getPoints())
	
	--Draws the house
	love.graphics.setColor( 150, 50, 50)
	
	for i = 1, #landscapeHouses, 1 do
		love.graphics.polygon(love.draw_fill, landscapeHouses[i]:getPoints())
	end
	
end
