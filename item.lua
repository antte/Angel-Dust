-- Sprint 1
-- Story "Item Class" 
-- and "Basic Character Action: Lift Stuff"
-- and "Game: Damage/Health"
-- Created by Chux

function itemLoad()

	graphic_itemSofa = love.graphics.newImage("images/itemSofa.png", love.image_optimize);
	graphic_itemCrate = love.graphics.newImage("images/itemCrate1515.png", love.image_optimize);
	graphic_itemBasketball = love.graphics.newImage("images/itemBasketball.png", love.image_optimize);

	itemGraphic = {}

	-- Tweakable values
	constItemDmgAbsorb = 15; -- If damage dealt doesnt reach this minimum - no hitpoints are lost

end

-- x and y sets position, 
-- width and height the size of the item
-- hp the "hitpoints"(health) it got
function createBox(x, y, width, height, hp, graphic)

	boxBody = love.physics.newBody( world_layer0, x, y );
	boxShape = love.physics.newRectangleShape(boxBody, width, height)
	boxBody:setMassFromShapes();

	boxShape:setCategory(4);
	boxShape:setRestitution(0);
	
	addEntity(boxBody,boxShape,"item", hp);
	boxId = idOfLastCreatedEntity();	
	boxShape:setData(boxId);

	table.insert(itemGraphic, boxId, graphic);

end

function createBall(x, y, radius, hp, graphic)

	ballBody = love.physics.newBody( world_layer0, x, y );
	ballShape = love.physics.newCircleShape(ballBody, radius);
	ballBody:setMassFromShapes();

	ballShape:setCategory(4);
	ballShape:setRestitution(0.7);
	
	addEntity(ballBody,ballShape,"item", hp);
	ballId = idOfLastCreatedEntity();	
	ballShape:setData(ballId);

	table.insert(itemGraphic, ballId, graphic);

end

function itemDraw(i) 
	
	-- Can't draw an item that has been destroyed(which it should have been if hitpoints drop below 1
	if entityHitpoints[i] then	
			
		if itemGraphic[i] == "crate" then
			love.graphics.draw(graphic_itemCrate, entityBody[i]:getX(), entityBody[i]:getY(), entityBody[i]:getAngle());
		end
		if itemGraphic[i] == "sofa" then
			love.graphics.draw(graphic_itemSofa, entityBody[i]:getX(), entityBody[i]:getY(), entityBody[i]:getAngle());
		end	
		if itemGraphic[i] == "basketball" then
			love.graphics.draw(graphic_itemBasketball, entityBody[i]:getX(), entityBody[i]:getY(), entityBody[i]:getAngle());
		end	

	end
	
end

function itemReceiveDmg(itemId, dmg)

	if entityHitpoints[itemId] then	
		if dmg >= constItemDmgAbsorb then
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

end

function itemRegainHp(itemId, hp)

	-- Bug, an item can regain more hp than it ever had
	entityHitpoints[itemId] = entityHitpoints[itemId] + hp;

end


function createTestItems()  -- used for testing purposes only

	createBox(100,300,15,15,5000,"crate");
	createBox(150,300,35,11,5000,"sofa");
	--createBall(180,300,4,5000,"basketball");

end

function itemCollision(a,b,c)

	v = getVelocity(c);
	a = tonumber(a);
	power = getPower(v,entityBody[a]:getMass())

	if power > constGamePowerAbsorb then	

		itemReceiveDmg(a,power);

	end

end
