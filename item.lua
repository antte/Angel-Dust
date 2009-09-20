-- Sprint 1
-- Story "Item Class" and "Basic Character Action: Lift Stuff"
-- Created by Chux

function createBox(x, y, width, height)

	boxBody = love.physics.newBody( world_layer0, x, y );
	boxShape = love.physics.newRectangleShape(boxBody, width, height)
	boxShape:setData(#itemsShape);
	boxBody:setMassFromShapes();
	
	table.insert (itemsShape, boxShape);
	table.insert (itemsBody, boxBody);
end

function itemLoad()

	itemsBody = {};
	itemsShape = {};

end


function itemDraw() 

	for i = 1, #itemsShape, 1 do
		love.graphics.setColor( 180, 140, 100);
		love.graphics.polygon(love.draw_fill, itemsShape[i]:getPoints())
		love.graphics.setColor( 0, 0, 0);
		love.graphics.polygon(love.draw_line, itemsShape[i]:getPoints())
	end
	
end

function createTestItems()  -- used for testing purposes only

	local i=0;
	while i<5 do
		createBox(50+100*i,200-math.random(300),math.random(40)+5,math.random(40)+5);
		i=i+1;
	end

end
