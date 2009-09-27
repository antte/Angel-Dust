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
	boxBody:setMassFromShapes();

	boxShape:setRestitution(0);
	
	addEntity(boxBody,boxShape,"item", hp);
	boxId = idOfLastCreatedEntity();	
	boxShape:setData(boxId);

end

function itemDraw(i) 
	
	-- Can't draw an item that has been destroyed(which it should have been if hitpoints drop below 1
	if entityHitpoints[i] then	
			
		-- Draws the "boxcolored filling" 
		love.graphics.setColor( 180, 140, 100);
		love.graphics.polygon(love.draw_fill, entityShape[i]:getPoints())

		-- Draws a border for the "filling"
		love.graphics.setColor( 0, 0, 0);
		love.graphics.polygon(love.draw_line, entityShape[i]:getPoints())

		love.graphics.setColor( 0, 0, 0)
		love.graphics.draw(i, entityBody[i]:getX(), entityBody[i]:getY());
		
	end
	
end

function itemReceiveDmg(itemId, dmg)

	if entityHitpoints[itemId] then	

		entityHitpoints[itemId] = entityHitpoints[itemId] - dmg;
		debugMsg("Item "..itemId.." lost "..dmg.." hps"); 

		if entityHitpoints[itemId] <= 0 then

--			entityBody[itemId]:destroy();
--			entityShape[itemId]:destroy();
			entityType[itemId]="destroyed";
			entityBody[itemId]:setX(9999);
			entityBody[itemId]:setY(9999);

			debugMsg("Item "..itemId.." destroyed!");

			if characterItemBeingHold == itemId then

				characterReleaseItem();

			end
			
			-- itemsHitpoints is set to false!!! THIS NEED TO BE KNOWN!!! Bad solution perhaps?
			entityHitpoints[itemId] = false;
	
		end

	end

end

function itemRegainHp(itemId, hp)

	-- Bug, an item can regain more hp than it ever had
	entityHitpoints[itemId] = entityHitpoints[itemId] + hp;

end


function createTestItems()  -- used for testing purposes only
	math.randomseed(os.time());	
	local i=0;
	while i<5 do
		createBox(50+40*i,300,math.random(30)+10,math.random(30)+10,5000);
		i=i+1;
	end

end

function itemCollision(a,b,c)

	v = checkVelocity(c);

	-- If a is actually a number - and so an entity
	if tonumber(a) ~= nil then

		a = tonumber(a);
		power = math.floor(((entityBody[a]:getMass()/2) * v)/1000)
		if power >= 9 then	

			itemReceiveDmg(a,power);

		end
	end

	-- if b is actually a number - and so an entity
--[[	if tonumber(b) ~= nil then
		b = tonumber(b);
		power = math.floor(((entityBody[b]:getMass()/2) * v)/100000)
		if power >= 9 then
			itemReceiveDmg(b,power);

			debugMsg(a.."&"..b.." b received dmg");
		end	

	end
]]--

end
