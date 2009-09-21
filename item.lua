-- Sprint 1
-- Story "Item Class" 
-- and "Basic Character Action: Lift Stuff"
-- and "Game: Damage/Health"
-- Created by Chux


-- x and y sets position, 
-- width and height the size of the item
-- hp the "hitpoints"(health) it got
function createBox(x, y, width, height, hp)

	boxBody = love.physics.newBody( world_layer0, x, y );
	boxShape = love.physics.newRectangleShape(boxBody, width, height)
	boxShape:setData(#itemsShape+1);
	boxBody:setMassFromShapes();
	
	table.insert (itemsShape, boxShape);
	table.insert (itemsBody, boxBody);
	table.insert (itemsHitpoints, hp);	

end

function itemLoad()

	itemsBody = {};
	itemsShape = {};
	itemsHitpoints = {};

end


function itemDraw() 

	for i = 1, #itemsShape, 1 do
	
		-- Can't draw an item that has been destroyed(which it should have been if hitpoints drop below 1
		if itemsHitpoints[i] then	
			
			-- Draws the "boxcolored filling" 
			love.graphics.setColor( 180, 140, 100);
			love.graphics.polygon(love.draw_fill, itemsShape[i]:getPoints())

			-- Draws a border for the "filling"
			love.graphics.setColor( 0, 0, 0);
			love.graphics.polygon(love.draw_line, itemsShape[i]:getPoints())

		end

	end
	
end

function itemReceiveDmg(itemId, dmg)

	if itemsHitpoints[itemId] then	

		itemsHitpoints[itemId] = itemsHitpoints[itemId] - dmg;
		debugMsg("Item "..itemId.." lost "..dmg.." hps"); 

		if itemsHitpoints[itemId] <= 0 then

			itemsBody[itemId]:destroy();
			itemsShape[itemId]:destroy();
			debugMsg("Item "..itemId.." destroyed!");
			
			-- itemsHitpoints is set to false!!! THIS NEED TO BE KNOWN!!! Bad solution perhaps?
			itemsHitpoints[itemId] = false;
	
		end

	end

end

function itemRegainHp(itemId, hp)

	-- Bug, an item can regain more hp than it ever had
	itemsHitpoints[itemId] = itemsHitpoints[itemId] + hp;

end


function createTestItems()  -- used for testing purposes only

	local i=0;
	while i<5 do
		createBox(50+100*i,200-math.random(300),math.random(40)+5,math.random(40)+5,50);
		i=i+1;
	end

end
