--Sprint 1: Landscape
-- author: antte
--mark att gås på hus att gås på
--kom ihåg: setData

--<< Landscapespecific functions

function landscapeCreateHouse(x, w, h, gh)
	--[[Description:
	Creates a simple house
	Input: the array to fill the house with ,xpos, width, height, groundheight
	Output: push the new house to the houseArray  
	]]--
	--local y = love.graphics.getHeight() - (h/2) - (gh/2)

	rooftop = love.physics.newBody(world_layer0, 0, 0, 0) 
	rooftop_shape = love.physics.newRectangleShape(rooftop, x, love.graphics.getHeight() - (gh/2) - h, w, 1)
	rooftop_shape:setData("platform");
	-- This is for the "platform"-bit
	rooftop_shape:setCategory(2);

	house = love.physics.newBody(world_layer0, 0, 0, 0) 
	house_shape = love.physics.newRectangleShape(house, x, love.graphics.getHeight() - (h/2) - (gh/2), w, h)
	house_shape:setData("house");
	house_shape:setCategory();

	table.insert (landscapeHouseRoof, rooftop_shape)
	table.insert (landscapeHouse, house_shape)

end

--<< Callback functions

function landscapeLoad ()
	
	groundHeight = 50
	
	landscapeHouseRoof = {}
	landscapeHouse = {}
	
	--Create newWorld(w,h)
	world_layer0 = love.physics.newWorld(2000,2000)
	world_layer0:setGravity(0, 100)
	
	--Create ground
	ground = love.physics.newBody(world_layer0, 0, 0, 0) --world, x, y, mass
	ground_shape = love.physics.newRectangleShape(ground, 1024/2, 768, 1024, groundHeight) -- x, y, w, h
	ground_shape:setData("ground");

	-- Create borders
	borderleft = love.physics.newBody(world_layer0, 0, 0, 0) --world, x, y, mass
	borderleft_shape = love.physics.newRectangleShape(borderleft, -2, 768/2, 2, 768) -- x, y, w, h

	borderright = love.physics.newBody(world_layer0, 0, 0, 0) --world, x, y, mass
	borderright_shape = love.physics.newRectangleShape(borderright, 1026, 768/2, 2, 768) -- x, y, w, h

	--Create house
	landscapeCreateHouse(900, 200, 400, groundHeight)
	landscapeCreateHouse(130, 200, 200, groundHeight)
	
	
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
	
	for i = 1, #landscapeHouse, 1 do
		love.graphics.setColor( 150, 50, 50)
		love.graphics.polygon(love.draw_fill, landscapeHouse[i]:getPoints())
		love.graphics.setColor( 50, 25, 25)
		love.graphics.polygon(love.draw_fill, landscapeHouseRoof[i]:getPoints())
	end
	
end
