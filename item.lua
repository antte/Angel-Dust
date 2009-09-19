-- Sprint 1
-- Story "Item Class"
-- Created by Chux

function createBox(x, y, width, height)

	boxBody = love.physics.newBody( world_layer0, x, y );
	boxShape = love.physics.newRectangleShape(boxBody, width, height)
	boxShape:setData("item");
	boxBody:setMassFromShapes();
	
	table.insert (items, boxShape);
	
end

function itemLoad()

	items = {};

end


function itemDraw() 

	for i = 1, #items, 1 do
		love.graphics.setColor( 180, 140, 100);
		love.graphics.polygon(love.draw_fill, items[i]:getPoints())
		love.graphics.setColor( 0, 0, 0);
		love.graphics.polygon(love.draw_line, items[i]:getPoints())
	end
	
end

function createTestItems()  -- used for testing purposes only

	local i=0;
	while i<20 do
		createBox(200+math.random(500),200-math.random(300),math.random(40)+5,math.random(40)+5);
		i=i+1;
	end

end
